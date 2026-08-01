# fineract-branch – OSGi api / impl / test refactoring plan

Wave‑2 module after [document](15_osgi_bundle_refactoring_fineract-document.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test + teller ports + residual closed) |
| **Module** | Branch cash / teller (`m_tellers`, cashiers, cashier txns) |
| **No façade** | Compose with `:fineract-branch-api` + `:fineract-branch-impl` explicitly |

**Inter-bundle access:** OSGi **Service Registry** (`TellerManagementReadPlatformService`, `TellerWritePlatformService`, `CashierTxnValidationPort`).  
**Spring:** service JpaImpl, REST, handlers, starter, OSGi registrar in **branch-impl**.

---

## 1. Why branch is next

| Criterion | Fit |
|-----------|-----|
| Size | ~50 main types — clear org aggregate |
| Hexagonal | Teller/cashier boundary vs loan cash settlement |
| Consumers | **provider** composition root; loan uses **`CashierTxnValidationPort`** only |
| Caveat | Less “optional extension” value than charge/document |

---

## 2. Layout (as-built)

```text
fineract-branch/
  README.md
  api/     → :fineract-branch-api
  impl/    → :fineract-branch-impl
  test/    → :fineract-branch-test  (Fragment-Host → branch.impl)
```

| Gradle | Bundle-SymbolicName | Export |
|--------|---------------------|--------|
| `:fineract-branch-api` | `org.apache.fineract.branch.api` | `moduleapi`, `service`, `data`, `exception` |
| `:fineract-branch-impl` | `org.apache.fineract.branch.impl` | `starter` only |
| `:fineract-branch-test` | `org.apache.fineract.branch.test` | Fragment-Host |

---

## 3. Package placement

| Package | Slice |
|---------|--------|
| `…teller.moduleapi` | **api** — `TellerStatus`, `CashierTxnType`, **`CashierTxnValidationPort`** |
| `…teller.service` (interfaces) | **api** |
| `…teller.data` (pure DTOs) | **api** |
| `…teller.exception` | **api** |
| `…teller.domain` (JPA + repos) | **impl** |
| `…teller.service.*Impl` | **impl** |
| `…teller.validation` | **impl** — `CashierTransactionDataValidator` implements port |
| REST / handlers / serialization / util | **impl** |
| `…teller.starter` | **impl** — `OrganisationTellerConfiguration` |
| `…teller.impl.osgi` | **impl** — `BranchOsgiServiceRegistrar` |

**Kernel support (residual enabler):** `StaffRepository` + `StaffReadService` interfaces live in **fineract-core** (impls remain in provider) so branch-impl compiles without depending on provider.

---

## 4. Steps

### Step 0 — Baseline ✅
Inventory: provider teller service impls; loan uses cashier validation; war packaging.

### Step 1 — Project shells ✅
`settings.gradle` → api / impl / test; no façade.

### Step 2 — Extract api ✅
Service interfaces, pure DTOs, exceptions, pure enums in `moduleapi`.

### Step 3 — Impl under branch-impl ✅
Domain, REST, handlers, validator, serialization, registrar.

### Step 4 — Bundle metadata ✅
Manifest Export/Import/Fragment-Host.

### Step 5 — Fragment-Host tests ✅
Deserializer test + `BranchOsgiServiceRegistrarTest`.

### Step 6 — OSGi registrar ✅
`BranchOsgiServiceRegistrar` → read + write teller services + `CashierTxnValidationPort`.

### Step 7 — Mechanical consumer Gradle ✅
| Consumer | Edge |
|----------|------|
| provider / war / architecture | **api + impl** (composition root; classpath Spring scan) |

### Step 8 — Semantic residual ✅
- [x] Move `Teller*ServiceImpl` + `OrganisationTellerConfiguration` into **branch-impl**
- [x] `CashierTxnValidationPort` on api; loan disbursal uses port + `staffId` (not validator / AppUser)
- [x] `CashierTransactionDataValidator` implements port; internal only
- [x] Impl **Export-Package** = `starter` only
- [x] Move `StaffRepository` / `StaffReadService` interfaces to **core** (provider keeps impls)

### Step 9 — Docs ✅
This plan + module README + osgi / parent 15 updates.

---

## 5. Commands

```bash
./gradlew :fineract-branch-api:jar :fineract-branch-impl:jar :fineract-branch-test:test
./gradlew :fineract-provider:compileJava
```

---

## 6. Optional follow-ups

| Item | Note |
|------|------|
| Staff staff module api/impl | further kernel slim — not required for branch residual |
| ArchUnit: forbid foreign BC import of `…teller.domain` / `…validation` | after freeze update |
