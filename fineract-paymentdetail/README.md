# fineract-paymentdetail

Core residual peel — payment detail write path (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-paymentdetail-api` | `api/` | `org.apache.fineract.paymentdetail.api` | Write port, constants |
| `fineract-paymentdetail-impl` | `impl/` | `org.apache.fineract.paymentdetail.impl` | Write impl, assembler, starter; Equinox DS `OSGI-INF/paymentdetail.xml` |
| `fineract-paymentdetail-test` | `test/` | `org.apache.fineract.paymentdetail.test` | Fragment-Host → impl |

Residual in `fineract-core`: `PaymentDetail` entity/repo, `PaymentDetailConstants`, and `PaymentDetailData` (savings transaction DTO coupling).

```bash
./gradlew :fineract-paymentdetail-api:jar :fineract-paymentdetail-impl:jar :fineract-paymentdetail-test:test
```
