# fineract-progressive-loan

Progressive loan schedule / EMI model — Wave 4 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-progressive-loan-api` | `api/` | `org.apache.fineract.progressiveloan.api` | Pure ports & calc DTOs |
| `fineract-progressive-loan-impl` | `impl/` | `org.apache.fineract.progressiveloan.impl` | Schedule engine, residual domain; Equinox DS `OSGI-INF/progressive-loan.xml` |
| `fineract-progressive-loan-test` | `test/` | `org.apache.fineract.progressiveloan.test` | Fragment-Host → impl |

No façade. Consumers: **api + impl**.

```bash
./gradlew :fineract-progressive-loan-api:jar :fineract-progressive-loan-impl:jar :fineract-progressive-loan-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-progressive-loan.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-progressive-loan.md).
