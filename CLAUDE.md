# Cinematic — notes for Claude Code

Online cinema ticket booking system: **JSP + Servlets (javax, Servlet 3.1) on Tomcat 9**,
**SQL Server** for storage, built with **Maven**. Originally a semester-4 FPT University
project, since modernised to build and run on a current JDK.

## Running it

```sh
docker compose up -d                 # SQL Server, healthcheck-gated
mvn package cargo:run                # downloads Tomcat 9 and deploys
```

App at <http://localhost:8081/Cenematic/>. Both ports are overridable:
`-Dapp.port=8080`, and `DB_PORT=1434 docker compose up -d` + `-Ddb.port=1434`.
Seeding the schema is a one-time `docker exec ... sqlcmd -i /db/schema.sql`; see the README.

A **local SQL Server already on 1433 silently wins over the container** and shows up as
`Login failed for user 'sa'`. Publish the container on another port instead.

Emails (account confirmation, password reset codes) only send when `MAIL_USER` and
`MAIL_PASSWORD` are set in the environment — otherwise `Utils.Email` logs and returns
`false`. Code paths must treat "not sent" as a normal outcome, not an error.

## Layout

| Path | What |
| --- | --- |
| `src/java/Controller` | One servlet per action. `UserController` / `AdminController` are front controllers that dispatch on a `btAction` request parameter. |
| `src/java/DAO` | Hand-written JDBC. Every method opens and closes its own `Connection`. |
| `src/java/DTO` | Plain data holders mirroring table rows. |
| `src/java/Utils` | `MaHoa` (password hashing), `Email`, `Validate`, `VerificationCode`, `AppUrl`. |
| `web/` | JSPs at the root, `css/`, `js/`, `img/`. `web/WEB-INF/web.xml` maps most servlets. |
| `db/schema.sql` | Schema + seed data. |

`pom.xml` overrides the source directory to `src/java` and the web root to `web/` — the
NetBeans layout, not the Maven standard one.

## Conventions worth matching

- **Servlet registration is split.** Most servlets are declared in `web/WEB-INF/web.xml`;
  a few use `@WebServlet`. Adding a servlet means picking one — don't do both.
- **Naming is bilingual.** Older identifiers and comments are Vietnamese
  (`khachHang`, `soNgauNhien`, `maHoa`); newer code is English. Follow the file you're in.
  Several classes are spelled `...Sevelet` rather than `Servlet`; that's load-bearing in
  `web.xml`, so don't "fix" it casually.
- **User-facing copy is English; email bodies are Vietnamese** (HTML-entity encoded).
- Passwords are SHA-1 + fixed salt via `Utils.MaHoa.toSHA1`, stored in
  `account.password nvarchar(50)`. Anything that writes a password must hash first —
  logins compare hashes, so an unhashed write silently locks the account out.
- Column widths are tight (`email varchar(50)`, `firstname nvarchar(20)`,
  `phonenumber char(10)`). Validate lengths in `Utils.Validate` before insert, or SQL
  truncation errors surface as blank pages.

## Account flows

Registration → `UserController?btAction=register` → `RegisterSevelet` → `registered.jsp`,
emailing a 24-hour confirmation link handled by `AuthenticateSevelet` → `notify.jsp`.

Password reset is three steps, and each one keeps its state in the session
(`resetEmail`, `resetAttempts`, `resetVerifiedUserId` — the keys are constants on
`ForgotPasswordServelet`):

1. `forgotpassword.jsp` → `ForgotPasswordServelet` mails a 6-digit code.
2. `authenticate.jsp` → `CheckCodeServelet` verifies it.
3. `resetpassword.jsp` → `ResetPasswordServlet` stores the new password.

The account being reset is always read from the session, never from a form field, and
codes expire via `account.effectivetime` (a `Timestamp`) — see `Utils.VerificationCode`.

`success.jsp` is the generic "saved" page shared by the payment and change-information
flows; don't repurpose it.

## Frontend

Account pages (`login`, `register`, `forgotpassword`, `authenticate`, `resetpassword`,
`registered`, `notify`) are standalone: **no Bootstrap**, just `web/css/auth.css` and
`web/js/auth.js`. Every other page still loads Bootstrap 5 from a CDN and shares
`header.jsp` / `footer.jsp`.

`auth.js` is progressive enhancement only — each form must still submit and validate
server-side with JavaScript disabled.

## Gotchas

- `web.xml` declares `RegisterController`, `ChangePasswordController` and
  `ChangeInformationController`, none of which exist in `src/`. They fail on first
  access, not at startup. Pre-existing; nothing routes to them.
- A `RequestDispatcher.forward("")` on an unset `url` variable renders as a 500. Several
  servlets were written that way; always give `url` a real default.
- `request.setAttribute` does not survive `response.sendRedirect`. Use a session-scoped
  flash (`flashError` / `flashMessage`, read and removed by `login.jsp`).
