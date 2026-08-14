# fineract-cob

Close-of-business orchestration — Wave 4 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-cob-api` | `api/` | `org.apache.fineract.cob.api` | Pure ports, DTOs, exceptions |
| `fineract-cob-impl` | `impl/` | `org.apache.fineract.cob.impl` | Batch steps, loan lock residual, lock/business-step REST |
| `fineract-cob-test` | `test/` | `org.apache.fineract.cob.test` | Fragment-Host → impl |

No façade. Domain modules depend on **api + impl**.

```bash
./gradlew :fineract-cob-api:jar :fineract-cob-impl:jar :fineract-cob-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-cob.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-cob.md).
