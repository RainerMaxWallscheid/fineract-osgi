# fineract-charge

Charge Catalog bounded context — OSGi modularization in progress ([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-charge-api` | `api/` | `org.apache.fineract.charge.api` | Contracts (Step 2+) |
| `fineract-charge-impl` | `impl/` | `org.apache.fineract.charge.impl` | Catalog domain, services, REST |
| `fineract-charge-test` | `test/` | `org.apache.fineract.charge.test` | Fragment-Host → charge.impl |
| `fineract-charge` | `.` | *(façade)* | Re-exports api + impl for existing consumers |

```bash
./gradlew :fineract-charge-api:jar :fineract-charge-impl:jar :fineract-charge-test:test :fineract-charge:jar
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).
