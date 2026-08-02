# fineract-security

Platform security (auth, 2FA, OIDC) — Wave 4 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-security-api` | `api/` | `org.apache.fineract.security.api` | Pure ports, DTOs, exceptions, constants |
| `fineract-security-impl` | `impl/` | `org.apache.fineract.security.impl` | Filters, OIDC residual, Spring Security |
| `fineract-security-test` | `test/` | `org.apache.fineract.security.test` | Fragment-Host → impl |

No façade. Provider / oauth2-tests use **api + impl**.

```bash
./gradlew :fineract-security-api:jar :fineract-security-impl:jar :fineract-security-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-security.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-security.md).
