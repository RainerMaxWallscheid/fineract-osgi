# fineract-command/test

OSGi **unit / white-box test fragment** for the command **impl** host ([ADR-022](../../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| | |
|--|--|
| Gradle project | `:fineract-command-test` |
| Path | `fineract-command/test` |
| Bundle-SymbolicName | `org.apache.fineract.command.test` |
| Fragment-Host | `org.apache.fineract.command.impl` |

## Role

| Source set | Content |
|------------|---------|
| `src/main` | *(empty — production-free fragment)* |
| `src/test` | White-box tests of **command-impl** (`CommandDispatcherTest`, `DefaultCommandHandlerManagerTest`, `CommandSampleApiTest`, …) |

Shared fixtures used by these tests (and by satellite ITs) live in **`:fineract-command-integrationtest`**, not here.

```bash
./gradlew :fineract-command-test:test
```

## Gradle vs OSGi

| Context | Wiring |
|---------|--------|
| **Gradle** | `testImplementation` of `:fineract-command-impl` + `:fineract-command-integrationtest` |
| **OSGi later** | Fragment attaches to `org.apache.fineract.command.impl` (host classloader for white-box access) |
