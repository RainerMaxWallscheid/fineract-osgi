# fineract-charge/api

OSGi **interface** bundle for the Charge Catalog ([ADR-022](../../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| | |
|--|--|
| Gradle project | `:fineract-charge-api` |
| Bundle-SymbolicName | `org.apache.fineract.charge.api` |

**Step 1:** empty shell. Module API types (`ChargeDefinitionPort`, `ChargeDefinitionData`) still live under `impl` until Step 2 moves them here.

Plan: [15_osgi_bundle_refactoring_fineract-charge.md](../../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).
