# fineract-charge/test

OSGi **unit / white-box test fragment** for the charge **impl** host ([ADR-022](../../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| | |
|--|--|
| Gradle project | `:fineract-charge-test` |
| Bundle-SymbolicName | `org.apache.fineract.charge.test` |
| Fragment-Host | `org.apache.fineract.charge.impl` |
| Production code | **none** (test sources only) |
| Host production code | `fineract-charge/impl` **main only** |

## Conventions

- Tests live under `src/test/java` and exercise **package-visible / public** types of charge-impl (services, adapters).
- Depend on `:fineract-charge-impl` (+ core / JPA test stack) via `testImplementation`.
- **No** `fineract-charge-integrationtest` module unless a second consumer needs shared fixtures (loan/savings keep their own ITs).
- Shared Spring Boot / Equinox integration stays in `integration-tests` / provider, not here.

## Run

```bash
./gradlew :fineract-charge-test:test
./gradlew :fineract-charge-test:jar   # fragment JAR with Fragment-Host manifest
```

## Coverage (as-built)

| Test class | Focus |
|------------|--------|
| `ChargeDefinitionPortJpaAdapterTest` | Module API port mapping / active guards |
| `ChargeDropdownReadPlatformServiceImplTest` | Catalog dropdown option sets |
| `ChargeWritePlatformServiceJpaRepositoryImplTest` | Delete guards (JDBC association, soft-delete) |
| `ChargeOsgiServiceRegistrarTest` | OSGi bridge no-op without FrameworkUtil |

```bash
./gradlew :fineract-charge-test:test   # 16 tests
```

Plan: [15_osgi_bundle_refactoring_fineract-charge.md](../../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).
