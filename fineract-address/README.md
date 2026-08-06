# fineract-address

Provider peel — client addresses and field configuration (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-address-api` | `api/` | `org.apache.fineract.address.api` | Ports, DTOs, filter, exception |
| `fineract-address-impl` | `impl/` | `org.apache.fineract.address.impl` | REST, Address/ClientAddress JPA, services, OSGi registrar |
| `fineract-address-test` | `test/` | `org.apache.fineract.address.test` | Fragment-Host → impl |

### Residual

- `AddressData` stays in `fineract-core` (embedded in `ClientData`).
- Client residual APIs/handlers in provider use address-api ports; `ClientAddress` entity lives on address-impl.

```bash
./gradlew :fineract-address-api:jar :fineract-address-impl:jar :fineract-address-test:test
```
