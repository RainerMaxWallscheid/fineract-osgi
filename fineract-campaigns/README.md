# fineract-campaigns

Provider peel — SMS/email campaigns (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-campaigns-api` | `api/` | `org.apache.fineract.campaigns.api` | Ports, DTOs, exceptions, constants |
| `fineract-campaigns-impl` | `impl/` | `org.apache.fineract.campaigns.impl` | Entities, REST, handlers, jobs; Equinox DS `OSGI-INF/campaigns.xml` |
| `fineract-campaigns-test` | `test/` | `org.apache.fineract.campaigns.test` | Fragment-Host → impl |

Report FKs are Long (`businessRuleId` / `stretchyReportId`). Residual on provider: **closed** —
SMS/email campaign write, domain service, `SmsConfigUtils`, gateway/email batch jobs, and
`SmsMessageScheduledJobService` live in campaigns-impl (deps: dataqueries, gcm, configuration, loan, savings, event).

`TwoFactorSmsDeliveryPort` (api) + adapter (impl) deliver 2FA OTP SMS for security-impl and client SMS for hooks message-gateway.

```bash
./gradlew :fineract-campaigns-api:jar :fineract-campaigns-impl:jar :fineract-campaigns-test:test
```
