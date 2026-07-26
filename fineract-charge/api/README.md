# fineract-charge/api

OSGi **interface** bundle for the Charge Catalog ([ADR-022](../../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| | |
|--|--|
| Gradle project | `:fineract-charge-api` |
| Bundle-SymbolicName | `org.apache.fineract.charge.api` |
| Export-Package | `…moduleapi`, pure enums `…domain`, catalog `…exception` |
| Spring / JPA / REST | **none** |

## Contents

| Package | Content |
|---------|---------|
| `…charge.moduleapi` | `ChargeDefinitionPort`, `ChargeDefinitionData` |
| `…charge.domain` | Pure catalog enums + enum `AttributeConverter`s (`ChargeAppliesTo`, calculation/payment mode, …) |
| `…charge.exception` | Catalog exceptions (`ChargeNotFoundException`, `ChargeIsNotActiveException`, …) |
| `…charge.service` | `ChargeEnumerations`, `ChargeReadPlatformService` **interface** (no Spring impl) |

**Not here:** JPA `Charge` entity, Spring `@Service` impls, REST, LoanCharge* exceptions (now in **loan**), fat `ChargeData` (still in `fineract-core`).

## Consumers (as of Step 8 partial)

Prefer this module (or no charge dep) over `:fineract-charge-impl`:

- progressive-loan, accounting → **api only**
- investor → **no charge module** (`LoanCharge.getChargeId()`)
- loan / savings / working-capital → still need **impl** until Step 8 residual is finished

```bash
./gradlew :fineract-charge-api:jar
```

Plan: [15_osgi_bundle_refactoring_fineract-charge.md](../../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).
