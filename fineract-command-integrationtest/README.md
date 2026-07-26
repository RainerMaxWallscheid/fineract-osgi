# fineract-command-integrationtest

Shared **integration-test support** for the entire command module family (api/impl/jdbc/async/disruptor/audit).

| | |
|--|--|
| Gradle project | `:fineract-command-integrationtest` |
| Path | `fineract-command-integrationtest/` |
| Bundle-SymbolicName | `org.apache.fineract.command.integrationtest` |
| Fragment-Host | *(none — test-support library, not host-bound)* |

## Contents (`src/main`)

| Package | Role |
|---------|------|
| `org.apache.fineract.command.test.CommandBaseTest` | Testcontainers / datasource base for module ITs |
| `org.apache.fineract.command.test.sample.*` | Dummy command, handlers, REST sample, DTOs |

## Consumers

```gradle
testImplementation project(':fineract-command-integrationtest')
```

Used by:

- `:fineract-command-test` (impl white-box tests under `fineract-command/test`)
- `:fineract-command-jdbc`, `-async`, `-disruptor`, `-audit` integration tests

**Not** a production dependency. Do not put white-box unit tests of `command-impl` here — those belong in `:fineract-command-test` (`Fragment-Host` of impl).
