# fineract-notification

Provider peel — in-app user notifications (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-notification-api` | `api/` | `org.apache.fineract.notification.api` | Read/write ports, event publisher port, DTOs |
| `fineract-notification-impl` | `impl/` | `org.apache.fineract.notification.impl` | REST, JPA, JMS/ActiveMQ; Equinox `NotificationOsgiBundleActivator` |
| `fineract-notification-test` | `test/` | `org.apache.fineract.notification.test` | Fragment-Host → impl |

### Module API

- `UserNotificationService` + `NotificationData` (security filter is **notification-api only**)
- `NotificationReadPlatformService` / `NotificationWritePlatformService`
- `NotificationEventPublisher`

### Residual closed

`NotificationDomainServiceImpl` + `NotificationDomainServiceConfiguration` → **impl** (listens to loan/savings events and share/FD/RD events carrying `PortfolioAccountEventData`).

```bash
./gradlew :fineract-notification-api:jar :fineract-notification-impl:jar :fineract-notification-test:test
```
