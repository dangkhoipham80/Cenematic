#!/usr/bin/env bash
# Ad-hoc end-to-end check of the register / forgot-password flows.
# Starts Tomcat, drives the flows with curl, then stops Tomcat.
#
#   bash .claude/skills/run-app/scripts/smoke-auth.sh
#
# Requires the SQL Server container from docker-compose.yml to be healthy.
# Override DB_PORT / APP_PORT if the defaults clash.
set -u

APP_PORT="${APP_PORT:-8082}"
DB_PORT="${DB_PORT:-1434}"
RMI_PORT="${RMI_PORT:-8405}"
B="http://localhost:${APP_PORT}/Cenematic"
JAR=$(mktemp -d)/cookies.txt

pass=0
fail=0
check() { # check <label> <haystack-file> <needle>
    if grep -qF -- "$3" "$2"; then
        echo "  PASS  $1"
        pass=$((pass + 1))
    else
        echo "  FAIL  $1  (expected to find: $3)"
        fail=$((fail + 1))
    fi
}
refute() {
    if grep -qF -- "$3" "$2"; then
        echo "  FAIL  $1  (should NOT contain: $3)"
        fail=$((fail + 1))
    else
        echo "  PASS  $1"
        pass=$((pass + 1))
    fi
}

sql() {
    MSYS_NO_PATHCONV=1 docker exec cenematic-db /opt/mssql-tools18/bin/sqlcmd \
        -S localhost -U sa -P 'Cenematic@2024' -C -d CENEMATIC -h -1 -W -Q "$1" 2>/dev/null \
        | head -1 | tr -d '\r'
}

echo "== starting Tomcat =="
# cargo:run, not cargo:start: a detached container is reaped as soon as the
# Maven JVM exits, so keep Maven alive as a child of this script instead.
mvn -o package cargo:run -Ddb.port="$DB_PORT" -Dapp.port="$APP_PORT" \
    -Dcargo.rmi.port="$RMI_PORT" > /tmp/cargo-start.log 2>&1 &
MVN_PID=$!
trap 'kill $MVN_PID 2>/dev/null' EXIT
for _ in $(seq 1 40); do
    [ "$(curl -s -o /dev/null -w '%{http_code}' "$B/login.jsp")" = "200" ] && break
    sleep 2
done
if [ "$(curl -s -o /dev/null -w '%{http_code}' "$B/login.jsp")" != "200" ]; then
    echo "Tomcat did not come up; see /tmp/cargo-start.log"
    tail -20 /tmp/cargo-start.log
    exit 1
fi

STAMP=$(date +%s)
USER="smoke$STAMP"
MAIL="smoke$STAMP@example.com"
sql "DELETE FROM account WHERE email LIKE 'smoke%@example.com'" > /dev/null

echo
echo "== register: server-side validation =="
curl -s -X POST "$B/UserController" \
    -d btAction=register -d userName=ab -d password=123 -d passwordAgain=456 \
    -d firstname= -d lastname=Nguyen -d address= -d phoneNumber=12345 \
    -d email=notanemail > /tmp/t1.html
check "rejects short username"   /tmp/t1.html "4-50 characters"
check "rejects weak password"    /tmp/t1.html "at least 8 characters"
check "rejects bad phone"        /tmp/t1.html "10 digits starting with 0"
check "rejects bad email"        /tmp/t1.html "valid email address"
check "rejects blank first name" /tmp/t1.html "Enter your first name."
check "requires the terms box"   /tmp/t1.html "accept the cinema&#39;s terms"
refute "no account was created"  /tmp/t1.html "Your account is created"

echo
echo "== register: mismatched passwords =="
curl -s -X POST "$B/UserController" \
    -d btAction=register -d userName="$USER" -d password=Password1 -d passwordAgain=Password2 \
    -d firstname=Khoi -d lastname=Pham -d address=Hanoi -d phoneNumber=0912345678 \
    -d email="$MAIL" -d agreeTerms=true > /tmp/t2.html
