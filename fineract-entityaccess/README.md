# fineract-entityaccess

Provider peel — office-specific product/charge access mappings (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-entityaccess-api` | `api/` | `org.apache.fineract.entityaccess.api` | Ports, DTOs, access types, exceptions |
| `fineract-entityaccess-impl` | `impl/` | `org.apache.fineract.entityaccess.impl` | REST, JPA, util, validators, OSGi registrar |
| `fineract-entityaccess-test` | `test/` | `org.apache.fineract.entityaccess.test` | Fragment-Host → impl |

### Consumers

Provider residual (loan product/savings product/charge adapters) injects `FineractEntityAccessUtil` and access types via composition root.

### Impl deps

Validates mapped entities via loan/savings product repositories and charge-api ports.

```bash
./gradlew :fineract-entityaccess-api:jar :fineract-entityaccess-impl:jar :fineract-entityaccess-test:test
```
