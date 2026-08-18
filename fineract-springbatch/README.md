# fineract-springbatch

Provider peel — remote Spring Batch job messaging (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-springbatch-api` | `api/` | `org.apache.fineract.springbatch.api` | `ContextualMessage`, handler conditions |
| `fineract-springbatch-impl` | `impl/` | `org.apache.fineract.springbatch.impl` | Manager/worker configs (JMS/Kafka/Spring events), `PropertyServiceImpl`; Equinox `SpringBatchOsgiBundleActivator` |
| `fineract-springbatch-test` | `test/` | `org.apache.fineract.springbatch.test` | Fragment-Host → impl |

`PropertyService` + `SpringBatchJobConstants` live on **springbatch-api**.
cob-impl / jobs-impl / loan-impl / WC-impl depend on springbatch-api only.

```bash
./gradlew :fineract-springbatch-api:jar :fineract-springbatch-impl:jar :fineract-springbatch-test:test
```
