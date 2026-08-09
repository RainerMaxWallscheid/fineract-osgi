# fineract-openapi

Provider peel — OpenAPI reader / spec filter utilities (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-openapi-api` | `api/` | `org.apache.fineract.openapi.api` | `FineractOperationIdReader`, `FineractOpenApiSpecFilter` |
| `fineract-openapi-impl` | `impl/` | `org.apache.fineract.openapi.impl` | OSGi bridge |
| `fineract-openapi-test` | `test/` | `org.apache.fineract.openapi.test` | Fragment-Host → impl |

Used by `fineract-provider` swagger-gradle-plugin (`readerClass` / `filterClass` FQCNs).

```bash
./gradlew :fineract-openapi-api:jar :fineract-openapi-impl:jar :fineract-openapi-test:test
```
