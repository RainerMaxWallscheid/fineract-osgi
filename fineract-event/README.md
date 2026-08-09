# fineract-event

Provider peel — business events + external event producers/serializers (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-event-api` | `api/` | `org.apache.fineract.event.api` | Kafka topic auto-create condition |
| `fineract-event-impl` | `impl/` | `org.apache.fineract.event.impl` | Domain business events, Avro mappers/serializers, JMS/Kafka producers, OSGi |
| `fineract-event-test` | `test/` | `org.apache.fineract.event.test` | Fragment-Host → impl |

Core already holds notifier/ports, ExternalEvent entity/repos, serializers factory, and job tasklets.

Residual on provider:
- share account business events + mappers/serializers (`ShareAccount` still on provider)
- deposit (FD/RD) business events + mappers/serializers (`FixedDepositAccount`/`RecurringDepositAccount` still on provider)
- loan `LoanAccountsStayedLocked*` mapper/serializer (COB residual event type)

```bash
./gradlew :fineract-event-api:jar :fineract-event-impl:jar :fineract-event-test:test
```
