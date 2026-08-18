# fineract-sms

Provider peel — outbound SMS messages (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-sms-api` | `api/` | `org.apache.fineract.sms.api` | Ports, DTOs, exceptions, constants |
| `fineract-sms-impl` | `impl/` | `org.apache.fineract.sms.impl` | Entity, REST, handlers; Equinox `SmsOsgiBundleActivator` |
| `fineract-sms-test` | `test/` | `org.apache.fineract.sms.test` | Fragment-Host → impl |

Residual on provider:
- `SmsMessageScheduledJobService` (+ impl) — campaigns `SmsConfigUtils` + GCM notification coupling
- `SmsCampaign` stays in campaigns; `SmsMessage.campaignId` is a Long FK

```bash
./gradlew :fineract-sms-api:jar :fineract-sms-impl:jar :fineract-sms-test:test
```
