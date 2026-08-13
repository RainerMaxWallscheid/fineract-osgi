# fineract-working-capital-loan

Working capital loans — Wave 4 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-working-capital-loan-api` | `api/` | `org.apache.fineract.workingcapitalloan.api` | Pure ports, DTOs, exceptions, pure enums |
| `fineract-working-capital-loan-impl` | `impl/` | `org.apache.fineract.workingcapitalloan.impl` | Domain, COB, residual services |
| `fineract-working-capital-loan-test` | `test/` | `org.apache.fineract.workingcapitalloan.test` | Fragment-Host → impl |

No façade. Consumers: **api + impl**.

`AccrualWithDeferredRevenueAmortizationAccountingProcessorForWorkingCapitalLoan` lives in **impl**
(implements `WorkingCapitalLoanAccountingProcessor`; uses accounting-impl `AccountingProcessorHelper`).

```bash
./gradlew :fineract-working-capital-loan-api:jar :fineract-working-capital-loan-impl:jar :fineract-working-capital-loan-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-working-capital-loan.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-working-capital-loan.md).
