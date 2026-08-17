# fineract-mix – OSGi api / impl / test refactoring plan

Wave‑2 module after [loan-origination](15_osgi_bundle_refactoring_fineract-loan-origination.md)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test; provider composition root) |
| **Module** | MIX taxonomy mapping + XBRL report generation |
| **No façade** | Compose with `:fineract-mix-api` + `:fineract-mix-impl` |

**Inter-bundle access:** OSGi **Service Registry** (taxonomy / mapping / XBRL ports).  
**Spring:** REST, domain, MapStruct, XBRL builder in **mix-impl**.

---

## 1. Why mix is next

| Criterion | Fit |
|-----------|-----|
| Size | ~35 main types — smallest remaining Wave 2 module |
| Consumers | **provider** / war only (no foreign domain BCs) |
| Niche | XBRL reporting support; lower strategic value but clean split |

---

## 2. Layout (as-built)

```text
fineract-mix/
  README.md
  api/     → :fineract-mix-api
  impl/    → :fineract-mix-impl
  test/    → :fineract-mix-test  (Fragment-Host → mix.impl)
```

| Gradle | Bundle-SymbolicName | Export |
|--------|---------------------|--------|
| `:fineract-mix-api` | `org.apache.fineract.mix.api` | `moduleapi`, `service`, `data`, `exception`, `command` |
| `:fineract-mix-impl` | `org.apache.fineract.mix.impl` | `domain`, `service` (impl residual for provider JDBC + tests) |
| `:fineract-mix-test` | `org.apache.fineract.mix.test` | Fragment-Host |

---

## 3. Package placement

| Package | Slice |
|---------|--------|
| `…mix.moduleapi` | **api** — package docs |
| `…mix.service` (interfaces) | **api** |
| `…mix.data` / `exception` / `command` | **api** |
| `…mix.service.*Impl` / `MixReportXBRLBuilder` | **impl** |
| domain / mapping / handler / REST | **impl** |
| `…mix.impl.osgi` | **impl** — `MixOsgiServiceRegistrar` (Spring) + `MixOsgiBundleActivator` (Equinox start) |

---

## 4. Steps

### Step 0–7, 9 ✅
Mechanical api/impl/test + registrar + Equinox `MixOsgiBundleActivator` + consumer Gradle (provider / war).

### Step 8 — Semantic residual ✅
- [x] No foreign domain modules depend on mix
- [x] Provider still needs **impl** (JdbcConfig package scan + cucumber steps use Builder/impl classes)
- [x] Residual exports: `domain` + `service` for composition-root / white-box classpath

### Step 9 — Docs ✅
This plan + module README + osgi / parent 15 updates.

---

## 5. Commands

```bash
./gradlew :fineract-mix-api:jar :fineract-mix-impl:jar :fineract-mix-test:test
./gradlew :fineract-provider:compileJava
```

---

## 6. Optional follow-ups

| Item | Note |
|------|------|
| Move MIX cucumber steps onto ports only | drop provider test compile dep on Builder/impl |
| Shrink Export-Package to empty / starter | after JDBC entity scan lives with impl-only Spring config |
