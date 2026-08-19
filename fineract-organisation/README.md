# fineract-organisation

**Core slice** — office / staff / holiday / working days / provisioning (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-organisation-api` | `api/` | `org.apache.fineract.organisation.api` | Read/write ports + pure DTOs / exceptions |
| `fineract-organisation-impl` | `impl/` | `org.apache.fineract.organisation.impl` | REST, handlers, services, JPA wrappers; Equinox DS `OSGI-INF/organisation.xml` |
| `fineract-organisation-test` | `test/` | `org.apache.fineract.organisation.test` | Fragment-Host → impl |

### Residual in `fineract-core`

- `Office` / `Staff` JPA entities, repositories, wrappers, platform exceptions, shared DTOs
- `Holiday` / `WorkingDays` entities, status/reschedule enums, schedule utils (`HolidayUtil`, `WorkingDaysUtil`, `AdjustedDateDetailsDTO`)

### Residual in organisation-impl (not pure api)

- `ProvisioningCriteriaData` + `ProvisioningCriteriaReadPlatformService` (reference `LoanProductData` from loan-impl)
- Criteria/category entities and loan-product mapping (`LoanProductProvisionCriteria`)
- Impl depends on **loan-impl** + **accounting-api** for criteria assembly / entries checks

```bash
./gradlew :fineract-organisation-api:jar :fineract-organisation-impl:jar :fineract-organisation-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).
