# fineract-charge/api

OSGi **interface** bundle for the Charge Catalog ([ADR-022](../../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| | |
|--|--|
| Gradle project | `:fineract-charge-api` |
| Bundle-SymbolicName | `org.apache.fineract.charge.api` |

## Contents (Step 2)

| Package | Content |
|---------|---------|
| `…charge.moduleapi` | `ChargeDefinitionPort`, `ChargeDefinitionData` |
| `…charge.domain` | Pure catalog enums: `ChargeAppliesTo`, `ChargeCalculationType`, `ChargePaymentMode` (JPA entity `Charge` stays on impl) |
| `…charge.exception` | Catalog exceptions (`ChargeNotFoundException`, …) — not LoanCharge* |

**Not here:** JPA `Charge`, converters, Spring services, REST, `ChargeData` (still in `fineract-core`).

```bash
./gradlew :fineract-charge-api:jar
```

Plan: [15_osgi_bundle_refactoring_fineract-charge.md](../../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).
