# fineract-loan

Loan products & accounts — Wave 4 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-loan-api` | `api/` | `org.apache.fineract.loan.api` | Pure ports, DTOs, exceptions |
| `fineract-loan-impl` | `impl/` | `org.apache.fineract.loan.impl` | JPA domain, entity-typed services, schedule, delinquency, COB |
| `fineract-loan-test` | `test/` | `org.apache.fineract.loan.test` | Fragment-Host → `loan.impl` |

No `:fineract-loan` façade.

### Consumers

| Module | Depend on |
|--------|-----------|
| provider / war / progressive / WC / investor / architecture / ITs / custom | **api + impl** (entity residual) |

```bash
./gradlew :fineract-loan-api:jar :fineract-loan-impl:jar :fineract-loan-test:test
./gradlew :fineract-progressive-loan:compileJava :fineract-provider:compileJava
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-loan.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-loan.md).
