# fineract-businessdate

**Core slice** extracted from `fineract-core` (ADR-022 / Wave 4 optional core slices).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-businessdate-api` | `api/` | `org.apache.fineract.businessdate.api` | Ports, DTOs, exceptions |
| `fineract-businessdate-impl` | `impl/` | `org.apache.fineract.businessdate.impl` | JPA, REST, handlers, registrar |
| `fineract-businessdate-test` | `test/` | `org.apache.fineract.businessdate.test` | Fragment-Host → impl |

### Kernel residual in core

`BusinessDateType` remains in **`fineract-core`** (`…businessdate.domain`) so `ThreadLocalContextUtil` / `ActionContext` / `FineractContext` do not create a core↔api Gradle cycle.

```bash
./gradlew :fineract-businessdate-api:jar :fineract-businessdate-impl:jar :fineract-businessdate-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).
