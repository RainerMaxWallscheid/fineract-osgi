# Run integration tests

Cargo deploys `fineract-provider.war` to embedded Tomcat (`https://localhost:8443`).  
The task `:integration-tests:waitForFineract` waits for Actuator health until Fineract is up.

## Prerequisites

1. **Database listening on localhost** (required — Tomcat starts without it, Fineract does not)
2. **WAR built** (Cargo depends on `:fineract-war:war`)

### Default: MariaDB (`localhost:3306`)

```bash
docker compose -f docker/docker-compose-mariadb-test.yml up -d
# wait until MariaDB accepts connections, then:
./gradlew :integration-tests:test
```

Credentials expected by Cargo (default JVM args): user `root`, password `mysql`, DB `fineract_tenants`.

### Alternative: MySQL

```bash
docker compose -f docker/docker-compose-mysql-test.yml up -d
./gradlew :integration-tests:test -PdbType=mysql
```

### Alternative: PostgreSQL (`localhost:5432`)

```bash
docker compose -f docker/docker-compose-postgresql-test.yml up -d
# or use a local Postgres with DBs/users matching Cargo JVM args
./gradlew :integration-tests:test -PdbType=postgresql
```

Expected (Cargo): user `root`, password `postgres`, DB `fineract_tenants`, port `5432`.

## Default backend config (tests)

| Variable | Default |
|----------|---------|
| `BACKEND_PROTOCOL` | `https` |
| `BACKEND_HOST` | `localhost` |
| `BACKEND_PORT` | `8443` |
| `BACKEND_USERNAME` | `mifos` |
| `BACKEND_PASSWORD` | `password` |
| `BACKEND_TENANT` | `default` |

Override any of these as environment variables.

## `waitForFineract` failures

| Symptom | Typical root cause |
|---------|-------------------|
| Timeout after 600s | Fineract never became healthy — **read** `integration-tests/build/cargo/integration-tests-output.log` |
| `Connection refused` (MariaDB/MySQL) | No DB on `:3306` — start `docker/docker-compose-mariadb-test.yml` |
| `Configuration not found for external event …` | New `*BusinessEvent` missing from `m_external_event_configuration` (Liquibase) — see arc42 [12.9](../docs/arc42/12_event_catalog.md#129-pflicht-external-event-konfiguration-in-der-db) |
| Port already in use | Previous Cargo not stopped: `./gradlew :integration-tests:cargoStopLocal` |

The wait task checks that the expected DB port is open **before** waiting the full 600s, and on timeout prints relevant cargo-log lines.

Optional shorter timeout while debugging:

```bash
./gradlew :integration-tests:waitForFineract -PwaitForFineractTimeoutSeconds=60
```

## Run tests against an already running Fineract

```bash
./gradlew :integration-tests:test -PcargoDisabled
```

## Migration to fineract-client-feign

We are currently migrating integration tests from RestAssured to the Feign-based Fineract client. For detailed instructions and patterns, see the [Test Migration Guide](TEST_MIGRATION_GUIDE.md).
