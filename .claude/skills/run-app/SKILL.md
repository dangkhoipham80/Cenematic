---
name: run-app
description: Start the Cinematic web app locally, drive it with curl, and take screenshots of pages. Use when asked to run, start, or preview the app, to check a change works in the real app, or to screenshot a JSP. Covers the port conflicts, the database seeding step, and the process-reaping gotcha that makes the obvious commands fail.
---

# Running Cinematic locally

JSP + Servlets on Tomcat 9, SQL Server in Docker, built with Maven.

## 1. Database

```sh
docker compose ps          # is cenematic-db already up and healthy?
docker compose up -d       # if not
```

Seeding is one-time. Check before doing it — re-running is slow and destructive:

```sh
MSYS_NO_PATHCONV=1 docker exec cenematic-db /opt/mssql-tools18/bin/sqlcmd \
  -S localhost -U sa -P 'Cenematic@2024' -C -h -1 -W \
  -Q "SELECT COUNT(*) FROM CENEMATIC.dbo.account"
```

If that errors, load the schema:

```sh
MSYS_NO_PATHCONV=1 docker exec cenematic-db /opt/mssql-tools18/bin/sqlcmd \
  -S localhost -U sa -P 'Cenematic@2024' -C -b -i /db/schema.sql
```

`MSYS_NO_PATHCONV=1` is required on Git Bash, otherwise `/opt/...` is rewritten
into a Windows path.

**Check which port the container actually publishes** (`docker compose ps`). It is
often 1434, not the 1433 default, because a local SQL Server may already hold 1433 —
and if one does, it silently wins and you get `Login failed for user 'sa'`.

## 2. Tomcat — the gotcha

`mvn package cargo:run` is what the README documents, and it is right for a human
in a terminal. It does **not** work for scripted verification here:

- `cargo:start` (detached) returns success, then the Tomcat JVM is reaped within
  seconds of Maven exiting. The port goes dead before you can curl it.
- A backgrounded `cargo:run` gets reaped between tool calls the same way.

So **start Tomcat and do all the checking inside one shell invocation**, keeping
Maven alive as a child of that shell:

```sh
mvn -o package cargo:run -Ddb.port=1434 -Dapp.port=8082 -Dcargo.rmi.port=8405 \
    > /tmp/cargo.log 2>&1 &
MVN_PID=$!
trap 'kill $MVN_PID 2>/dev/null' EXIT
for _ in $(seq 1 40); do
    [ "$(curl -s -o /dev/null -w '%{http_code}' http://localhost:8082/Cenematic/login.jsp)" = 200 ] && break
    sleep 2
done
# ... curl the app here ...
kill $MVN_PID
```

Pick ports that are free: `-Dapp.port` for HTTP and `-Dcargo.rmi.port` for
Cargo's control channel. `8205` is the default RMI port and is frequently taken by
a previous run.

### When Tomcat refuses to start

- *"configuration dir must point to an empty directory"* or *"webapps/manager is
  not a directory"* — a previous `mvn clean` half-deleted the container. Kill any
  stray Tomcat, then `rm -rf target/cargo` and start again.
- *"Device or resource busy"* on `target/cargo/...` — a Tomcat JVM is still holding
  the jars:

```sh
powershell.exe -NoProfile -Command "Get-CimInstance Win32_Process -Filter \"Name='java.exe'\" | Where-Object { \$_.CommandLine -like '*apache-tomcat*' } | Select-Object ProcessId"
powershell.exe -NoProfile -Command "Stop-Process -Id <pid> -Force"
```

### Stale classes

If a page 500s with `java.lang.Error: Unresolved compilation problems`, an IDE
language server has overwritten `target/classes` with a broken incremental build.
Maven's own output is fine — force it:

```sh
rm -rf target/classes && mvn -o package
grep -qa "Unresolved compilation" target/classes/Controller/SomeServlet.class && echo STALE
```

Avoid `mvn clean` while Tomcat is running; it breaks the Cargo install (above).

## 3. Verifying the account flows

`scripts/smoke-auth.sh` drives register, email confirmation, forgot password,
code entry, password reset and sign-in against a real database, then cleans up
the accounts it made. It handles Tomcat start/stop itself:

```sh
bash .claude/skills/run-app/scripts/smoke-auth.sh          # defaults: app 8082, db 1434
APP_PORT=8090 DB_PORT=1433 bash .claude/skills/run-app/scripts/smoke-auth.sh
```

It prints one PASS/FAIL line per assertion and exits non-zero if any failed.
Extend it rather than writing one-off curl chains.

## 4. Screenshots

The browser tools cannot open `file:` URLs, and the Tomcat process will not
survive between tool calls — so capture the rendered HTML first, then serve it
statically:

1. In a single shell invocation, start Tomcat as above and `curl` each page into
   `/tmp/preview/`. Drive POSTs with a cookie jar (`curl -c jar -b jar`) to reach
   pages that need session state, such as `authenticate.jsp` and `resetpassword.jsp`.
2. Copy `web/css`, `web/js` and any referenced images alongside, then rewrite the
   absolute context paths: `sed -i 's#/Cenematic/css#css#g; s#/Cenematic/js#js#g; s#/Cenematic/img#img#g' /tmp/preview/*.html`
3. Serve it: `cd /tmp/preview && python -m http.server 8099` (backgrounded — a
   plain static server does survive between tool calls).
4. Navigate to `http://localhost:8099/<page>.html` and screenshot. Check 1280px
   and 390px widths.

Clean up afterwards: the screenshot tool writes PNGs and a `.playwright-mcp/`
directory into the repository root, and neither belongs in a commit.
