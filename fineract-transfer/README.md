# fineract-transfer

Core residual peel — client office/group transfers (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-transfer-api` | `api/` | `org.apache.fineract.transfer.api` | Write port, event type, constants, exceptions |
| `fineract-transfer-impl` | `impl/` | `org.apache.fineract.transfer.impl` | Handlers, validator; Equinox DS `OSGI-INF/transfer.xml` |
| `fineract-transfer-test` | `test/` | `org.apache.fineract.transfer.test` | Fragment-Host → impl |

Write impl stays in `fineract-progressive-loan-impl` (client/group/loan/savings coupling).

```bash
./gradlew :fineract-transfer-api:jar :fineract-transfer-impl:jar :fineract-transfer-test:test
```
