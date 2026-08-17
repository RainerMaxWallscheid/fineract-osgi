# fineract-accountnumberformat

Provider peel — account number format admin (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-accountnumberformat-api` | `api/` | `org.apache.fineract.accountnumberformat.api` | `AccountNumberFormatData`, read/write ports, not-found exception |
| `fineract-accountnumberformat-impl` | `impl/` | `org.apache.fineract.accountnumberformat.impl` | REST, handlers, services; Equinox `AccountNumberFormatOsgiBundleActivator` |
| `fineract-accountnumberformat-test` | `test/` | `org.apache.fineract.accountnumberformat.test` | Fragment-Host → impl |

### Residual in `fineract-core`

Entity, repository, enumerations, `EntityAccountType`, `AccountNumberFormatLookup`, constants, `AccountNumberGeneratorService` — used by loan/savings/group/share/WC number generation.

```bash
./gradlew :fineract-accountnumberformat-api:jar :fineract-accountnumberformat-impl:jar :fineract-accountnumberformat-test:test
```
