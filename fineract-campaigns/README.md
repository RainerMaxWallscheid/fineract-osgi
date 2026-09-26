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

Email message assemble uses ClientActivePort/GroupActivePort/StaffPersistablePort (not leftover Client, Group, or Staff repositories).

SMS campaign group lookups use GroupActivePort.clientMemberIds (not leftover Group repository).

Email campaign outbound uses ClientActivePort (not leftover Client repository).

SMS campaign client lookups use ClientActivePort (not leftover Client repository).

Email execute report parameters use ClientActivePort and StaffPersistablePort.officeId (not leftover Client).

Email execute report run-as user uses AppUserPersistablePort (not leftover AppUser).

```bash
./gradlew :fineract-campaigns-api:jar :fineract-campaigns-impl:jar :fineract-campaigns-test:test
```
