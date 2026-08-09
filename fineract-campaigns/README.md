# fineract-campaigns

Provider peel — SMS/email campaigns (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-campaigns-api` | `api/` | `org.apache.fineract.campaigns.api` | Ports, DTOs, exceptions, constants |
| `fineract-campaigns-impl` | `impl/` | `org.apache.fineract.campaigns.impl` | Entities, REST, handlers, jobs, OSGi |
| `fineract-campaigns-test` | `test/` | `org.apache.fineract.campaigns.test` | Fragment-Host → impl |

Report FKs are Long (`businessRuleId` / `stretchyReportId`). Residual on provider:
- SMS/email campaign write + SMS domain service (dataqueries `ReadReportingService` / `Report`)
- `SmsConfigUtils`, dropdown read, gateway delivery jobs (configuration / GCM)
- ExecuteEmail / UpdateEmailOutbound / ExecuteReportMailingJobs tasklets

```bash
./gradlew :fineract-campaigns-api:jar :fineract-campaigns-impl:jar :fineract-campaigns-test:test
```
