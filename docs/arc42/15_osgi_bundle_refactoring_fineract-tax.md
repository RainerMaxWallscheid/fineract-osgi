# fineract-tax – OSGi api / impl / test refactoring plan

Wave‑1 module after [rates](15_osgi_bundle_refactoring_fineract-rates.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test + `TaxCatalogPort` / `ChargeTaxApplicationService`; charge/loan/savings **tax-api only** via catalog ids) |
| **Module** | Tax component / tax group catalog (`m_tax_component`, `m_tax_group`) |
| **No façade** | Compose with `:fineract-tax-api` + `:fineract-tax-impl` explicitly |

**Inter-bundle access:** OSGi **Service Registry** (`TaxCatalogPort`).  
**Spring:** port adapter + registrar in **tax-impl**; composition-root write/read wiring still in **provider**.

---

## 1. Layout (as-built)

```text
fineract-tax/
  README.md
  api/     → :fineract-tax-api
  impl/    → :fineract-tax-impl
  test/    → :fineract-tax-test  (Fragment-Host → tax.impl)
```

| Gradle | Bundle-SymbolicName | Export |
|--------|---------------------|--------|
| `:fineract-tax-api` | `org.apache.fineract.tax.api` | `moduleapi`, `service` (interfaces + DTO TaxUtils), `exception`, `api` (constants) |
| `:fineract-tax-impl` | `org.apache.fineract.tax.impl` | `domain` (provider residual), `starter` |
| `:fineract-tax-test` | `org.apache.fineract.tax.test` | Fragment-Host |

---

## 2. Package placement

| Package | Slice |
|---------|--------|
| `…tax.moduleapi` | **api** — `TaxCatalogPort`, definition + share data |
| `…tax.service` (`TaxRead`/`TaxWrite`/`ChargeTaxApplicationService`/`TaxUtils` DTO) | **api** |
| `…tax.exception` | **api** |
| core `…tax.data` / `…tax.request` | **fineract-core** (transitional) |
| `…tax.domain` | **impl** |
| `…tax.service` (impls, `TaxEntityUtils`, port adapter) | **impl** |
| REST / handlers / mappers / serialization | **impl** |
| `…tax.impl.osgi` | **impl** — `TaxOsgiServiceRegistrar` |
| provider `TaxAssembler` / `*PlatformServiceImpl` / `TaxConfiguration` | **provider** |

---

## 3. Steps

### Step 0–7, 9 ✅
Mechanical api/impl/test + `TaxCatalogPort` + OSGi registrar + consumer Gradle.

### Step 8 — Semantic retarget ✅
- [x] Charge: `taxGroupId` column (no `@ManyToOne TaxGroup`); write validates via `TaxCatalogPort`
- [x] Loan: `LoanCharge.taxGroupId` already; `LoanChargeTaxDetails.taxComponentId`; tax via `ChargeTaxApplicationService.computeTax(Long, …)`
- [x] Savings product/account: `taxGroupId`; transaction tax details: `taxComponentId`; withhold via `ChargeTaxApplicationService` on account helpers
- [x] Accounting journal entries resolve credit GL via `TaxCatalogPort`
- [x] charge-impl / loan / savings → **tax-api only**
- [x] provider / war / ITs still **api + impl** (tax catalog admin + entity assembly)

---

## 4. Commands

```bash
./gradlew :fineract-tax-api:jar :fineract-tax-impl:jar :fineract-tax-test:test
./gradlew :fineract-charge-impl:compileJava :fineract-loan:compileJava :fineract-savings:compileJava :fineract-provider:compileJava
```

---

## 5. Optional follow-ups

| Item | Note |
|------|------|
| Move `TaxAssembler` / platform service impls into tax-impl | cleaner OSGi starter export |
| Move fat core tax DTOs into tax-api | further kernel slimming |
| Snapshot `creditAccountId` on tax detail rows | avoid catalog lookup at journal time |
