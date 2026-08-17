# fineract-cob – OSGi api / impl / test refactoring plan

Wave‑4 module after progressive/WC
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; entity-typed step residual); Equinox `CobOsgiBundleActivator` (`ConfigJobParameterService`) |
| **Module** | COB job parameters, partitions, business-step DTOs/exceptions |
| **No façade** | Compose with `:fineract-cob-api` + `:fineract-cob-impl` |

## Residual

- `COBBusinessStepService` / entity-typed step runners stay on impl
- Loan lock residual closed into impl (`LoanAccountLock`, repos, `LoanLockingServiceImpl`, lock tasklets)
- Lock REST + business-step config REST closed into impl (`LoanAccountLockApiResource`, `ConfigureBusinessStepApiResource`); `BusinessStepRequest` on api
- `LoanCOBConstant`, `ResolveLoanCOBCustomJobParametersTasklet`, `StayedLockedLoansTasklet` closed into impl; stranded cob-impl unit tests on cob-test
- Loan COB catch-up closed into api/impl (`COBCatchUpService`, async executor, catch-up REST); jobs-impl adapts `JobExecutionQueryPort` / `NamedJobLaunchPort`
- Loan retrieve-id / reload / business-step category closed into loan-impl (next to `RetrieveLoanIdService`)
- Loan item readers/writers/listeners closed into loan-impl; processors stay on provider (progressive model service)
- WC catch-up REST/services + WC inline reader/listener closed into working-capital-loan-impl
- Inline COB executor closed into cob-impl (`InlineCommonLockableCOBExecutorService`, loan impl, build-context tasklet); WC inline executor in WC-impl
- Savings retrieve-id impl closed into savings-impl; loan COB manager + partitioner closed into loan-impl
- WC inline COB job config closed into WC-impl; internal loan COB test API closed into loan-impl
- Loan COB processors + worker/inline configs closed into loan-impl via loan-api `ProgressiveLoanModelRebuildPort` (adapter in progressive-loan-impl)
- Remaining COB JUnit business-step tests closed into loan-test; IncreaseCobDate test into jobs-test; unused `LoanIdsResponseDTO` on cob-api. Cucumber stepdefs stay on provider
- Loan/savings/WC/investor COB adapters depend on api+impl

## Commands

```bash
./gradlew :fineract-cob-api:jar :fineract-cob-impl:jar :fineract-cob-test:test
./gradlew :fineract-provider:compileJava
```