check "rejects mismatch" /tmp/t2.html "Passwords do not match."

echo
echo "== register: happy path =="
curl -s -X POST "$B/UserController" \
    -d btAction=register -d userName="$USER" -d password=Password1 -d passwordAgain=Password1 \
    -d firstname=Khoi -d lastname=Pham -d address=Hanoi -d phoneNumber=0912345678 \
    -d email="$MAIL" -d agreeTerms=true -d agreeMails=true > /tmp/t3.html
check "lands on the confirmation page" /tmp/t3.html "Your account is created"
[ "$(sql "SELECT COUNT(*) FROM account WHERE accountname='$USER'")" = "1" ] \
    && { echo "  PASS  row inserted"; pass=$((pass + 1)); } \
    || { echo "  FAIL  row inserted"; fail=$((fail + 1)); }
[ "$(sql "SELECT CAST(receive_email AS int) FROM account WHERE accountname='$USER'")" = "1" ] \
    && { echo "  PASS  'email me' checkbox was saved"; pass=$((pass + 1)); } \
    || { echo "  FAIL  'email me' checkbox was saved"; fail=$((fail + 1)); }
STORED=$(sql "SELECT password FROM account WHERE accountname='$USER'")
[ "$STORED" != "Password1" ] && [ -n "$STORED" ] \
    && { echo "  PASS  password stored hashed"; pass=$((pass + 1)); } \
    || { echo "  FAIL  password stored hashed (got '$STORED')"; fail=$((fail + 1)); }

echo
echo "== register: duplicates rejected =="
curl -s -X POST "$B/UserController" \
    -d btAction=register -d userName="$USER" -d password=Password1 -d passwordAgain=Password1 \
    -d firstname=Khoi -d lastname=Pham -d address=Hanoi -d phoneNumber=0912345678 \
    -d email="$MAIL" -d agreeTerms=true > /tmp/t4.html
check "duplicate username" /tmp/t4.html "That username is taken."
check "duplicate email"    /tmp/t4.html "already uses this email"

echo
echo "== account confirmation link =="
UID_=$(sql "SELECT id_account FROM account WHERE accountname='$USER'")
CODE=$(sql "SELECT verificationcode FROM account WHERE accountname='$USER'")
curl -s "$B/UserController?btAction=confirm&maKhachHang=$UID_&maXacThuc=000000" > /tmp/t5.html
check "wrong code refused" /tmp/t5.html "not valid"
curl -s "$B/UserController?btAction=confirm&maKhachHang=$UID_&maXacThuc=$CODE" > /tmp/t6.html
check "right code confirms" /tmp/t6.html "You&#39;re all set"
[ "$(sql "SELECT CAST(authentication AS int) FROM account WHERE accountname='$USER'")" = "1" ] \
    && { echo "  PASS  account marked confirmed"; pass=$((pass + 1)); } \
    || { echo "  FAIL  account marked confirmed"; fail=$((fail + 1)); }

echo
echo "== forgot password =="
rm -f "$JAR"
curl -s -c "$JAR" -b "$JAR" -X POST "$B/ForgotPasswordServelet" \
    -d "Email=nobody-$STAMP@example.com" > /tmp/t7.html
check "unknown email gets the same page" /tmp/t7.html "Enter your code"
refute "does not reveal non-existence"   /tmp/t7.html "does not exist"

rm -f "$JAR"
curl -s -c "$JAR" -b "$JAR" -X POST "$B/ForgotPasswordServelet" -d "Email=$MAIL" > /tmp/t8.html
check "known email gets the code page" /tmp/t8.html "Enter your code"
check "address is masked"              /tmp/t8.html "sm*"

RCODE=$(sql "SELECT verificationcode FROM account WHERE accountname='$USER'")
[ -n "$RCODE" ] && [ "$RCODE" != "NULL" ] \
    && { echo "  PASS  reset code issued"; pass=$((pass + 1)); } \
    || { echo "  FAIL  reset code issued"; fail=$((fail + 1)); }

