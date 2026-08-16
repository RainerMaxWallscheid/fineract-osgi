# docker/

Top-level Compose files and leftover Tomcat config. Run them from the **repository root**.

Shared env files, compose fragments, and observability live in `config/docker/` (not moved here). Paths in these files use `../config/docker/...`. Volume binds that use `${PWD}/config/docker/...` also assume the repo root as the working directory.

## Compose files

| File | Use |
|------|-----|
| `docker-compose.yml` | Default stack (PostgreSQL + Fineract) |
| `docker-compose-postgresql.yml` | Standard PostgreSQL |
| `docker-compose-mysql.yml` / `docker-compose-mariadb.yml` | Alternative DBs |
| `docker-compose-*-test.yml` | Integration / e2e / auth-mode overlays |
| `docker-compose-development.yml` | Dev stack (needs Loki log driver) |
| `docker-compose-postgresql-kafka.yml` / `-activemq.yml` / `-kafka-msk.yml` | Manager + worker messaging |
| `docker-compose-web-app.yml` / `docker-compose-community-app.yml` | UI alongside API |
| `docker-compose-custom.yml` | Custom image (`fineract-custom`) |
| `docker-compose-oauth2-test.yml` / `docker-compose-twofactor-test.yml` | Overlay files for CI auth modes |

```bash
# from repository root
./gradlew :fineract-provider:jibDockerBuild -x test
docker compose -f docker/docker-compose-postgresql.yml up -d
docker compose -f docker/docker-compose-postgresql.yml config   # path check only
```

These stacks are **not** production-ready (`test` profile is enabled via `config/docker/env/fineract-common.env`).

## `server/server.xml`

Legacy Bitnami Tomcat `server.xml` from the old image. Current images are Jib/Spring Boot. Do **not** overlay this file onto Cargo or Jib — the keystore path is the old `/opt/bitnami/tomcat/tomcat.keystore`.
