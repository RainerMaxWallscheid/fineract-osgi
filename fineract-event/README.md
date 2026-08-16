# fineract-event

Provider peel — business events + external event producers/serializers (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-event-api` | `api/` | `org.apache.fineract.event.api` | Kafka topic auto-create condition |
| `fineract-event-impl` | `impl/` | `org.apache.fineract.event.impl` | Domain business events, Avro mappers/serializers, JMS/Kafka producers, OSGi |
| `fineract-event-test` | `test/` | `org.apache.fineract.event.test` | Fragment-Host → impl |

Core residual (kernel outbox path): notifier/ports, `ExternalEvent` entity/repos, `ExternalEventService`, serializer SPI/factory, message factories, producer port + noop.

This peel also hosts external-event **jobs**, **configuration REST**, startup validation, and internal test APIs (moved from core).

Residual on provider:
- share/FD/RD **mappers/serializers** (need residual read services: `ShareAccountReadPlatformService`, `DepositAccountReadPlatformService`, share product read)

Closed residual (core → event-impl):
- External event configuration REST/handlers/DTOs + validation + send/purge jobs + task executor

Closed residual:
- `LoanAccountsStayedLocked*` types in cob-api; mappers/serializers in event-impl
- FD/RD Avro **mappers** → event-impl (DTOs already on savings-api)
- `ShareProductDividentsCreateBusinessEvent` → event-impl
- share/FD/RD **business events** → event-impl via `PortfolioAccountEventData` (accountId + officeId; no entity coupling)

```bash
./gradlew :fineract-event-api:jar :fineract-event-impl:jar :fineract-event-test:test
```
