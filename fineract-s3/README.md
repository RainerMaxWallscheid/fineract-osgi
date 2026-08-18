# fineract-s3

Provider peel — AWS S3 client configuration (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-s3-api` | `api/` | `org.apache.fineract.s3.api` | `S3ClientCustomizer` SPI |
| `fineract-s3-impl` | `impl/` | `org.apache.fineract.s3.impl` | `AmazonS3Config`, Localstack customizer; Equinox `S3OsgiBundleActivator` |
| `fineract-s3-test` | `test/` | `org.apache.fineract.s3.test` | Fragment-Host → impl |

Wires `S3Client` when report S3 export is enabled; creates `S3DatatableReportExportServiceImpl` bean from **dataqueries-impl**.

```bash
./gradlew :fineract-s3-api:jar :fineract-s3-impl:jar :fineract-s3-test:test
```
