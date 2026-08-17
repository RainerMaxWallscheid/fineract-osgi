# fineract-charge/impl

OSGi **implementation** bundle for the Charge Catalog ([ADR-022](../../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| | |
|--|--|
| Gradle project | `:fineract-charge-impl` |
| Bundle-SymbolicName | `org.apache.fineract.charge.impl` |
| Export-Package | `…charge.impl.osgi` only (registrar; not domain / services) |
| Spring | **yes** (allowed inside impl) |

## Contents

| Area | Notes |
|------|--------|
| `domain.Charge` + repositories / converters | Catalog aggregate |
| Platform services / handlers / REST | Application + driven adapters |
| `ChargeDefinitionPortJpaAdapter` | Module API adapter (`@Service`) |
| `ChargeConfiguration` | Spring `@Bean` wiring for read/write services |
| `ChargeOsgiServiceRegistrar` | Registers `ChargeDefinitionPort` when OSGi `BundleContext` is present; **no-ops** under plain Boot |
| Composition ports | `ChargeOfficeAccessPort`, `ChargeAccountingDropdownPort` (adapters in provider) |

**White-box tests:** production **main only** — tests live in `:fineract-charge-test` (Fragment-Host).

```bash
./gradlew :fineract-charge-impl:jar
./gradlew :fineract-charge-test:test
```

Plan: [15_osgi_bundle_refactoring_fineract-charge.md](../../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).
