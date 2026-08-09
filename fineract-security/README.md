# fineract-security

Platform security (auth, 2FA, OIDC) — Wave 4 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-security-api` | `api/` | `org.apache.fineract.security.api` | Pure ports, DTOs, exceptions, constants |
| `fineract-security-impl` | `impl/` | `org.apache.fineract.security.impl` | Filters, OIDC residual, Spring Security, SQL validators |
| `fineract-security-test` | `test/` | `org.apache.fineract.security.test` | Fragment-Host → impl |

No façade. Provider / oauth2-tests / war use **api + impl**.

### Kernel residual in `fineract-core`

Types used across the shared kernel stay in core (same packages) to avoid core↔security-api cycles:

- `PlatformSecurityContext`, password encoder / encryptor ports
- `PlatformUser` domain + repository
- `SQLBuilder`, SQL injection exception helpers
- Platform security exceptions used by core mappers / validation

Moved into this module (residual peel): `PlatformUserDetailsService`, `SqlInjectionPreventerService`,
`ColumnValidator`, `DefaultSqlValidator`, `DefaultInputValidator`.


### Residual still on provider

- `AuthorizationServerConfig` / `OidcFederationSecurityConfig` (jobs COB filters → jobs-impl; jobs already depends on security-impl)
- `TwoFactorServiceImpl` (SMS send path → sms/campaigns; both depend on security-impl)

Closed into security-impl: 2FA config, OIDC user resolution, login lockout, temporary-password auth provider,
dynamic JWT issuer resolver, security filter-chain diagnostics. `RoleRepository` moved to core next to `Role`.

```bash
./gradlew :fineract-security-api:jar :fineract-security-impl:jar :fineract-security-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-security.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-security.md).
