# fineract-progressive-loan – OSGi api / impl / test refactoring plan

Wave‑4 product variant after [loan](15_osgi_bundle_refactoring_fineract-loan.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; residual domain for provider/embeddable) |
| **Module** | Progressive EMI schedule, capitalized income, buy-down fee reads |
| **No façade** | Compose with `:fineract-progressive-loan-api` + `:fineract-progressive-loan-impl` |

## Layout

```text
fineract-progressive-loan/
  api/   → :fineract-progressive-loan-api
  impl/  → :fineract-progressive-loan-impl
  test/  → :fineract-progressive-loan-test
```

## Residual

- Schedule engine / loan entity coupling stays on impl
- Embeddable schedule generator depends on api+impl

## Commands

```bash
./gradlew :fineract-progressive-loan-api:jar :fineract-progressive-loan-impl:jar :fineract-progressive-loan-test:test
./gradlew :fineract-provider:compileJava
```
- Leftover test-profile InternalLoanInformationApiResource closed into progressive-loan-impl (AdvancedPaymentDataMapper).
- Leftover DefaultLoanScheduleGeneratorFactory closed into progressive-loan-impl.
- Leftover progressive amortization/summary/refund/schedule-generator impls and buy-down/capitalized-income utils closed into progressive-loan-impl.
- Leftover LoanAccountAutoStarter, LoanTransactionProcessingServiceImpl, and ReprocessLoanTransactionsServiceImpl closed into progressive-loan-impl.
- Leftover re-age/re-amortize/termination/adjustment services+handlers, LoanTransactionsApiResource, and related batch strategies closed into progressive-loan-impl.
- Leftover account-details JDBC impl plus loan/bulk/GLIM read impls closed into progressive-loan-impl (WC application read; account-details port+DTO on loan-impl).
- Leftover client/groups/centers REST, swagger, and client batch strategies closed into progressive-loan-impl (can compose loan-impl + savings-impl).
- Leftover account-transfer/associations entities and guarantor domain closed into progressive-loan-impl (Loan + SavingsAccount binding; detail/SI assemblers and write stay).
- Leftover LoansApiResource + loan batch, schedule/validators, client/share read, and transfer write port closed into progressive-loan-impl.
- Leftover write/assembler residual closed into progressive-loan-impl. Provider now holds only the Spring Boot composition root.
