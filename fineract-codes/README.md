# fineract-codes

**Core slice** — code / code-value catalog (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-codes-api` | `api/` | `org.apache.fineract.codes.api` | Pure DTOs, read ports, swagger models |
| `fineract-codes-impl` | `impl/` | `org.apache.fineract.codes.impl` | REST, handlers, read/write services; Equinox DS `OSGI-INF/codes.xml` |
| `fineract-codes-test` | `test/` | `org.apache.fineract.codes.test` | Fragment-Host → impl |

### Residual in `fineract-core`

JPA `Code` / `CodeValue`, repositories, wrappers, platform exceptions, and `CodeValueMapper` stay in core (Client/Group/GLAccount leftover hub graph; avoids core↔codes cycle). Domain `*-impl` entities store code-value id (not leftover CodeValue). Remaining leftover CodeValue JPA is only in `fineract-core`.

Core re-exports `codes-api` so existing `CodeValueData` consumers keep working.

```bash
./gradlew :fineract-codes-api:jar :fineract-codes-impl:jar :fineract-codes-test:test
```
