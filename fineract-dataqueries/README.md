# fineract-dataqueries

Provider peel — reports, datatables, entity checks (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-dataqueries-api` | `api/` | `org.apache.fineract.dataqueries.api` | Ports, extra DTOs, exceptions |
| `fineract-dataqueries-impl` | `impl/` | `org.apache.fineract.dataqueries.impl` | Entities, REST, handlers, export; Equinox DS `OSGI-INF/dataqueries.xml` |
| `fineract-dataqueries-test` | `test/` | `org.apache.fineract.dataqueries.test` | Fragment-Host → impl |

Shared DTOs/ports already in `fineract-core` (`ReportData`, `DatatableReadService`, `GenericDataService`, …). This peel hosts entities (`Report`, …) and platform implementations.

```bash
./gradlew :fineract-dataqueries-api:jar :fineract-dataqueries-impl:jar :fineract-dataqueries-test:test
```
