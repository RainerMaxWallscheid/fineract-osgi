# fineract-search

Core residual peel — global search / ad-hoc loan search API (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-search-api` | `api/` | `org.apache.fineract.search.api` | `SearchReadService`, `SearchData`/`SearchConditions`, ad-hoc DTOs |
| `fineract-search-impl` | `impl/` | `org.apache.fineract.search.impl` | REST, `SearchReadServiceImpl`, starter; Equinox `SearchOsgiBundleActivator` |
| `fineract-search-test` | `test/` | `org.apache.fineract.search.test` | Fragment-Host → impl |

### Residual in `fineract-core`

Shared advanced-query types used by dataqueries/savings (`SearchUtil`, `AdvancedQuery*`, `ColumnFilterData`, `FilterData`, `TableQueryData`, `TransactionSearchRequest`, `SearchConstants`).

```bash
./gradlew :fineract-search-api:jar :fineract-search-impl:jar :fineract-search-test:test
```
