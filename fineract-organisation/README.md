# fineract-organisation

**Core slice** — office / staff application (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-organisation-api` | `api/` | `org.apache.fineract.organisation.api` | Read ports (`OfficeReadPlatformService`, `StaffReadService`) |
| `fineract-organisation-impl` | `impl/` | `org.apache.fineract.organisation.impl` | REST, handlers, write services, `OrganisationOsgiServiceRegistrar` |
| `fineract-organisation-test` | `test/` | `org.apache.fineract.organisation.test` | Fragment-Host → impl |

### Residual in `fineract-core`

`Office` / `Staff` JPA entities, repositories, wrappers, platform exceptions, and shared DTOs (`OfficeData`, `StaffData`) stay in core (Client/Group/Loan entity graph; avoids core↔organisation-api cycles).

```bash
./gradlew :fineract-organisation-api:jar :fineract-organisation-impl:jar :fineract-organisation-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).
