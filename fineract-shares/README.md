# fineract-shares

Core residual peel — share products, share accounts, generic accounts API (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-shares-api` | `api/` | `org.apache.fineract.shares.api` | Ports, pure DTOs, constants, exceptions |
| `fineract-shares-impl` | `impl/` | `org.apache.fineract.shares.impl` | REST, handlers, JDBC reads, dividend job, OSGi registrar |
| `fineract-shares-test` | `test/` | `org.apache.fineract.shares.test` | Fragment-Host → impl |

### Residual

**Kernel residual in `fineract-core`:** `ShareProduct*` JPA entities/repos, dividend entity residual,
status enums, `SharePeriodFrequencyType`, and DTOs coupled to account-details/charge conversion
(`ShareAccountChargeData`, `ShareAccountStatusEnumData`, `ShareAccountApplicationTimelineData`).

**Composition-root residual:** product write/read serializers in `fineract-charge-impl`; account entity in
`fineract-savings-impl`; account write/read/schedular in `fineract-progressive-loan-impl`.

```bash
./gradlew :fineract-shares-api:jar :fineract-shares-impl:jar :fineract-shares-test:test
```
