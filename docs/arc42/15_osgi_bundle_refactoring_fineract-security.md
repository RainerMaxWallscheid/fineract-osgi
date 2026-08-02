# fineract-security – OSGi api / impl / test refactoring plan

Wave‑4 module after cob
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; Spring Security residual) |
| **Module** | Access tokens, 2FA config ports, auth DTOs/exceptions |
| **No façade** | Compose with `:fineract-security-api` + `:fineract-security-impl` |

## Residual

- Servlet filters, OIDC converters, JWT token types on impl
- Provider composition root uses api+impl

## Commands

```bash
./gradlew :fineract-security-api:jar :fineract-security-impl:jar :fineract-security-test:test
./gradlew :fineract-provider:compileJava
```
