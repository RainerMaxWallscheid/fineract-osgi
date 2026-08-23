# fineract-creditbureau

Provider peel — credit bureau configuration and report integration (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-creditbureau-api` | `api/` | `org.apache.fineract.creditbureau.api` | DTOs, ports, exception |
| `fineract-creditbureau-impl` | `impl/` | `org.apache.fineract.creditbureau.impl` | REST, JPA, handlers, OkHttp integration; Equinox DS `OSGI-INF/creditbureau.xml` |
| `fineract-creditbureau-test` | `test/` | `org.apache.fineract.creditbureau.test` | Fragment-Host → impl |

Loan product mapping stores `loan_product_id` and checks existence via `LoanProductExistencePort` (not leftover `LoanProduct`).

```bash
./gradlew :fineract-creditbureau-api:jar :fineract-creditbureau-impl:jar :fineract-creditbureau-test:test
```
