# fineract-bulkimport

Provider peel — Excel workbook import (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-bulkimport-api` | `api/` | `org.apache.fineract.bulkimport.api` | Constants, SPI interfaces, extra DTOs |
| `fineract-bulkimport-impl` | `impl/` | `org.apache.fineract.bulkimport.impl` | Handlers, populators, domain, REST; Equinox `BulkImportOsgiBundleActivator` |
| `fineract-bulkimport-test` | `test/` | `org.apache.fineract.bulkimport.test` | Fragment-Host → impl; `LookupModeTest` |

Public ports `BulkImportWorkbookService` / `BulkImportWorkbookPopulatorService` and
`GlobalEntityType` / `ImportData` / `LookupMode` live on **bulkimport-api**.
REST consumers (loan, savings, organisation, accounting, shares, useradmin, progressive-loan)
depend on bulkimport-api only.

Guarantor import residual **closed** (`GuarantorImportHandler` in bulkimport-impl; guarantor DTOs on loan-impl).

Residual on provider (share not peeled):
- `BulkImportWorkbookPopulatorServiceImpl` (orchestrates all workbook templates; needs share product ports)
- shared-account import handler + workbook populators

```bash
./gradlew :fineract-bulkimport-api:jar :fineract-bulkimport-impl:jar :fineract-bulkimport-test:test
```
