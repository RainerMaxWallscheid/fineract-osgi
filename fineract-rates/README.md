# fineract-rates

Floating Rates catalog — Wave 1 OSGi modularization (after charge)
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-rates-api` | `api/` | `org.apache.fineract.rates.api` | Contracts: **moduleapi**, data DTOs, service interfaces, exceptions |
| `fineract-rates-impl` | `impl/` | `org.apache.fineract.rates.impl` | JPA, handlers, REST, Spring; **Export-Package** registrar only (`…floatingrates.impl.osgi`) |
| `fineract-rates-test` | `test/` | `org.apache.fineract.rates.test` | White-box tests; **Fragment-Host** → `rates.impl` |

No `:fineract-rates` façade. Depend on `-api`; composition roots also take `-impl`.

### Module API

- `FloatingRatePort` / `FloatingRateDefinitionData`
- `FloatingRatesReadPlatformService`, `FloatingRateWritePlatformService` interfaces
- Pure DTOs under `…floatingrates.data`
- `RateReadService` / `RateWriteService` + `RateData` (loan Rate catalog)

### Consumers

| Module | Depend on |
|--------|-----------|
| savings | `-api` only |
| loan | `-api` only (`floatingRateId` + `FloatingRatePort`; `RateData` / `RateReadService`) |
| provider / war / ITs | `-api` + `-impl` |


### Loan Rate catalog residual

`portfolio.rate` REST/handlers/assembler/read-write impls live in **rates-impl**.
`RateData` + read/write ports live in **rates-api**.
Entity `Rate` + `RateAppliesTo` + repo/wrapper + `RateNotFoundException` remain in **core**
(loan `@ManyToOne Rate` coupling).
Floating rates remain under `portfolio.floatingrates`.

```bash
./gradlew :fineract-rates-api:jar :fineract-rates-impl:jar :fineract-rates-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-rates.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-rates.md).
