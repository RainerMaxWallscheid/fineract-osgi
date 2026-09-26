# fineract-savings

Savings / deposit products & accounts — Wave 3 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-savings-api` | `api/` | `org.apache.fineract.savings.api` | Pure ports, DTOs, exceptions, `SavingsTransactionEnumerations` (many enums/DTOs already in core) |
| `fineract-savings-impl` | `impl/` | `org.apache.fineract.savings.impl` | JPA domain, entity-typed services, COB; Equinox DS `OSGI-INF/savings.xml` |
| `fineract-savings-test` | `test/` | `org.apache.fineract.savings.test` | Fragment-Host → `savings.impl` |

No `:fineract-savings` façade.

Savings account entities store client id and group id (not leftover Client or Group).

Savings and deposit application group lookups use GroupActivePort (not leftover Group repository). Share account create uses ClientActivePort.persistableById (not leftover Client repository).

Savings and deposit field-officer assignment uses StaffPersistablePort (not leftover Staff repository). Savings transaction payment type ids use PaymentDetailPersistablePort (not leftover PaymentDetail).

### Consumers

| Module | Depend on |
|--------|-----------|
| provider / war / architecture / ITs | **api + impl** (entity residual) |

```bash
./gradlew :fineract-savings-api:jar :fineract-savings-impl:jar :fineract-savings-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-savings.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-savings.md).
