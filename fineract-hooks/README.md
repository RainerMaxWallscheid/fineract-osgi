# fineract-hooks

Provider peel — webhooks / external event hooks (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-hooks-api` | `api/` | `org.apache.fineract.hooks.api` | Ports, DTOs, exceptions, constants |
| `fineract-hooks-impl` | `impl/` | `org.apache.fineract.hooks.impl` | Entities, REST, processors; Equinox DS `OSGI-INF/hooks.xml` |
| `fineract-hooks-test` | `test/` | `org.apache.fineract.hooks.test` | Fragment-Host → impl |

Residual: **closed** — `MessageGatewayHookProcessor` in hooks-impl (sms + campaigns scheduler).
`HookEvent` / `HookEventSource` residual in core for command processing.

```bash
./gradlew :fineract-hooks-api:jar :fineract-hooks-impl:jar :fineract-hooks-test:test
```
