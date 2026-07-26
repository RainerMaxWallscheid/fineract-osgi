# fineract-charge

Charge Catalog bounded context — OSGi modularization in progress ([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-charge-api` | `api/` | `org.apache.fineract.charge.api` | Contracts: **Export-Package** `moduleapi`, pure enums `domain`, catalog `exception` |
| `fineract-charge-impl` | `impl/` | `org.apache.fineract.charge.impl` | JPA catalog, services, REST, Spring; **Export-Package** `starter` only |
| `fineract-charge-test` | `test/` | `org.apache.fineract.charge.test` | White-box tests; **Fragment-Host** → `org.apache.fineract.charge.impl` |
| `fineract-charge` | `.` | *(façade)* | Re-exports api + impl for existing Boot consumers (not a long-term OSGi feature) |

Inter-bundle access: **OSGi Service Registry** (Step 6 registrar). Not Karaf Features. Spring stays inside **impl**.

```bash
./gradlew :fineract-charge-api:jar :fineract-charge-impl:jar :fineract-charge-test:jar
./gradlew :fineract-charge-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).
