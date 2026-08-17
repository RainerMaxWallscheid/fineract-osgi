# fineract-useradministration

Provider peel — users / roles / permissions / password preferences (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-useradministration-api` | `api/` | `org.apache.fineract.useradministration.api` | Read/write ports + password policy DTO |
| `fineract-useradministration-impl` | `impl/` | `org.apache.fineract.useradministration.impl` | REST, handlers, write/read impls; Equinox `UserAdministrationOsgiBundleActivator` |
| `fineract-useradministration-test` | `test/` | `org.apache.fineract.useradministration.test` | Fragment-Host → impl |

### Residual in `fineract-core`

`AppUser` / `Role` / `Permission` JPA entities, repositories, wrappers, shared DTOs (`AppUserData`, `RoleData`, …), and auth exceptions (`UserNotFoundException`, `UnAuthenticatedUserException`) stay in core — used by security, commands, loan, client, organisation.

```bash
./gradlew :fineract-useradministration-api:jar :fineract-useradministration-impl:jar :fineract-useradministration-test:test
```
