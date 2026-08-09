# fineract-instancemode

Provider peel — instance mode test REST API (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-instancemode-api` | `api/` | `org.apache.fineract.instancemode.api` | Swagger request DTO |
| `fineract-instancemode-impl` | `impl/` | `org.apache.fineract.instancemode.impl` | Test-profile REST resource, OSGi bridge |
| `fineract-instancemode-test` | `test/` | `org.apache.fineract.instancemode.test` | Fragment-Host → impl |

Mode property constants (`FineractInstanceModeConstants`) and `FineractInstanceModeApiFilter` remain in **core** (used by conditions and the servlet filter chain).

```bash
./gradlew :fineract-instancemode-api:jar :fineract-instancemode-impl:jar :fineract-instancemode-test:test
```