curl -s -c "$JAR" -b "$JAR" -X POST "$B/CheckCodeServelet" -d "Code=000000" > /tmp/t9.html
check "wrong code counted" /tmp/t9.html "attempts left"

curl -s -c "$JAR" -b "$JAR" -X POST "$B/CheckCodeServelet" -d "Code=$RCODE" > /tmp/t10.html
check "right code reaches step 3" /tmp/t10.html "Choose a new password"
[ "$(sql "SELECT ISNULL(verificationcode,'NULL') FROM account WHERE accountname='$USER'")" = "NULL" ] \
    && { echo "  PASS  code burned after use"; pass=$((pass + 1)); } \
    || { echo "  FAIL  code burned after use"; fail=$((fail + 1)); }

echo
echo "== choose a new password =="
curl -s -c "$JAR" -b "$JAR" -X POST "$B/ResetPasswordServlet" \
    -d "password=short" -d "passwordAgain=short" > /tmp/t11.html
check "weak new password refused" /tmp/t11.html "at least 8 characters"

curl -s -c "$JAR" -b "$JAR" -o /tmp/t12.html -w "%{redirect_url}\n" -X POST "$B/ResetPasswordServlet" \
    -d "password=Brandnew99" -d "passwordAgain=Brandnew99" > /tmp/redir.txt
check "redirects to sign in" /tmp/redir.txt "login.jsp"
NEWHASH=$(sql "SELECT password FROM account WHERE accountname='$USER'")
[ "$NEWHASH" != "$STORED" ] && [ "$NEWHASH" != "Brandnew99" ] \
    && { echo "  PASS  new password stored hashed"; pass=$((pass + 1)); } \
    || { echo "  FAIL  new password stored hashed (got '$NEWHASH')"; fail=$((fail + 1)); }

curl -s -c "$JAR" -b "$JAR" "$B/login.jsp" > /tmp/t13.html
check "success flash shown once" /tmp/t13.html "password has been updated"
curl -s -c "$JAR" -b "$JAR" "$B/login.jsp" > /tmp/t14.html
refute "flash cleared on reload" /tmp/t14.html "password has been updated"

echo
echo "== sign in with the new password =="
curl -s -c "$JAR" -b "$JAR" -o /dev/null -w "%{redirect_url}\n" -X POST "$B/UserController" \
    -d btAction=login -d "UserName=$USER" -d "Password=Brandnew99" > /tmp/t15.txt
check "correct password -> index" /tmp/t15.txt "index.jsp"

rm -f "$JAR"
curl -s -c "$JAR" -b "$JAR" -o /dev/null -X POST "$B/UserController" \
    -d btAction=login -d "UserName=$USER" -d "Password=Password1"
curl -s -c "$JAR" -b "$JAR" "$B/login.jsp" > /tmp/t16.html
check "old password rejected with a message" /tmp/t16.html "Incorrect username or password"

echo
echo "== reset pages are not reachable directly =="
rm -f "$JAR"
curl -s -c "$JAR" -b "$JAR" -o /dev/null -w "%{redirect_url}\n" "$B/authenticate.jsp" > /tmp/t17.txt
check "authenticate.jsp redirects" /tmp/t17.txt "forgotpassword.jsp"
curl -s -c "$JAR" -b "$JAR" -o /dev/null -w "%{redirect_url}\n" "$B/resetpassword.jsp" > /tmp/t18.txt
check "resetpassword.jsp redirects" /tmp/t18.txt "forgotpassword.jsp"
curl -s -c "$JAR" -b "$JAR" -X POST "$B/ResetPasswordServlet" \
    -d "password=Hijack123" -d "passwordAgain=Hijack123" > /tmp/t19.html
check "reset without a verified code refused" /tmp/t19.html "Reset your password"

echo
sql "DELETE FROM account WHERE email LIKE 'smoke%@example.com'" > /dev/null
kill $MVN_PID 2>/dev/null
wait $MVN_PID 2>/dev/null

echo "== $pass passed, $fail failed =="
[ "$fail" -eq 0 ]
