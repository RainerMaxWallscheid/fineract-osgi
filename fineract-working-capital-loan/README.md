# fineract-working-capital-loan

Working capital loans — Wave 4 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-working-capital-loan-api` | `api/` | `org.apache.fineract.workingcapitalloan.api` | Pure ports, DTOs, exceptions, pure enums |
| `fineract-working-capital-loan-impl` | `impl/` | `org.apache.fineract.workingcapitalloan.impl` | Domain, COB, catch-up residual; Equinox DS `OSGI-INF/working-capital-loan.xml` |
| `fineract-working-capital-loan-test` | `test/` | `org.apache.fineract.workingcapitalloan.test` | Fragment-Host → impl |

No façade. Consumers: **api + impl**.

WC-transaction entities store code-value id (not leftover CodeValue). WC and WC-product entities store fund id (not leftover Fund). WC loan entities store client id (not leftover Client). Working capital loan submitted-by names use AppUserPersistablePort (not leftover AppUser repository). Working capital loan and product fund lookups use FundPersistablePort (not leftover Fund repository). Working capital loan and product fund names use FundPersistablePort (not leftover Fund). Working capital loan timeline and disbursement user names use AppUserPersistablePort (not leftover AppUser). Working capital loan transaction classification uses CodeValuePersistablePort (not leftover CodeValue). Working capital loan classification lookups use CodeValuePersistablePort (not leftover CodeValue repository). Working capital loan transaction payment details use PaymentDetailPersistablePort (not leftover PaymentDetail). Working capital loan accrual payment type ids use PaymentDetailPersistablePort (not leftover PaymentDetail). Working capital loan payment detail creates use Object payment details (not leftover PaymentDetail). Working capital loan approval uses Object user (not leftover AppUser). Working capital loan rejection uses Object user (not leftover AppUser).

`AccrualWithDeferredRevenueAmortizationAccountingProcessorForWorkingCapitalLoan` lives in **impl**
(implements `WorkingCapitalLoanAccountingProcessor`; uses accounting-impl `AccountingProcessorHelper`).

```bash
./gradlew :fineract-working-capital-loan-api:jar :fineract-working-capital-loan-impl:jar :fineract-working-capital-loan-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-working-capital-loan.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-working-capital-loan.md).
