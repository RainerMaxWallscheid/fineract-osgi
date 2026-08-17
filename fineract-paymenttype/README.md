# fineract-paymenttype

Core residual peel — payment type catalog (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-paymenttype-api` | `api/` | `org.apache.fineract.paymenttype.api` | `PaymentTypeData` + request/response DTOs, read/write ports |
| `fineract-paymenttype-impl` | `impl/` | `org.apache.fineract.paymenttype.impl` | REST, handlers, MapStruct mappers, services, starter; Equinox `PaymentTypeOsgiBundleActivator` |
| `fineract-paymenttype-test` | `test/` | `org.apache.fineract.paymenttype.test` | Fragment-Host → impl |

### Residual in `fineract-core`

`PaymentType` entity, `PaymentTypeRepository`, `PaymentTypeNotFoundException` — used by payment-detail / charge / accounting JPA associations.

```bash
./gradlew :fineract-paymenttype-api:jar :fineract-paymenttype-impl:jar :fineract-paymenttype-test:test
```
