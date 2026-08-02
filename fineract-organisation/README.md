# fineract-organisation

**Core slice** — office / staff / holiday / working days (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-organisation-api` | `api/` | `org.apache.fineract.organisation.api` | Read ports + admin DTOs (office, staff, holiday, working days) |
| `fineract-organisation-impl` | `impl/` | `org.apache.fineract.organisation.impl` | REST, handlers, write services, repos wrappers, `OrganisationOsgiServiceRegistrar` |
| `fineract-organisation-test` | `test/` | `org.apache.fineract.organisation.test` | Fragment-Host → impl |

### Residual in `fineract-core`

- `Office` / `Staff` JPA entities, repositories, wrappers, platform exceptions, shared DTOs
- `Holiday` / `WorkingDays` entities, status/reschedule enums, `HolidayUtil` / `WorkingDaysUtil`, `AdjustedDateDetailsDTO` (loan/savings schedule kernel)

### Residual in `fineract-provider`

Organisation **provisioning** remains in provider (loan-product coupling).

```bash
./gradlew :fineract-organisation-api:jar :fineract-organisation-impl:jar :fineract-organisation-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).
