# fineract-investor

External asset owner (investor) transfers — Wave 3 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-investor-api` | `api/` | `org.apache.fineract.investor.api` | Pure ports, DTOs/status enums, exceptions |
| `fineract-investor-impl` | `impl/` | `org.apache.fineract.investor.impl` | JPA, REST, COB step, enrichers; Equinox DS `OSGI-INF/investor.xml` |
| `fineract-investor-test` | `test/` | `org.apache.fineract.investor.test` | White-box tests; **Fragment-Host** → `investor.impl` |

No `:fineract-investor` façade.

### Module API (api)

- `ExternalAssetOwnersReadService` / `WriteService`
- `ExternalAssetOwnerLoanProductAttributesReadService` / `WriteService`
- `DelayedSettlementAttributeService`
- Pure DTOs + `ExternalTransferStatus` / `ExternalTransferSubStatus`
- Domain exceptions

### Residual (impl, composition root)

Provider journal/loan poster still uses **entities** (`ExternalAssetOwner*`) and `AccountingService` (entity-typed port) from **impl**.

### Consumers

| Module | Depend on |
|--------|-----------|
| provider / war / architecture / ITs | `-api` + `-impl` |

```bash
./gradlew :fineract-investor-api:jar :fineract-investor-impl:jar :fineract-investor-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-investor.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-investor.md).
