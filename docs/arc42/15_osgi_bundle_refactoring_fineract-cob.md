# fineract-cob – OSGi api / impl / test refactoring plan

Wave‑4 module after progressive/WC
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; entity-typed step residual) |
| **Module** | COB job parameters, partitions, business-step DTOs/exceptions |
| **No façade** | Compose with `:fineract-cob-api` + `:fineract-cob-impl` |

## Residual

- `COBBusinessStepService` / entity-typed step runners stay on impl
- Loan/savings/WC/investor COB adapters depend on api+impl

## Commands

```bash
./gradlew :fineract-cob-api:jar :fineract-cob-impl:jar :fineract-cob-test:test
./gradlew :fineract-provider:compileJava
```
