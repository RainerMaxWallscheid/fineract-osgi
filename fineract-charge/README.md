# fineract-charge

Charge Catalog bounded context — OSGi modularization **complete** (Steps 0–9)
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-charge-api` | `api/` | `org.apache.fineract.charge.api` | **Export-Package** `moduleapi` + catalog `exception` + `util` |
| `fineract-charge-impl` | `impl/` | `org.apache.fineract.charge.impl` | JPA catalog, write/read impls, REST, Spring; **Export-Package** `starter` only |
| `fineract-charge-test` | `test/` | `org.apache.fineract.charge.test` | White-box tests; **Fragment-Host** → `org.apache.fineract.charge.impl` |

There is **no** `:fineract-charge` façade. Depend on `-api` and (composition roots only) `-impl`.

### Module API (`…portfolio.charge.moduleapi`)

Public types for foreign BCs:

- `ChargeDefinitionPort`, `ChargeDefinitionData`
- Pure enums + converters: `ChargeAppliesTo`, `ChargeCalculationType`, `ChargePaymentMode`, …
- `ChargeReadPlatformService`, `ChargeEnumerations`

`ChargeTimeType` (+ converter) lives in the **same package name** on `fineract-core` (shared-kernel placement).

Impl-only: `…portfolio.charge.domain.Charge`, repositories, write services, handlers.


Residual adapters **closed** into charge-impl: `ChargeAccountingDropdownPortAdapter`,
`ChargeOfficeAccessPortAdapter`. `ConvertChargeDataToSpecificChargeData` is on charge-api
(`ChargeData` / savings+share charge DTOs remain residual in core).

```bash
./gradlew :fineract-charge-api:jar :fineract-charge-impl:jar :fineract-charge-test:jar
./gradlew :fineract-charge-test:test
```

### Consumer Gradle edges

| Module | Depend on |
|--------|-----------|
| progressive-loan / loan / savings / accounting / WC | `:fineract-charge-api` only |
| **investor** | *(none)* |
| **provider / war / integration-tests** | `:fineract-charge-api` **+** `:fineract-charge-impl` |

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).
