# fineract-instancemode

Provider peel — instance mode test REST API (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-instancemode-api` | `api/` | `org.apache.fineract.instancemode.api` | Swagger request DTO + `FineractInstanceModeApiFilter` |
| `fineract-instancemode-impl` | `impl/` | `org.apache.fineract.instancemode.impl` | Test-profile REST resource; no Equinox port |
| `fineract-instancemode-test` | `test/` | `org.apache.fineract.instancemode.test` | Fragment-Host → impl |

Mode property constants (`FineractInstanceModeConstants`) remain in **core** (used by core event conditions). `FineractInstanceModeApiFilter` is on instancemode-api so security-impl stays api-only.

```bash
./gradlew :fineract-instancemode-api:jar :fineract-instancemode-impl:jar :fineract-instancemode-test:test
```
