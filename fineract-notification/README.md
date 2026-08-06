# fineract-notification

Provider peel — in-app user notifications (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-notification-api` | `api/` | `org.apache.fineract.notification.api` | Read/write ports, event publisher port, DTOs |
| `fineract-notification-impl` | `impl/` | `org.apache.fineract.notification.impl` | REST, JPA, JMS/ActiveMQ, write path, `NotificationOsgiServiceRegistrar` |
| `fineract-notification-test` | `test/` | `org.apache.fineract.notification.test` | Fragment-Host → impl |

### Residual in `fineract-core`

`UserNotificationService` + `NotificationData` stay in core (used by security filter).

### Residual in `fineract-provider`

`NotificationDomainServiceImpl` + `NotificationDomainServiceConfiguration` — business-event listeners need Loan/Savings/Share residual entities still hosted in provider.

```bash
./gradlew :fineract-notification-api:jar :fineract-notification-impl:jar :fineract-notification-test:test
```
