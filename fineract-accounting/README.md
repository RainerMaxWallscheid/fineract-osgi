# fineract-accounting

GL / journal / product-to-account mapping — Wave 3 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-accounting-api` | `api/` | `org.apache.fineract.accounting.api` | Ports, DTOs, exceptions, pure constants |
| `fineract-accounting-impl` | `impl/` | `org.apache.fineract.accounting.impl` | JPA domain, REST, helpers, jobs; Equinox DS `OSGI-INF/accounting.xml` |
| `fineract-accounting-test` | `test/` | `org.apache.fineract.accounting.test` | Fragment-Host → `accounting.impl` |

No `:fineract-accounting` façade.

### Consumers

| Module | Depend on |
|--------|-----------|
| investor-api | **api only** (`JournalEntryData`) |
| loan / savings / WC / progressive / branch-impl / investor-impl / provider / war / ITs | **api + impl** (entity residual) |


### Residual closed into impl

- `AccountingDropdownReadPlatformServiceImpl`
- `JournalEntryRunningBalanceUpdateServiceImpl` + account running-balance job

Still residual on provider: loan/savings/shares journal processors, provisioning write,
product-to-GL write (share mapping helper), accrual write (loan accruals cycle).


Residual closed into **impl**: journal DTOs, command handlers, journal REST + read, helper + **loan/savings/share processors & factories** (via `LoanReversalJournalEntryPort`), client processors, accrual write, product-to-GL write, `LoanJournalEntryCreatedBusinessEvent`. Ports on **api**: `JournalEntryCommandWritePort`, `LoanReversalJournalEntryPort`.

Still residual on provider: journal **write service** (+ JPA impl/starter). Provisioning write **closed** into impl (`ProvisioningJournalEntryService`). WC processor closed into working-capital-loan-impl.

Product-to-GL mapping entities store payment-type id (not leftover PaymentType). Product-to-GL mapping code value and payment type reads use CodeValuePersistablePort and PaymentTypePersistablePort (not leftover CodeValue or PaymentType). Product-to-GL mapping GL account reads use GLAccountPersistablePort (not leftover GLAccount). Journal entry GL account reads use GLAccountPersistablePort (not leftover GLAccount). Journal entry payment detail reads use PaymentDetailPersistablePort (not leftover PaymentDetail). Financial activity GL account type checks use GLAccountPersistablePort (not leftover GLAccount). Cashier journal GL accounts use Object GL accounts (not leftover GLAccount). External-owner transfer investor journals use Object office and GL accounts (not leftover Office or GLAccount). Provisioning journals use Object GL accounts (not leftover GLAccount). Accounting rule journal GL account checks use GLAccountPersistablePort (not leftover GLAccount). Journal entry payment detail creates use Object payment details (not leftover PaymentDetail). Working capital loan journal payment details use Object payment details (not leftover PaymentDetail). Product-to-GL payment channel mappings use PaymentTypePersistablePort.persistableById (not leftover PaymentType repository). Product-to-GL mapped account lookups use GLAccountPersistablePort.persistableById (not leftover GLAccount repository). WC product-to-GL mapped account lookups use GLAccountPersistablePort.persistableById (not leftover GLAccount repository). Product-to-GL optional mapped account lookups use GLAccountPersistablePort.persistableById (not leftover GLAccount repository). Accounting rule debit and credit accounts use GLAccountPersistablePort.persistableById (not leftover GLAccount repository). Financial activity account writes use GLAccountPersistablePort.persistableById (not leftover GLAccount repository). Journal entry writes use GLAccountPersistablePort.persistableById (not leftover GLAccount repository). Journal processor tax liability GL accounts use GLAccountPersistablePort.persistableById (not leftover GLAccount repository). Journal processor savings charge income GL accounts use GLAccountPersistablePort.persistableById (not leftover GLAccount repository). Journal processor savings and client charge GL accounts pass the account id (not leftover GLAccount repository). Provisioning entry GL accounts use GLAccountPersistablePort.persistableById (not leftover GLAccount repository). Accounting rule debit and credit tags use CodeValuePersistablePort.persistableById (not leftover CodeValue repository). Product-to-GL code value lookups use CodeValuePersistablePort (not leftover CodeValue repository). Accounting rule office checks use OfficePersistablePort.persistableById (not leftover Office repository). GL closure office checks use OfficePersistablePort.persistableById (not leftover Office repository). Journal entry running-balance office checks use OfficePersistablePort.persistableById (not leftover Office repository). Cashier journal office checks use OfficePersistablePort.persistableById (not leftover Office repository). Journal entry writes use OfficePersistablePort.persistableById (not leftover Office repository). Working capital loan journal office checks use OfficePersistablePort.persistableById (not leftover Office repository). Provisioning entry office checks use OfficePersistablePort.persistableById and store the office id (not leftover Office repository). Client transaction journal office checks pass the office id (not leftover Office repository). Shares journal office checks pass the office id (not leftover Office repository). Savings journal office checks pass the office id (not leftover Office repository). Loan journal office checks pass the office id (not leftover Office repository).

```bash
./gradlew :fineract-accounting-api:jar :fineract-accounting-impl:jar :fineract-accounting-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-accounting.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-accounting.md).
