# fineract-branch – OSGi api / impl / test refactoring plan

Wave‑2 module after [document](15_osgi_bundle_refactoring_fineract-document.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test + teller service ports; provider residual for service impls + cashier validator) |
| **Module** | Branch cash / teller (`m_tellers`, cashiers, cashier txns) |
| **No façade** | Compose with `:fineract-branch-api` + `:fineract-branch-impl` explicitly |

**Inter-bundle access:** OSGi **Service Registry** (`TellerManagementReadPlatformService`, `TellerWritePlatformService`).  
**Spring:** REST/handlers in **branch-impl**; service **JpaImpl** + `OrganisationTellerConfiguration` still in **provider**.

---

## 1. Why branch is next

| Criterion | Fit |
|-----------|-----|
| Size | ~50 main types — clear org aggregate |
| Hexagonal | Teller/cashier boundary vs loan cash settlement |
| Consumers | **provider** (service impls + loan cash validation); war |
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
| `:fineract-branch-impl` | `org.apache.fineract.branch.impl` | `domain` (+ model), `validation`, `serialization` (provider residual) |
| `:fineract-branch-test` | `org.apache.fineract.branch.test` | Fragment-Host |

---

## 3. Package placement

| Package | Slice |
|---------|--------|
| `…teller.moduleapi` | **api** — package docs; pure `TellerStatus`, `CashierTxnType` |
| `…teller.service` (interfaces) | **api** |
| `…teller.data` (pure DTOs) | **api** |
| `…teller.exception` | **api** |
| `…teller.domain` (JPA + repos) | **impl** |
| `…teller.validation` | **impl** — `CashierTransactionDataValidator` |
| REST / handlers / serialization / util | **impl** |
| `…teller.impl.osgi` | **impl** — `BranchOsgiServiceRegistrar` |
| provider `*PlatformServiceImpl` / `OrganisationTellerConfiguration` | **provider** |

---

## 4. Steps

### Step 0 — Baseline ✅
Inventory: provider teller service impls; loan uses `CashierTransactionDataValidator`; war packaging.

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
`BranchOsgiServiceRegistrar` → read + write teller services (beans from provider Spring).

### Step 7 — Mechanical consumer Gradle ✅
| Consumer | Edge |
|----------|------|
| provider / war / architecture | **api + impl** (composition root) |

### Step 8 — Semantic residual (open / accepted) ⚠️
- [ ] Provider still hosts `TellerWritePlatformServiceJpaImpl` / `TellerManagementReadPlatformServiceImpl` / starter config
- [ ] Loan write path depends on **impl** type `CashierTransactionDataValidator` (not a pure port yet)
- [ ] Optional follow-up: `CashierTxnValidationPort` on api; move service impls into branch-impl

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
| Move provider teller JpaImpl + starter into branch-impl | cleaner OSGi starter export |
| `CashierTxnValidationPort` for loan settle/cash-out | drop provider compile dep on validator |
| Port-only access for foreign BCs | no residual domain export |
