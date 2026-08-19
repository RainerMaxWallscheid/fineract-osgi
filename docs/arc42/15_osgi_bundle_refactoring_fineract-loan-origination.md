# fineract-loan-origination – OSGi api / impl / test refactoring plan

Wave‑2 module after [branch](15_osgi_bundle_refactoring_fineract-branch.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; `LoanOriginatorData` off core; loan/WC on api only) |
| **Module** | Loan originator catalog + loan / WC mappings |
| **No façade** | Compose with `:fineract-loan-origination-api` + `:fineract-loan-origination-impl` |

**Inter-bundle access:** OSGi **Service Registry** (read/write originator ports).  
**Spring:** REST, handlers, enrichers, JPA in **loan-origination-impl**.

---

## 1. Why loan-origination is next

| Criterion | Fit |
|-----------|-----|
| Size | ~60 main types |
| Bounded slice | Originator catalog vs full loan BC |
| Consumers | **loan** / **WC** need pure DTO; provider composition root |
| Caveat | Impl couples to loan + WC entities for attach/detach |

---

## 2. Layout (as-built)

```text
fineract-loan-origination/
  README.md
  api/     → :fineract-loan-origination-api
  impl/    → :fineract-loan-origination-impl
  test/    → :fineract-loan-origination-test  (Fragment-Host → loanorigination.impl)
```

| Gradle | Bundle-SymbolicName | Export |
|--------|---------------------|--------|
| `:fineract-loan-origination-api` | `org.apache.fineract.loanorigination.api` | `moduleapi`, `service`, `data`, `exception`, `api` (constants) |
| `:fineract-loan-origination-impl` | `org.apache.fineract.loanorigination.impl` | `config` only |
| `:fineract-loan-origination-test` | `org.apache.fineract.loanorigination.test` | Fragment-Host |

---

## 3. Package placement

| Package | Slice |
|---------|--------|
| `…loanorigination.moduleapi` | **api** — `LoanOriginatorStatus`, package docs |
| `…loanorigination.service` (interfaces) | **api** |
| `…loanorigination.data` | **api** — pure DTOs (**incl. `LoanOriginatorData` moved from core**) |
| `…loanorigination.exception` | **api** |
| `…loanorigination.api` (constants) | **api** |
| domain / service impls / handlers / REST / enrichers | **impl** |
| `…loanorigination.impl.osgi` | **impl** — `LoanOriginationOsgiServiceRegistrar` (Spring) + DS `OSGI-INF/loan-origination.xml` (Equinox start) |

---

## 4. Steps

### Step 0 — Baseline ✅
Inventory: provider/war/architecture on monomodule; loan + WC compile against core DTO.

### Step 1 — Project shells ✅
`settings.gradle` → api / impl / test; no façade.

### Step 2 — Extract api ✅
Interfaces, DTOs, exceptions, status enum, constants.

### Step 3 — Impl under loan-origination-impl ✅
Domain, handlers, REST, enrichers, liquibase, registrar.

### Step 4 — Bundle metadata ✅
Manifest Export/Import/Fragment-Host.

### Step 5 — Fragment-Host tests ✅
Enricher / helper tests + registrar smoke test.

### Step 6 — OSGi registrar ✅
`LoanOriginationOsgiServiceRegistrar` (Spring path) → read + write + WC write.  
DS `OSGI-INF/loan-origination.xml` (Equinox start; empty originator catalog, lowest ranking) → `LoanOriginatorReadPlatformService`. Composition-root hosted port: `osgi/CompositionRootOsgiBridge`.

### Step 7 — Mechanical consumer Gradle ✅
| Consumer | Edge |
|----------|------|
| loan / working-capital-loan | **api only** |
| provider / war / architecture | api + **impl** |

### Step 8 — Semantic residual ✅
- [x] Move `LoanOriginatorData` from **fineract-core** → loan-origination-api
- [x] loan + WC depend on **loan-origination-api only** (no impl)
- [x] Impl exports `config` only (no domain leak)

### Step 9 — Docs ✅
This plan + module README + osgi / parent 15 updates.

---

## 5. Commands

```bash
./gradlew :fineract-loan-origination-api:jar :fineract-loan-origination-impl:jar :fineract-loan-origination-test:test
./gradlew :fineract-loan:compileJava :fineract-working-capital-loan:compileJava :fineract-provider:compileJava
```

---

## 6. Optional follow-ups

| Item | Note |
|------|------|
| Extract attach/detach ports used only from REST | already service interfaces on api |
| WC read interface lives in WC module | historical; could move later |
| ArchUnit: forbid loan → loanorigination.domain | freeze when ready |
