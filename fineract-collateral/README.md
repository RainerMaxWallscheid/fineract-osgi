# fineract-collateral

Provider peel — legacy loan collateral (`portfolio.collateral`) (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-collateral-api` | `api/` | `org.apache.fineract.collateral.api` | Ports, DTOs (`CollateralData`), exceptions |
| `fineract-collateral-impl` | `impl/` | `org.apache.fineract.collateral.impl` | Entity, constants, REST, handlers; Equinox DS `OSGI-INF/collateral.xml` |
| `fineract-collateral-test` | `test/` | `org.apache.fineract.collateral.test` | Fragment-Host → impl |

## Residual closed (loan)

`CollateralData`, `CollateralApiConstants`, and `LoanCollateral` live in this module.

`Loan` no longer owns an inverse `OneToMany` to legacy `LoanCollateral` (avoids loan-impl ↔ collateral-impl cycle). The child side keeps `@ManyToOne Loan`; writes go through `LoanCollateralRepository`.

Newer client/product collateral remains under `portfolio.collateralmanagement` (still on provider / loan residual for management entities).

```bash
./gradlew :fineract-collateral-api:jar :fineract-collateral-impl:jar :fineract-collateral-test:test
```
