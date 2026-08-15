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
- Fixed/recurring deposit product write/read/handlers now live in savings-impl. Savings-product write stays on provider to avoid a savings-impl ↔ entityaccess-impl cycle.
- Fixed/recurring deposit account entities (and RD schedule/recurring detail) now live in savings-impl next to `SavingsAccount`. Assemblers stay on provider.
- Leftover savings command handlers now live in savings-impl (thin wrappers over write ports already on api/impl).
- Deposit-account interest-chart read, FD interest-calculation, and `DepositAccountDataValidator` now live in savings-impl.
- Savings/FD/RD product REST now live in savings-impl. Generic `DropdownReadPlatformService` moved to fineract-core next to `CommonEnumerations`.
- Savings account transaction/charge/on-hold/internal REST now live in savings-impl. Account-collection REST stays on provider (bulkimport + leftover account associations).
- Savings and recurring-deposit account-collection REST now live in savings-impl (bulkimport ports are in core). FD account REST stays (leftover `AccountAssociationsReadPlatformService`).
- Peelable leftover savings jobs (annual fee, RD schedule, due charges, maturity, dormant) now live in savings-impl. Accrual/post-interest/transfer/adhoc jobs stay on provider.

## 5. Commands

```bash
./gradlew :fineract-savings-api:jar :fineract-savings-impl:jar :fineract-savings-test:test
./gradlew :fineract-provider:compileJava
```
