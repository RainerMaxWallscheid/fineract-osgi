# fineract-fund

Provider peel — funds catalog (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-fund-api` | `api/` | `org.apache.fineract.fund.api` | `FundData`/`FundRequest`, read/write ports |
| `fineract-fund-impl` | `impl/` | `org.apache.fineract.fund.impl` | REST, handlers, services; Equinox DS `OSGI-INF/fund.xml` |
| `fineract-fund-test` | `test/` | `org.apache.fineract.fund.test` | Fragment-Host → impl |

### Residual in `fineract-core`

`Fund` entity, `FundRepository`, `FundNotFoundException` stay in core. Loan, loan-product, WC, and WC-product entities store fund id (not leftover Fund).

```bash
./gradlew :fineract-fund-api:jar :fineract-fund-impl:jar :fineract-fund-test:test
```
