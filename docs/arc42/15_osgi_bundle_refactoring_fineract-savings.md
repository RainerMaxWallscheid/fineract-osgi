# fineract-savings – OSGi api / impl / test refactoring plan

Wave‑3 module after [accounting](15_osgi_bundle_refactoring_fineract-accounting.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; entity residual for provider) |
| **Module** | Savings & deposit products/accounts, interest charts, interop |
| **No façade** | Compose with `:fineract-savings-api` + `:fineract-savings-impl` |

---

## 1. Layout

```text
fineract-savings/
  api/   → :fineract-savings-api
  impl/  → :fineract-savings-impl
  test/  → :fineract-savings-test
```

## 2. Placement

| Slice | Contents |
|-------|----------|
| **api** | Pure product/application ports, module DTOs/exceptions, `moduleapi` |
| **impl** | `SavingsAccount*` domain, entity-typed account services, COB, interest-chart domain, interop |

**Kernel note:** Many savings enums/DTOs already live in **fineract-core**.

## 3. Consumers

| Module | Edge |
|--------|------|
| provider / war / architecture / ITs | **api + impl** |

## 4. Residual

- Provider still binds heavily to `SavingsAccount` / entity-typed write services
- Optional: pure account ports without entity signatures
- Interest-rate chart REST, command handlers, read/write services, and validators now live in savings-impl (domain/assemblers were already there)

## 5. Commands

```bash
./gradlew :fineract-savings-api:jar :fineract-savings-impl:jar :fineract-savings-test:test
./gradlew :fineract-provider:compileJava
```
