# fineract-adhocquery

Provider peel — ad-hoc SQL queries (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-adhocquery-api` | `api/` | `org.apache.fineract.adhocquery.api` | Ports, DTOs, `ReportRunFrequency`, exceptions |
| `fineract-adhocquery-impl` | `impl/` | `org.apache.fineract.adhocquery.impl` | REST, entity, handlers, services, `AdhocQueryOsgiServiceRegistrar` |
| `fineract-adhocquery-test` | `test/` | `org.apache.fineract.adhocquery.test` | Fragment-Host → impl |

```bash
./gradlew :fineract-adhocquery-api:jar :fineract-adhocquery-impl:jar :fineract-adhocquery-test:test
```
