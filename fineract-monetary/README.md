# fineract-monetary

**Core slice** — currency admin REST / read ports (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-monetary-api` | `api/` | `org.apache.fineract.monetary.api` | Currency ports, admin DTOs, update command |
| `fineract-monetary-impl` | `impl/` | `org.apache.fineract.monetary.impl` | Currencies API, handlers, read impls, `MonetaryOsgiServiceRegistrar` |
| `fineract-monetary-test` | `test/` | `org.apache.fineract.monetary.test` | Fragment-Host → impl |

### Residual in `fineract-core`

`Money` / `MonetaryCurrency` / `CurrencyData` / currency entities & repos, plus `CurrencyMapper` (MapStruct used by loan/investor) stay in core.

### Residual in `fineract-provider`

`CurrencyWritePlatformServiceJpaRepositoryImpl` and `OrganisationMonetaryConfiguration` remain in provider (write path couples to loan/savings/charge product read services).

```bash
./gradlew :fineract-monetary-api:jar :fineract-monetary-impl:jar :fineract-monetary-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).
