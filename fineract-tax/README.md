# fineract-tax

Tax catalog (components / groups) — Wave 1 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-tax-api` | `api/` | `org.apache.fineract.tax.api` | Contracts: **moduleapi**, service interfaces, DTO tax helpers, exceptions |
| `fineract-tax-impl` | `impl/` | `org.apache.fineract.tax.impl` | JPA, handlers, REST, adapters; domain residual for provider |
| `fineract-tax-test` | `test/` | `org.apache.fineract.tax.test` | White-box tests; **Fragment-Host** → `tax.impl` |

No `:fineract-tax` façade.

### Module API

- `TaxCatalogPort` / definition data / `TaxComponentShareData`
- `ChargeTaxApplicationService.computeTax(taxGroupId, …)`
- `TaxReadPlatformService` / `TaxWritePlatformService`
- `TaxUtils` (DTO / core-data helpers)

### Consumers

| Module | Depend on |
|--------|-----------|
| charge-impl / loan / savings | **`-api` only** (`taxGroupId` / `taxComponentId` + ports) |
| provider / war / ITs | `-api` + `-impl` |

```bash
./gradlew :fineract-tax-api:jar :fineract-tax-impl:jar :fineract-tax-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-tax.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-tax.md).
