# fineract-loan-origination

Loan originator catalog + attach/detach mappings (standard loan + working-capital) — Wave 2 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-loan-origination-api` | `api/` | `org.apache.fineract.loanorigination.api` | Contracts: service interfaces, DTOs (incl. `LoanOriginatorData`), exceptions, `LoanOriginatorStatus` |
| `fineract-loan-origination-impl` | `impl/` | `org.apache.fineract.loanorigination.impl` | JPA, REST, handlers, Avro enrichers; Equinox DS `OSGI-INF/loan-origination.xml` |
| `fineract-loan-origination-test` | `test/` | `org.apache.fineract.loanorigination.test` | White-box tests; **Fragment-Host** → `loanorigination.impl` |

No `:fineract-loan-origination` façade.

### Module API

- `LoanOriginatorReadPlatformService`, `LoanOriginatorWritePlatformService`
- `WorkingCapitalLoanOriginatorWritePlatformService`
- Pure DTOs under `…loanorigination.data` (includes former core `LoanOriginatorData`)
- Pure enum `LoanOriginatorStatus` in `…moduleapi`
- Exceptions under `…exception`

### Consumers

| Module | Depend on |
|--------|-----------|
| loan, working-capital-loan | **`-api` only** (`LoanOriginatorData`) |
| provider / war / architecture | `-api` + `-impl` (composition root) |

```bash
./gradlew :fineract-loan-origination-api:jar :fineract-loan-origination-impl:jar :fineract-loan-origination-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-loan-origination.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-loan-origination.md).
