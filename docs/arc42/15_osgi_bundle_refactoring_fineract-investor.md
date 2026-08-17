# fineract-investor – OSGi api / impl / test refactoring plan

Wave‑3 module after Wave 2 ([mix](15_osgi_bundle_refactoring_fineract-mix.md))
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; pure ports on api; entity residual for provider journal) |
| **Module** | External asset owner / investor transfers |
| **No façade** | Compose with `:fineract-investor-api` + `:fineract-investor-impl` |

**Inter-bundle access:** OSGi **Service Registry** (read/write owners, attributes, delayed settlement).  
**Spring:** REST, domain, COB step, enrichers in **investor-impl**.

---

## 1. Why investor is next

| Criterion | Fit |
|-----------|-----|
| Size | ~100 main types |
| Clear BC | Investor / external asset owner |
| Dependents | provider journal integration; integration tests |
| Caveat | `AccountingService` still entity-typed (loan + transfer entities) |

---

## 2. Layout (as-built)

```text
fineract-investor/
  README.md
  api/     → :fineract-investor-api
  impl/    → :fineract-investor-impl
  test/    → :fineract-investor-test  (Fragment-Host → investor.impl)
```

| Gradle | Bundle-SymbolicName | Export |
|--------|---------------------|--------|
| `:fineract-investor-api` | `org.apache.fineract.investor.api` | `moduleapi`, pure `service` ports, `data*`, `exception` |
| `:fineract-investor-impl` | `org.apache.fineract.investor.impl` | `domain`, residual `service` (entity ports), `config`, `enricher` |
| `:fineract-investor-test` | `org.apache.fineract.investor.test` | Fragment-Host |

---

## 3. Package placement

| Package | Slice |
|---------|--------|
| `…investor.moduleapi` | **api** — package docs |
| pure `…investor.service` interfaces | **api** |
| `…investor.data*` | **api** |
| `…investor.exception` (not mappers) | **api** |
| entity-typed ports (`AccountingService`, loan transfer services), *Impl, handlers | **impl** |
| domain / REST / enrichers / cob / config | **impl** |
| `…investor.impl.osgi` | **impl** — `InvestorOsgiServiceRegistrar` (Spring) + `InvestorOsgiBundleActivator` (Equinox start) |

---

## 4. Steps

### Step 0–7, 9 ✅
Mechanical split + registrar + Equinox `InvestorOsgiBundleActivator` (`DelayedSettlementAttributeService`) + consumer Gradle.

### Step 8 — Residual ✅ / open follow-ups
- [x] Pure ports + DTOs on api
- [x] provider / war / ITs = api + **impl**
- [ ] Optional: redesign `AccountingService` without `Loan` / entity params so journal can use ports only
- [x] Impl Export-Package is registrar-only (`…investor.impl.osgi`)

### Notes
- EclipseLink static weave: `:fineract-investor-impl:compileJava` depends on `:fineract-investor-api:jar` so `@Enumerated` enums resolve across jars.

---

## 5. Commands

```bash
./gradlew :fineract-investor-api:jar :fineract-investor-impl:jar :fineract-investor-test:test
./gradlew :fineract-provider:compileJava
```
