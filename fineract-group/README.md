# fineract-group

Core residual peel — groups/centers pure services, handlers, and levels API (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-group-api` | `api/` | `org.apache.fineract.group.api` | Read/write ports, enumerations helper |
| `fineract-group-impl` | `impl/` | `org.apache.fineract.group.impl` | Levels REST, handlers, validators, JDBC reads, roles write, OSGi |
| `fineract-group-test` | `test/` | `org.apache.fineract.group.test` | Fragment-Host → impl |

### Residual

**Kernel residual in `fineract-core`:** `Group`/`GroupLevel`/`GroupRole` entities and repos, shared DTOs
(`GroupGeneralData`, `CenterData`, …), exceptions, `GroupingTypesApiConstants`.

**Composition-root residual:** Centers/Groups REST + `GroupingTypesWritePlatformServiceJpaRepositoryImpl`
in `fineract-progressive-loan-impl`.

```bash
./gradlew :fineract-group-api:jar :fineract-group-impl:jar :fineract-group-test:test
```
