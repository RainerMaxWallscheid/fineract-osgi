# fineract-working-capital-loan – OSGi api / impl / test refactoring plan

Wave‑4 product variant after [loan](15_osgi_bundle_refactoring_fineract-loan.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; entity residual for provider); Equinox `WorkingCapitalLoanOsgiBundleActivator` (`WorkingCapitalLoanPeriodPaymentRateChangeReadService`) |
| **Module** | Working capital products/accounts, breach/near-breach, COB |
| **No façade** | Compose with `:fineract-working-capital-loan-api` + `:fineract-working-capital-loan-impl` |

## Layout

```text
fineract-working-capital-loan/
  api/   → :fineract-working-capital-loan-api
  impl/  → :fineract-working-capital-loan-impl
  test/  → :fineract-working-capital-loan-test
```

## Residual

- Leftover working-capital-loan batch `CommandStrategy` classes (+ unit tests) now live in working-capital-loan-impl/test next to leftover WC loan REST.
- Large account/product entity graph on impl
- Some DTOs/ports stay on impl until pure enum/DTO graph is closed

## Commands

```bash
./gradlew :fineract-working-capital-loan-api:jar :fineract-working-capital-loan-impl:jar :fineract-working-capital-loan-test:test
./gradlew :fineract-provider:compileJava
```
