# fineract-creditbureau

Provider peel — credit bureau configuration and report integration (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-creditbureau-api` | `api/` | `org.apache.fineract.creditbureau.api` | DTOs, ports, exception |
| `fineract-creditbureau-impl` | `impl/` | `org.apache.fineract.creditbureau.impl` | REST, JPA, handlers, OkHttp integration, OSGi registrar |
| `fineract-creditbureau-test` | `test/` | `org.apache.fineract.creditbureau.test` | Fragment-Host → impl |

Loan product mapping entity depends on `LoanProduct` from `fineract-loan-impl`.

```bash
./gradlew :fineract-creditbureau-api:jar :fineract-creditbureau-impl:jar :fineract-creditbureau-test:test
```
