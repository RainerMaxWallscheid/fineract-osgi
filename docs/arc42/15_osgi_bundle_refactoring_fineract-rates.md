# fineract-rates – OSGi api / impl / test refactoring plan

Wave‑1 module after [charge](15_osgi_bundle_refactoring_fineract-charge.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** + Rate catalog close-in (`RateData` / `RateReadService` / `RateWriteService` on rates-api) |
| **Module** | Floating Rates catalog (`m_floating_rates`) |
| **No façade** | Compose with `:fineract-rates-api` + `:fineract-rates-impl` explicitly |

**Inter-bundle access:** OSGi **Service Registry** only (`FloatingRatePort`).  
**Spring:** stays in **rates-impl**.

---

## 1. Why rates is next

| Criterion | Fit |
|-----------|-----|
| Size | ~20 main types — smallest real domain slice |
| Entities | `FloatingRate`, `FloatingRatePeriod` |
| Consumers | loan (product floating rates), provider; savings only needed contracts |
| Port story | `FloatingRatePort` + existing read/write service interfaces |

Prefer **rates before tax** for lowest mechanical risk; tax has more charge/loan/savings entity coupling.

---

## 2. Layout (as-built)

```text
fineract-rates/
  README.md
  api/     → :fineract-rates-api
  impl/    → :fineract-rates-impl
  test/    → :fineract-rates-test  (Fragment-Host → rates.impl)
```

| Gradle | Bundle-SymbolicName | Export |
|--------|---------------------|--------|
| `:fineract-rates-api` | `org.apache.fineract.rates.api` | floating `moduleapi`/`data`/`service`/`exception` + Rate `data`/`service` |
| `:fineract-rates-impl` | `org.apache.fineract.rates.impl` | `starter` only |
| `:fineract-rates-test` | `org.apache.fineract.rates.test` | Fragment-Host |

---

## 3. Package placement

| Package | Slice |
|---------|--------|
| `…floatingrates.moduleapi` | **api** — `FloatingRatePort`, `FloatingRateDefinitionData` |
| `…floatingrates.data` | **api** — pure DTOs |
| `…floatingrates.service` (interfaces) | **api** |
| `…floatingrates.exception` | **api** |
| `…rate.data` (`RateData`) | **api** |
| `…rate.service` (`RateReadService`, `RateWriteService`) | **api** |
| `…floatingrates.domain` | **impl** — JPA + repositories |
| `…floatingrates.service.*Impl` | **impl** |
| `…floatingrates.handler` / `api` / `serialization` | **impl** |
| `…floatingrates.starter` | **impl** |
| `…floatingrates.impl.osgi` | **impl** — `RatesOsgiServiceRegistrar` |

---

## 4. Steps

### Step 0 — Baseline ✅
Inventory + consumer map (loan product floating rates; provider assembly).

### Step 1 — Project shells ✅
`settings.gradle` → api / impl / test; no façade.

### Step 2 — Extract api ✅
DTOs, exceptions, service interfaces, `FloatingRatePort`.

### Step 3 — Impl under rates-impl ✅
Domain, handlers, REST, Spring config, port adapter.

### Step 4 — Bundle metadata ✅
Manifest Export/Import/Fragment-Host on jars.

### Step 5 — Fragment-Host tests ✅
`FloatingRatePortJpaAdapterTest` under rates-test.

### Step 6 — OSGi registrar ✅
`RatesOsgiServiceRegistrar` (Spring path) → `FloatingRatePort` + `RateReadService` + `RateWriteService`.  
DS `OSGI-INF/rates.xml` (Equinox start; empty catalog, lowest ranking) → `FloatingRatePort`. Composition-root hosted port: `osgi/CompositionRootOsgiBridge`.

### Step 7 — Mechanical consumer Gradle ✅
| Consumer | Edge |
|----------|------|
| savings | **api only** |
| loan | **api only** (`floatingRateId` + `FloatingRatePort`; `RateData` / `RateReadService`) |
| provider / war / ITs | api + impl (composition root) |
| architecture | api + impl (classpath) |

### Step 8 — Semantic retarget ✅
- [x] `LoanProductFloatingRates`: store `floatingRateId` (`@Column floating_rates_id`) instead of `@ManyToOne FloatingRate`
- [x] Loan schedule / product write / term-variation paths use `FloatingRatePort` + period DTOs
- [x] Loan Gradle → **rates-api only**

### Step 9 — Docs ✅
This plan + module README + osgi table update.

### Rate catalog close-in ✅
`RateData` + `RateReadService` / `RateWriteService` moved to rates-api (loan already **rates-api only**).
Residual in core: `Rate` entity, `RateAppliesTo`, repo/wrapper, `RateNotFoundException` (loan `@ManyToOne`).

---

## 5. Commands

```bash
./gradlew :fineract-rates-api:jar :fineract-rates-impl:jar :fineract-rates-test:test
./gradlew :fineract-loan:compileJava :fineract-provider:compileJava
```

---

## 6. Relation to tax

Rates is complete; run the same recipe on **`fineract-tax`**
([tax plan stub](15_osgi_bundle_refactoring_fineract-tax.md)).
