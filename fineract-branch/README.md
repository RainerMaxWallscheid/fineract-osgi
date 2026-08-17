# fineract-branch

Branch cash / teller (cashier allocation and cash settle) — Wave 2 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-branch-api` | `api/` | `org.apache.fineract.branch.api` | Contracts: service interfaces, DTOs, exceptions, pure enums, **`CashierTxnValidationPort`** |
| `fineract-branch-impl` | `impl/` | `org.apache.fineract.branch.impl` | JPA, REST, handlers, service impls, starter; Equinox `BranchOsgiBundleActivator` |
| `fineract-branch-test` | `test/` | `org.apache.fineract.branch.test` | White-box tests; **Fragment-Host** → `branch.impl` |

No `:fineract-branch` façade. Depend on `-api`; composition roots also take `-impl`.

### Module API

- `TellerManagementReadPlatformService`, `TellerWritePlatformService`, `TellerTransactionWritePlatformService`
- **`CashierTxnValidationPort`** (loan cash disbursal validation)
- Pure DTOs under `…teller.data`
- Pure value types: `TellerStatus`, `CashierTxnType` in `…teller.moduleapi`
- Exceptions under `…teller.exception`

Service impls + `OrganisationTellerConfiguration` live in **branch-impl**. Loan uses **`CashierTxnValidationPort`** only (no validator / domain types).

### Consumers

| Module | Depend on |
|--------|-----------|
| provider / war / architecture | `-api` + `-impl` (composition root; Spring classpath) |
| loan path (in provider) | port on `-api` only for cashier validation |

```bash
./gradlew :fineract-branch-api:jar :fineract-branch-impl:jar :fineract-branch-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-branch.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-branch.md).
