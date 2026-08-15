# fineract-loan – OSGi api / impl / test refactoring plan

Wave‑4 module after [savings](15_osgi_bundle_refactoring_fineract-savings.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; large entity residual for progressive/WC/provider) |
| **Module** | Loan products, accounts, schedule, delinquency, reschedule, guarantors, interest pause |
| **No façade** | Compose with `:fineract-loan-api` + `:fineract-loan-impl` |

**Inter-bundle access:** OSGi **Service Registry** for pure product/application ports.  
**Spring:** domain, handlers, REST, jobs in **loan-impl**.

---

## 1. Why loan is next

| Criterion | Fit |
|-----------|-----|
| Size | ~700 types — largest BC after provider |
| Dependents | progressive-loan, WC, cob, investor, provider, custom acme |
| Wave 3 complete | investor / accounting / savings done |

---

## 2. Layout (as-built)

```text
fineract-loan/
  README.md
  api/     → :fineract-loan-api
  impl/    → :fineract-loan-impl
  test/    → :fineract-loan-test
```

| Slice | Contents |
|-------|----------|
| **api** | Pure service ports, pure DTOs, exceptions (no Spring DAO), `moduleapi` |
| **impl** | `Loan` domain, entity-typed services, schedule generators, COB, handlers, impure DTOs |

---

## 3. Residual

- Progressive / WC / custom still bind to `Loan` entities and domain processors
- Many enums remain under `…domain` on impl (optional later: lift pure enums to api)
- Optional: pure account ports without entity signatures
- Leftover transfer-fee-charge job now lives in loan-impl via thin leftover `AccountTransferFundsData` + leftover `AccountTransferFundsWritePort` (provider adapter builds leftover `AccountTransferDTO`)

---

- Leftover loan interest-pause and reschedule batch `CommandStrategy` classes now live in loan-impl next to leftover `LoanInterestPauseApiResource` / `RescheduleLoansApiResource`. Re-age preview strategies stay (leftover `LoanTransactionsApiResource` on provider).

## 4. Commands

```bash
./gradlew :fineract-loan-api:jar :fineract-loan-impl:jar :fineract-loan-test:test
./gradlew :fineract-progressive-loan:compileJava :fineract-working-capital-loan:compileJava :fineract-provider:compileJava
```
