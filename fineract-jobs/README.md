# fineract-jobs

Provider peel — scheduler / batch job infrastructure (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-jobs-api` | `api/` | `org.apache.fineract.jobs.api` | SPI (`JobNameProvider`, `JobParameterProvider`, …), exceptions, constants |
| `fineract-jobs-impl` | `impl/` | `org.apache.fineract.jobs.impl` | Domain, Quartz/Batch wiring, REST, OSGi |
| `fineract-jobs-test` | `test/` | `org.apache.fineract.jobs.test` | Fragment-Host → impl |

Shared DTOs / `SchedulerJobRunnerReadService` / `JobName` enum remain in **core**.

Residual on provider:
- COB / progressive-loan API filters
- Inline COB job REST (`InlineJobApiResource`, `InlineJobType`, `InlineJobExecuteHandler`)
- `LoanCOBJobParameterProvider`
- retained-earning job (loan product + accounting coupling)
- NPA update job

```bash
./gradlew :fineract-jobs-api:jar :fineract-jobs-impl:jar :fineract-jobs-test:test
```
