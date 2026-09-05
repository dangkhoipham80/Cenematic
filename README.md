# Cinematic — Online Cinema Ticket Booking System

A web-based cinema ticket booking system built with **JSP + Servlets** on Tomcat, backed by **SQL Server**.
Visitors can browse films, pick showtimes and seats, and book tickets; administrators manage films,
screening sessions, users, comments and bills from an admin panel.

Originally built as a semester-4 Java Servlet/JSP project at FPT University. The build has since been
modernised so it runs on a current JDK with a single Maven command — see [Quick start](#quick-start).

---

## Quick start

Requirements: **JDK 11+**, **Maven 3.6+**, and **Docker** (for the database).

```sh
# 1. Start SQL Server
docker compose up -d

# 2. Wait for it to report healthy
docker compose ps

# 3. Create the database and load the seed data
docker exec cenematic-db /opt/mssql-tools18/bin/sqlcmd \
  -S localhost -U sa -P 'Cenematic@2024' -C -b -i /db/schema.sql

# 4. Build and run — downloads Tomcat 9 automatically
mvn package cargo:run
```

Then open **<http://localhost:8081/Cenematic/>**.

> On Git Bash for Windows, prefix the `docker exec` line with `MSYS_NO_PATHCONV=1` so the
> `/opt/...` paths aren't rewritten into Windows paths.

Press `Ctrl+C` to stop Tomcat; `docker compose down` stops the database
(add `-v` to also drop the data volume).

### Port conflicts

Both ports are configurable, which matters if you already run Tomcat or a local SQL Server:

| What | Default | Override |
| --- | --- | --- |
| Web app | `8081` | `mvn package cargo:run -Dapp.port=8080` |
| SQL Server | `1433` | `DB_PORT=1434 docker compose up -d` then `mvn package cargo:run -Ddb.port=1434` |

A **local SQL Server instance already listening on 1433 will silently win over the container**, and
you'll see `Login failed for user 'sa'`. Publish the container on another port as shown above.

---

## Configuration

`DBUtil` and `Email` read settings from environment variables (falling back to JVM system properties,
then to the defaults below), so no credentials need to be edited into the source.

| Variable | Default | Purpose |
| --- | --- | --- |
| `DB_HOST` | `localhost` | SQL Server host |
| `DB_PORT` | `1433` | SQL Server port |
| `DB_NAME` | `CENEMATIC` | Database name |
| `DB_USER` | `sa` | Database user |
| `DB_PASSWORD` | `Cenematic@2024` | Database password (matches `docker-compose.yml`) |
| `MAIL_USER` | _(empty)_ | Gmail address used to send verification mail |
| `MAIL_PASSWORD` | _(empty)_ | Gmail **app password** |

When `MAIL_USER` / `MAIL_PASSWORD` are unset, email sending is skipped and logged rather than failing —
registration and password-reset flows still work, you just read the verification code from the database.

When running through Cargo, the `db.*` Maven properties are passed to Tomcat as system properties,
so `-Ddb.port=1434` is all you need.

---

## Technologies

- **Backend** — Java 11, Servlet 4.0, JSP, JSTL 1.2, JDBC
- **Frontend** — HTML, CSS, Bootstrap, jQuery, JavaScript
- **Database** — Microsoft SQL Server 2022 (`mssql-jdbc` driver)
- **Email** — JavaMail over Gmail SMTP
- **Build/Run** — Maven (WAR) + Cargo-managed Tomcat 9

Passwords are stored as **salted SHA-1** digests (`Utils.MaHoa`). This is the original implementation
and is **not** suitable for production — see [Known issues](#known-issues).

---

## Project layout

```
src/java/
  Controller/   Servlets (one per action, mapped in web/WEB-INF/web.xml)
  DAO/          Data access — raw JDBC against SQL Server
  DTO/          Plain data objects
  Database/     DBUtil — JDBC connection factory
  Utils/        Email, hashing, random codes, URL helper
web/            JSPs, CSS, JS, images, WEB-INF/web.xml
db/schema.sql   Schema + seed data (UTF-8, creates the database if absent)
pom.xml         Maven build
docker-compose.yml
```

The app is served under the context path `/Cenematic`, taken from the WAR name.

---

## Notes on running without Docker

If you prefer your own SQL Server, create a `CENEMATIC` database, run `db/schema.sql` against it,
then point the app at it:

```sh
mvn package cargo:run -Ddb.host=localhost -Ddb.port=1433 -Ddb.user=sa -Ddb.password='YourPassword'
```

`db/schema.sql` is plain UTF-8 and can also be opened directly in SQL Server Management Studio.

---

## What changed from the original submission

The project was a NetBeans/Ant build whose `nbproject/project.properties` pointed at jars under
`C:\Users\admin\Downloads\…`, so it only ever built on its authors' machines. The following changes
make it build and run from a clean checkout:

- **Added a Maven build** (`pom.xml`) that keeps the original `src/java` + `web` layout, and runs the
  app on a Cargo-managed Tomcat 9 — no manual Tomcat install or IDE server setup.
- **Replaced `sqljdbc4.jar`** with the maintained `mssql-jdbc` driver, and disabled the driver's new
  default TLS requirement for local development.
- **Dropped a Tomcat-internal import.** `Utils.MaHoa` used `org.apache.tomcat.util.codec.binary.Base64`;
  it now uses `java.util.Base64`, which produces identical output, so existing password hashes stay valid.
- **Moved credentials out of source.** DB settings and the SMTP mailbox are read from the environment.
- **Fixed hardcoded verification links.** Three servlets emitted `http://localhost:8084/Cenematic1/…`
  into confirmation emails; `Utils.AppUrl` now derives the base URL from the request.
- **Fixed the context path.** `web/META-INF/context.xml` pinned `path="/Cenematic1"`, which Tomcat 7+
  ignores inside a WAR and which overrode the deployer's setting.
- **Excluded the checked-in jars** in `web/WEB-INF/lib` from the WAR. Three conflicting JSTL jars there
  broke JSP tag resolution; Maven now supplies a single correct set.
- **Converted the SQL dump.** `CENEMATIC.sql` was UTF-16 and awkward to import; `db/schema.sql` is UTF-8,
  creates the database if it doesn't exist, and repairs 24 mojibake runs of Vietnamese text
  (e.g. `Kinh DÆ°Æ¡ng VÆ°Æ¡ng` → `Kinh Dương Vương`).

The original Ant files (`build.xml`, `nbproject/`) and `CENEMATIC.sql` are left in place for reference,
but Maven is the supported path.

---

## Known issues

These are pre-existing and were left alone deliberately — they are behaviour changes, not build fixes:

- **Password hashing is salted SHA-1** with a single hardcoded salt. Real deployments should use
  bcrypt/Argon2 with a per-user salt.
- **`CategorySevelet` returns 404** when called without a `movieCategory` parameter: it forwards to
  `errorcategory.jsp`, which was never created. The normal path (`?movieCategory=…`) works.
- **Account verification links carry the password hash** as a query parameter.
- **Some seed rows contain test data** (personal-looking emails and addresses) from development.

> The Gmail app password that used to be hardcoded in `Utils/Email.java` is still in the git history.
> If that mailbox is real, revoke the app password at <https://myaccount.google.com/apppasswords>.

---

## Role & contributions

**Role**: Leader (Full-Stack Developer) · **Team size**: 2

- Database design — analysed requirements and structured the schema
- Backend — core booking flow and admin panel
- Security — password hashing and SMTP email verification
- Frontend — UI implementation

---

## Contact

**Email**: [sonnamsonnam402@gmail.com](mailto:sonnamsonnam402@gmail.com)
**LinkedIn**: [Son Nam Nguyen](https://linkedin.com/in/son-nam-nguyen-0a8094354)
