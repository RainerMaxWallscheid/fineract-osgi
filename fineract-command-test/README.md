# fineract-command-test

OSGi **test fragment** for the command **impl** host ([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| | |
|--|--|
| Gradle project | `:fineract-command-test` |
| Path | `fineract-command-test/` (top-level, next to satellites) |
| Bundle-SymbolicName | `org.apache.fineract.command.test` |
| Fragment-Host | `org.apache.fineract.command.impl` |

## Layout

| Source set | Content |
|------------|---------|
| `src/main` | Shared fixtures / sample domain (`org.apache.fineract.command.test.*`) used by command-family tests |
| `src/test` | White-box and Spring Boot tests of the **impl** host (dispatcher, handler manager, sample API) |

Production **impl** (`fineract-command/impl`) has no unit-test source tree; white-box tests run here:

```bash
./gradlew :fineract-command-test:test
```

The fragment JAR packages **main + test** classes so an Equinox install of this bundle as `Fragment-Host` of `command.impl` can load the cases without exporting impl packages.

## Gradle vs OSGi

| Context | How tests see impl internals |
|---------|------------------------------|
| **Gradle CI** | `testImplementation project(':fineract-command-impl')` on the classpath |
| **OSGi container (later)** | Fragment attaches to `org.apache.fineract.command.impl` and shares the host classloader |

Satellites (jdbc/async/disruptor) may `testImplementation` this project for the sample fixtures only.
