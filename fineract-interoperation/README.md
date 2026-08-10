# fineract-interoperation

Provider peel — Mojaloop / interoperation (Hathor) API (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-interoperation-api` | `api/` | `org.apache.fineract.interoperation.api` | Ports, DTOs, pure domain enums, exceptions |
| `fineract-interoperation-impl` | `impl/` | `org.apache.fineract.interoperation.impl` | REST, handlers, service, repository, OSGi |
| `fineract-interoperation-test` | `test/` | `org.apache.fineract.interoperation.test` | Fragment-Host → impl |

### Residual

- `InteropIdentifier` entity stays in **savings-impl** (`@ManyToOne` SavingsAccount)
- `InteropIdentifierType` stays in **core** (shared identifier resolution)
- Pure domain enums live in **interoperation-api**; savings-impl depends on interoperation-api for those types

```bash
./gradlew :fineract-interoperation-api:jar :fineract-interoperation-impl:jar :fineract-interoperation-test:test
```
