# fineract-accounting

GL / journal / product-to-account mapping — Wave 3 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-accounting-api` | `api/` | `org.apache.fineract.accounting.api` | Ports, DTOs, exceptions, pure constants |
| `fineract-accounting-impl` | `impl/` | `org.apache.fineract.accounting.impl` | JPA domain, REST, helpers, jobs; **OSGi** `AccountingOsgiServiceRegistrar` |
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


Residual closed into **impl**: journal DTOs, running-balance + create/reverse/opening-balance **command handlers**, journal REST + **read impl**, accrual write, product-to-GL write + mapping helpers. Pure charge/tax payment DTOs and `JournalEntryCommandWritePort` on **api**.

Still residual on provider: journal **write service + processors** (loan/savings/share entity-typed), provisioning write domain/handlers.

```bash
./gradlew :fineract-accounting-api:jar :fineract-accounting-impl:jar :fineract-accounting-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-accounting.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-accounting.md).
