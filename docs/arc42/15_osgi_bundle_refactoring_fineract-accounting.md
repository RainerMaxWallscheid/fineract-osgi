# fineract-accounting – OSGi api / impl / test refactoring plan

Wave‑3 module after [investor](15_osgi_bundle_refactoring_fineract-investor.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; entity residual for product/loan/journal consumers) |
| **Module** | GL accounts, journal entries, product mapping, rules, provisioning, closures |
| **No façade** | Compose with `:fineract-accounting-api` + `:fineract-accounting-impl` |

**Inter-bundle access:** OSGi **Service Registry** (GL/JE/product-mapping read ports + dropdowns).  
**Spring:** REST, domain, helpers, jobs in **accounting-impl**.

---

## 1. Why accounting is next

| Criterion | Fit |
|-----------|-----|
| Size | ~150 types |
| Central BC | Many dependents (loan, savings, investor, branch, provider) |
| Kernel overlap | Pure enums/DTOs already partly in **fineract-core** |

---

## 2. Layout (as-built)

```text
fineract-accounting/
  README.md
  api/     → :fineract-accounting-api
  impl/    → :fineract-accounting-impl
  test/    → :fineract-accounting-test
```

| Gradle | Export |
|--------|--------|
| api | ports, DTOs, exceptions, pure constants |
| impl | domain residual + product-mapping helpers + rule starter |

---

## 3. Steps

### Step 0–7, 9 ✅
Mechanical split + registrar + Equinox `AccountingOsgiBundleActivator` (`GLClosureReadPlatformService`) + consumer Gradle.

### Step 8 residual ⚠️
- [x] Pure ports / DTOs on api
- [x] investor-api → **accounting-api only**
- [x] loan/savings/branch/investor-impl/provider → **api + impl** (entity residual)
- [ ] Optional: product mapping via ports only (drop entity deps from loan/WC)
- [ ] Optional: move provider-hosted `JournalEntryWritePlatformService` into accounting-impl

---

## 4. Commands

```bash
./gradlew :fineract-accounting-api:jar :fineract-accounting-impl:jar :fineract-accounting-test:test
./gradlew :fineract-loan:compileJava :fineract-provider:compileJava
```
- Leftover generate-loan-loss-provisioning job closed into accounting-impl.
- Leftover generate-loan-loss-provisioning tasklet test closed into accounting-test.
