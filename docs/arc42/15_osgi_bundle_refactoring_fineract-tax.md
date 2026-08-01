# fineract-tax – OSGi api / impl / test refactoring plan (stub)

Wave‑1 module after [rates](15_osgi_bundle_refactoring_fineract-rates.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Field | Value |
|-------|--------|
| **Status** | **planned** — not started (await rates mechanical split green) |
| **Module** | Tax component / tax group catalog |
| **Already present** | empty `…tax.moduleapi` package-info |

---

## 1. Why tax after rates

| Criterion | Note |
|-----------|------|
| Size | ~30 main types |
| Consumers | charge-impl, loan, savings, provider, core DTOs |
| Entities | `TaxComponent`, `TaxGroup`, mappings, history |
| Coupling | Charge JPA `TaxGroup`; loan charge tax details; savings product tax |

Higher rewiring cost than rates; start after rates api/impl/test recipe is proven.

---

## 2. Target layout (mirror rates — no façade)

```text
fineract-tax/
  api/   → :fineract-tax-api      BSN org.apache.fineract.tax.api
  impl/  → :fineract-tax-impl     BSN org.apache.fineract.tax.impl
  test/  → :fineract-tax-test     Fragment-Host → tax.impl
```

---

## 3. Suggested `-api` surface

| Type | Purpose |
|------|---------|
| `TaxComponentPort` / `TaxGroupPort` (or unified `TaxCatalogPort`) | Lookup by id; active groups |
| `TaxComponentDefinitionData` / `TaxGroupDefinitionData` | Pure DTOs |
| Existing pure data in **core** (`TaxGroupData`, …) | Decide: keep kernel vs move to tax-api |
| Catalog exceptions | `TaxComponentNotFoundException`, … |
| `TaxReadPlatformService` interface | Optional on api |
| `ChargeTaxApplicationService` | Likely stays impl or becomes port — decide during Step 0 |

---

## 4. Step checklist (same as charge/rates)

0. Baseline / consumer inventory  
1. Project shells (no façade)  
2. Extract api  
3. Move impl  
4. OSGi manifests  
5. Fragment-Host tests  
6. `TaxOsgiServiceRegistrar`  
7. Mechanical Gradle retarget  
8. Semantic: replace `@ManyToOne TaxGroup` with `taxGroupId` + ports (charge, loan, savings)  
9. Docs / acceptance  

---

## 5. Risks

| Risk | Mitigation |
|------|------------|
| Tax DTOs live in **core** | Prefer slim moduleapi DTOs; leave fat core DTOs transitional |
| Charge entity still holds `TaxGroup` | Coordinate with charge-impl; port + id snapshots |
| Loan `LoanChargeTaxDetails` | chargeId-style tax component id residual |

---

## 6. When to start

- Rates compile green on api/impl/test  
- Provider/loan use rates-api+impl  
- Then open tax Step 1 PR series
