# fineract-collateralmanagement

Provider peel — client/product/loan collateral management (`portfolio.collateralmanagement`) (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-collateralmanagement-api` | `api/` | `org.apache.fineract.collateralmanagement.api` | Ports, DTOs, exceptions |
| `fineract-collateralmanagement-impl` | `impl/` | `org.apache.fineract.collateralmanagement.impl` | REST, repos, handlers, OSGi registrar |
| `fineract-collateralmanagement-test` | `test/` | `org.apache.fineract.collateralmanagement.test` | Fragment-Host → impl |

## Residual closed (loan)

`CollateralManagementDomain`, `ClientCollateralManagement`, `LoanCollateralManagement`,
constants and repository live in this module. `Loan` / `LoanTransaction` no longer own inverse
collections; association lifecycle is `LoanCollateralLifecycleService`.

Legacy code-value collateral is `fineract-collateral` (separate peel).

```bash
./gradlew :fineract-collateralmanagement-api:jar :fineract-collateralmanagement-impl:jar :fineract-collateralmanagement-test:test
```
