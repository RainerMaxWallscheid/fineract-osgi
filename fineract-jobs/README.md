# fineract-jobs

Provider peel — scheduler / batch job infrastructure (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-jobs-api` | `api/` | `org.apache.fineract.jobs.api` | SPI (`JobNameProvider`, `JobParameterProvider`, …), exceptions, constants |
| `fineract-jobs-impl` | `impl/` | `org.apache.fineract.jobs.impl` | Domain, Quartz/Batch wiring, REST, OSGi |
| `fineract-jobs-test` | `test/` | `org.apache.fineract.jobs.test` | Fragment-Host → impl |

Shared DTOs / `SchedulerJobRunnerReadService` / `JobName` enum remain in **core**.

**Jobs residual closed** — no `infrastructure.jobs` sources remain on provider.

Closed into jobs-impl:
- Inline job REST + handler (`InlineJobType` resolves executor beans by Spring name)
- `LoanCOBJobParameterProvider` (uses `COBConstant` from cob-impl)
- Retained-earning + NPA jobs
- COB / progressive / WC API filters (lock/executor via Spring `@Qualifier`; `LoanCOBEnabledCondition` on cob-impl)

Kernel: `BodyCachingHttpServletRequestWrapper` moved to **fineract-core**.

```bash
./gradlew :fineract-jobs-api:jar :fineract-jobs-impl:jar :fineract-jobs-test:test
```
