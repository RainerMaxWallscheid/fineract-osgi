# fineract-savings – OSGi api / impl / test refactoring plan

Wave‑3 module after [accounting](15_osgi_bundle_refactoring_fineract-accounting.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; entity residual for provider) |
| **Module** | Savings & deposit products/accounts, interest charts, interop |
| **No façade** | Compose with `:fineract-savings-api` + `:fineract-savings-impl` |

---

## 1. Layout

```text
fineract-savings/
  api/   → :fineract-savings-api
  impl/  → :fineract-savings-impl
  test/  → :fineract-savings-test
```

## 2. Placement

| Slice | Contents |
|-------|----------|
| **api** | Pure product/application ports, module DTOs/exceptions, `moduleapi` |
| **impl** | `SavingsAccount*` domain, entity-typed account services, COB, interest-chart domain, interop |

**Kernel note:** Many savings enums/DTOs already live in **fineract-core**.

## 3. Consumers

| Module | Edge |
|--------|------|
| provider / war / architecture / ITs | **api + impl** |

## 4. Residual

- Provider still binds heavily to `SavingsAccount` / entity-typed write services
- Optional: pure account ports without entity signatures
- Interest-rate chart REST, command handlers, read/write services, and validators now live in savings-impl (domain/assemblers were already there)
- Fixed/recurring deposit product write/read/handlers now live in savings-impl. Savings-product read/write now live in savings-impl via leftover entityaccess-api office ports (`FineractEntityAccessReadService` / `OfficeProductRestrictionService`).
- Fixed/recurring deposit account entities (and RD schedule/recurring detail) now live in savings-impl next to `SavingsAccount`. Assemblers stay on provider.
- Leftover savings command handlers now live in savings-impl (thin wrappers over write ports already on api/impl).
- Deposit-account interest-chart read, FD interest-calculation, and `DepositAccountDataValidator` now live in savings-impl.
- Savings/FD/RD product REST now live in savings-impl. Generic `DropdownReadPlatformService` moved to fineract-core next to `CommonEnumerations`.
- Savings account transaction/charge/on-hold/internal REST now live in savings-impl. Account-collection REST stays on provider (bulkimport + leftover account associations).
- Savings and recurring-deposit account-collection REST now live in savings-impl (bulkimport ports are in core). FD account REST now lives in savings-impl after leftover `AccountAssociationsReadPlatformService` moved to core.
- Peelable leftover savings jobs (annual fee, RD schedule, due charges, maturity, dormant) now live in savings-impl. Accrual/post-interest jobs now live in savings-impl. Transfer job now lives in savings-impl via thin `InterestTransferData` + leftover read/write ports (provider adapter builds leftover `AccountTransferDTO`). Adhoc job moved to adhocquery-impl.
- `SavingsAccountChargeReadPlatformServiceImpl` now lives in savings-impl after `ChargeDropdownReadPlatformService` moved to charge-api.
- Transaction validators and leftover `SavingsDropdownReadPlatformServiceImplTest` now live in savings-impl/test. Provider leftover savings `data/` is empty.
- GSIM write interface/impl now live in savings-impl. Unused `LoanRepository` constructor parameter dropped.
- Savings accrual write port is on savings-api and the accrual job lives in savings-impl. Accrual write impl stays on provider (leftover assembler).
- Post-interest job now lives in savings-impl next to leftover `SavingsSchedularInterestPosterTask` and leftover read port. Transfer job now lives in savings-impl (thin `InterestTransferData` + leftover `DepositAccountInterestTransferReadService` / `InterestTransferWritePort`; provider adapter wraps leftover account-transfer write). Adhoc job now lives in adhocquery-impl (not leftover savings).
- Leftover savings batch strategies (apply/get/transaction/adjust/charge/pay-charge) now live in savings-impl next to leftover savings REST. `DisburseToSavingsCommandStrategy` stays (leftover `LoansApiResource`).
- Leftover `AccountAssociationsReadPlatformService` + `AccountAssociationsData` + leftover `AccountAssociationType` + leftover associations read impl now live in core. FD account REST lives in savings-impl.
- Leftover `ConvertChargeDataToSpecificChargeData` now lives in core next to leftover `ChargeData` / leftover savings and share charge DTOs.
- Leftover savings-product read/write now live in savings-impl. Office-product SQL clause is on leftover `FineractEntityAccessReadService`; office product restriction is leftover `OfficeProductRestrictionService` (entityaccess-api; impl is leftover `FineractEntityAccessUtil`).
- Leftover savings transaction search now lives in savings-impl after leftover `SavingsAccountTransactionsMapper` was extracted from leftover account-read.
- Leftover account-associations read impl (+ leftover `AccountAssociationType`) now live in core next to leftover associations port/data.
- Leftover pure account-transfer enums (`AccountTransferType`, recurrence, standing-instruction priority/status/type) now live in core. Transfer job now lives in savings-impl via thin ID-only `InterestTransferData` (leftover `AccountTransferDTO` entity edges stay on provider adapter).
- Leftover pure account-transfer support types now live in core: `AccountTransferEnumerations`, API/detail constants, thin portfolio/SI DTOs + request params, transfer/SI not-found exceptions, and leftover read ports (`PortfolioAccountReadPlatformService`, `StandingInstructionHistoryReadService`). `StandingInstructionData` stays (leftover `LoanTransactionType`).
- Leftover portfolio-account read impl, SI-history read impl, account-transfer mapper, transfer/SI validators, SI write port, and leftover `ColumnValidator` now live in core. Account-transfer read stays (leftover `OfficeReadPlatformService` on organisation-api). Entity write/assemblers/REST stay.
- Leftover `OfficeReadPlatformService` now lives in core next to leftover `OfficeData`. Account-transfer read impl, SI data/read port+impl, SI swagger models, and SI-history REST now live in core (`StandingInstructionData` no longer imports leftover `LoanTransactionType`). Entity write/assemblers and transfer/SI command REST stay.
- Leftover account-transfer REST + swagger, SI REST, and SI create/update/delete command handlers now live in core. Transfer command handlers stay (leftover `AccountTransfersWritePlatformService` still embeds leftover `AccountTransferDTO` / entities).
- Leftover transfer create/refund/undo command handlers now live in core via thin leftover `AccountTransfersCommandWritePort`. Provider leftover `AccountTransfersWritePlatformService` extends that port and keeps leftover `AccountTransferDTO` / entity methods.
- Leftover execute-SI job now lives in core via thin `AccountTransferFundsData` + leftover `AccountTransferFundsWritePort` (provider adapter builds leftover `AccountTransferDTO`). Leftover `InsufficientAccountBalanceException` now lives in core next to leftover savings exceptions used by the job.
- Leftover account read Spring beans now wire in core (`AccountReadConfiguration`). Leftover `AccountTransfersCommandWritePort` also carries reverse methods (ID + portfolio type only). Provider leftover `AccountConfiguration` keeps entity write beans only.
- Leftover transfer-fee-charge job now lives in loan-impl via thin leftover `AccountTransferFundsData` (charge id + installment fields) + leftover funds write port.
- Leftover `DepositAccountReadPlatformServiceImpl` now lives in savings-impl (JDBC + leftover ports; no assemblers). Leftover interest-transfer adapter now calls leftover `AccountTransferFundsWritePort` instead of leftover entity write service.
- Leftover `SavingsAccountTemplateReadPlatformServiceImpl` now lives in savings-impl via thin leftover `EntityDatatableTemplatesReadService` on dataqueries-api (avoids dataqueries-impl ↔ savings-impl cycle).

## 5. Commands

```bash
./gradlew :fineract-savings-api:jar :fineract-savings-impl:jar :fineract-savings-test:test
./gradlew :fineract-provider:compileJava
```
