# fineract-reportmailingjob

Provider peel — scheduled report email jobs (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-reportmailingjob-api` | `api/` | `org.apache.fineract.reportmailingjob.api` | Ports, DTOs, exceptions, constants |
| `fineract-reportmailingjob-impl` | `impl/` | `org.apache.fineract.reportmailingjob.impl` | Entities, REST, email, OSGi |
| `fineract-reportmailingjob-test` | `test/` | `org.apache.fineract.reportmailingjob.test` | Fragment-Host → impl |

`stretchyReportId` is a Long FK (dataqueries `Report` residual on provider). AppUser stays `@ManyToOne` (core).

Campaign residual: `ExecuteReportMailingJobs*` loads report via `ReportRepositoryWrapper`.

```bash
./gradlew :fineract-reportmailingjob-api:jar :fineract-reportmailingjob-impl:jar :fineract-reportmailingjob-test:test
```
