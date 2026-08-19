# fineract-clients

Core residual peel — client pure REST/handlers/services (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-clients-api` | `api/` | `org.apache.fineract.clients.api` | Ports, pure DTOs/requests, search v2 API types |
| `fineract-clients-impl` | `impl/` | `org.apache.fineract.clients.impl` | Family/identifiers/transactions REST, handlers, pure write/read impls, search; Equinox DS `OSGI-INF/clients.xml` |
| `fineract-clients-test` | `test/` | `org.apache.fineract.clients.test` | Fragment-Host → impl; `ClientDataValidatorTest` |

### Residual

**Kernel residual in `fineract-core`:** `Client` entity hub + related domain, `ClientData` and nested DTOs,
`ClientApiConstants`, exceptions.

**Composition-root residual:** main Clients REST + main client write/read/template in progressive-loan;
charges REST/entities in charge-impl; address REST/entities in address-impl.

```bash
./gradlew :fineract-clients-api:jar :fineract-clients-impl:jar :fineract-clients-test:test
```
