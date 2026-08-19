# fineract-spm

Provider peel — SPM surveys / scorecards (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-spm-api` | `api/` | `org.apache.fineract.spm.api` | DTOs, exceptions, `ScorecardReadPlatformService`, constants |
| `fineract-spm-impl` | `impl/` | `org.apache.fineract.spm.impl` | REST, JPA, services; Equinox DS `OSGI-INF/spm.xml` |
| `fineract-spm-test` | `test/` | `org.apache.fineract.spm.test` | Fragment-Host → impl |

Self-contained provider peel. Uses `Client` / `AppUser` from `fineract-core` (kernel residual).

```bash
./gradlew :fineract-spm-api:jar :fineract-spm-impl:jar :fineract-spm-test:test
```
