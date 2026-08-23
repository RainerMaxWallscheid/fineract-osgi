# fineract-gcm

Provider peel — FCM/GCM push notification client (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-gcm-api` | `api/` | `org.apache.fineract.gcm.api` | Config DTO + `NotificationConfigurationReadService` / `NotificationSenderService` ports |
| `fineract-gcm-impl` | `impl/` | `org.apache.fineract.gcm.impl` | Sender client + `NotificationSenderServiceImpl`; Equinox DS `OSGI-INF/gcm.xml` |
| `fineract-gcm-test` | `test/` | `org.apache.fineract.gcm.test` | Fragment-Host → impl |

Configuration residual implements `NotificationConfigurationReadService` via `ExternalServicesPropertiesReadPlatformService`.

```bash
./gradlew :fineract-gcm-api:jar :fineract-gcm-impl:jar :fineract-gcm-test:test
```
