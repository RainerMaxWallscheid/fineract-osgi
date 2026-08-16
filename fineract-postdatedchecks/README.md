# fineract-postdatedchecks

Core residual peel — repayment with post-dated checks (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-postdatedchecks-api` | `api/` | `org.apache.fineract.postdatedchecks.api` | Ports, DTOs, status, exceptions |
| `fineract-postdatedchecks-impl` | `impl/` | `org.apache.fineract.postdatedchecks.impl` | REST, handlers, OSGi registrar |
| `fineract-postdatedchecks-test` | `test/` | `org.apache.fineract.postdatedchecks.test` | Fragment-Host → impl |

Entity, assembler, and read/write impls stay in `fineract-loan-impl`.

```bash
./gradlew :fineract-postdatedchecks-api:jar :fineract-postdatedchecks-impl:jar :fineract-postdatedchecks-test:test
```
