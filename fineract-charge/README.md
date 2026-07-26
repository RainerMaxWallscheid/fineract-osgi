# fineract-charge

Charge Catalog bounded context — OSGi modularization **as-built** for Steps 0–7, 9; Step 8 **partial**
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-charge-api` | `api/` | `org.apache.fineract.charge.api` | Contracts: **Export-Package** `moduleapi`, pure enums `domain`, catalog `exception` |
| `fineract-charge-impl` | `impl/` | `org.apache.fineract.charge.impl` | JPA catalog, services, REST, Spring; **Export-Package** `starter` only; OSGi registrar |
| `fineract-charge-test` | `test/` | `org.apache.fineract.charge.test` | White-box tests; **Fragment-Host** → `org.apache.fineract.charge.impl` |
| `fineract-charge` | `.` | *(façade)* | Re-exports api + impl for Boot composition root (not a long-term OSGi feature) |

Inter-bundle access: **OSGi Service Registry** via `ChargeOsgiServiceRegistrar`
(`ChargeDefinitionPort` when `BundleContext` is present). Not Karaf Features.
Spring stays inside **impl**; Boot without OSGi is unchanged (registrar no-ops).

```bash
./gradlew :fineract-charge-api:jar :fineract-charge-impl:jar :fineract-charge-test:jar
./gradlew :fineract-charge-test:test
```

### Consumer Gradle edges (Steps 7–8)

| Module | Depend on |
|--------|-----------|
| progressive-loan | `:fineract-charge-api` only |
| **accounting** | `:fineract-charge-api` only (`chargeId` + port) |
| **investor** | *(none)* — `LoanCharge.getChargeId()` |
| **working-capital-loan** | `:fineract-charge-api` only (`chargeId` + port) |
| loan / savings | `:fineract-charge-api` + `:fineract-charge-impl` *(Step 8 residual)* |
| provider / integration-tests | `:fineract-charge` façade |

### Residual (Step 8+)

Loan / savings still use the JPA `Charge` aggregate on account/product charges.
Façade deprecation and ArchUnit freeze shrink wait until those retargets land.

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).
