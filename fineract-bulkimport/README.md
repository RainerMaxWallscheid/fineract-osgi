# fineract-bulkimport

Provider peel — Excel workbook import (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-bulkimport-api` | `api/` | `org.apache.fineract.bulkimport.api` | Constants, SPI interfaces, extra DTOs |
| `fineract-bulkimport-impl` | `impl/` | `org.apache.fineract.bulkimport.impl` | Handlers, populators, domain, REST, OSGi |
| `fineract-bulkimport-test` | `test/` | `org.apache.fineract.bulkimport.test` | Fragment-Host → impl |

Public ports `BulkImportWorkbookService` / `BulkImportWorkbookPopulatorService` and main DTOs already live in **core**.

Residual on provider (share / guarantor not peeled):
- `BulkImportWorkbookPopulatorServiceImpl` (orchestrates all workbook templates; needs share product ports)
- shared-account import handler + workbook populators
- `GuarantorImportHandler` (`GuarantorData` still on provider)

```bash
./gradlew :fineract-bulkimport-api:jar :fineract-bulkimport-impl:jar :fineract-bulkimport-test:test
```
