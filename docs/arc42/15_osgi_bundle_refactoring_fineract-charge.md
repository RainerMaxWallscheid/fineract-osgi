# fineract-charge – OSGi api / impl / test refactoring plan

Step-by-step plan to split **Charge Catalog** (fee *definitions*) into OSGi **api / impl / test** bundles, following the completed command pilot and the general playbook.

| | |
|--|--|
| **Status** | draft — **Step 0 in progress / largely complete** |
| **Decisions** | [ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md), [ADR-021](decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md), [ADR-017](decisions/ADR-017-hexagonale-architektur.md) |
| **Playbook** | [15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md) §15.6 Wave 1, §15.7 |
| **Reference pilot** | [15_osgi_bundle_refactoring_fineract-command.md](15_osgi_bundle_refactoring_fineract-command.md) (as-built) |
| **Context map** | Charge Catalog BC — [10 Domain Context Map](10_domain_context_map.md) |

**Inter-bundle access:** OSGi **Service Registry** only (api ports).  
**Not used:** Apache Karaf Features as a module contract.  
**Spring:** remains **inside** `charge-impl`; not removed before OSGi.  
**Module name:** capability border is **`fineract-charge`** (Gradle `:fineract-charge-api` / `-impl` / `-test`).

### Implementation status

| Step | Status | Notes |
|------|--------|-------|
| 0 Baseline & inventory | **done** (2026-07-26) | Baseline green; inventory §2; Module API expanded + JPA adapter + unit tests |
| 1 Project shells | **done** (2026-07-26) | `fineract-charge/{api,impl,test}` + façade; production sources on impl |
| 2 Extract api | **done** (2026-07-26) | moduleapi + pure enums + catalog exceptions on charge-api; no Spring/JPA/REST |
| 3 Move impl from provider | **pending** | Read/write service impls still in `fineract-provider` |
| 4 Bundle manifests | **partial** | BSN/Export on shells; refine after provider move |
| 5 Fragment-Host test | **partial** | Tests already on charge-test; green |
| 6 Spring↔OSGi bridge | **pending** | Register ports when `BundleContext` present |
| 7 Consumer retarget (Gradle) | **pending** | Domain modules → compile on charge-api |
| 8 Consumer retarget (semantic) | **pending** | loan/savings/… off `Charge` entity |
| 9 Docs / acceptance | **pending** | READMEs, osgi table, ArchUnit freeze shrink |

**Not in this plan:** migrating *loan/savings account charges* (those are product BCs); full Equinox as primary process; removing Spring from charge.

---

## 1. Why charge is the next Wave‑1 module

| Signal | Charge today |
|--------|----------------|
| Bounded context | **Charge Catalog** — fee definitions, not account-level charges |
| Size | ~40 main Java types in `fineract-charge` (command-sized) |
| Existing Module API | `org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort` (+ package-info ADR-021) |
| Reverse deps | loan, savings, accounting, investor, progressive/working-capital, provider, integration-tests |
| Hexagonal value | Catalog is a classic **published language** port; replaceable catalog impl is meaningful |
| Pilot pattern | Same recipe as command: api / impl / test fragment, façade for Boot |

Command proved the *mechanics*. Charge proves the pattern on a **real product BC** with many dependents and JPA.

---

## 2. Current structure (baseline inventory)

### 2.1 Gradle & layout (after Step 1)

```text
fineract-charge/
  README.md
  build.gradle                      # :fineract-charge  façade → api + impl
  dependencies.gradle
  api/                              # :fineract-charge-api  (empty contracts shell until Step 2)
  impl/                             # :fineract-charge-impl — all production sources today
    src/main/java/.../portfolio/charge/
      moduleapi/                    # still on impl until Step 2
      domain/ service/ handler/ api/ exception/ …
  test/                             # :fineract-charge-test  Fragment-Host → charge.impl
    src/test/java/.../ChargeDefinitionPortJpaAdapterTest
```

**Important split-brain (must be addressed in Steps 0–4):**

| Concern | Where it lives today |
|---------|----------------------|
| `ChargeWritePlatformService` / `ChargeReadPlatformService` **interfaces** | `fineract-charge` |
| **Implementations** (`*JpaRepositoryImpl`, `ChargeReadPlatformServiceImpl`) | **`fineract-provider`** |
| `ChargeData` DTO | **`fineract-core`** (`portfolio.charge.data`) |
| `ChargeTimeType` (+ some converters/exceptions) | **`fineract-core`** *and* overlapping types under charge |
| `Charge` JPA entity, most enums, repositories | `fineract-charge` |
| REST resource | `fineract-charge` |

This plan treats **consolidation of ownership** as part of the split, not a side quest.

### 2.2 Foreign usage (compile surface) — inventory 2026-07-26

Import counts of `org.apache.fineract.portfolio.charge.*` from **outside** `fineract-charge` (production + tests, approximate):

| Type / package | ~import sites | Risk for api split |
|----------------|---------------|--------------------|
| `charge.data.ChargeData` | ~50 | Lives in **core** — temporary shared kernel; later charge-api |
| `charge.domain.Charge` | ~46 | **Must not** stay as cross-module entity; replace with `ChargeDefinitionPort` / DTOs |
| `ChargeTimeType` | ~38 | Lives in **core** (also converters); keep kernel for now, or move to charge-api |
| `ChargeRepositoryWrapper` | ~26 | Impl detail; consumers → ports |
| `ChargeCalculationType` | ~25 | In charge.domain — candidate for **api** enums |
| `ChargeReadPlatformService` | ~25 | Interface → **api** (or replace with port); impl in **provider** today |
| `ChargePaymentMode` | ~19 | In charge.domain — candidate for **api** enums |
| LoanCharge* / SavingsCharge* exceptions | scattered | Misplaced catalog module; eventual loan/savings BC |

**By consumer module (import line counts):**

| Module | ~imports |
|--------|----------|
| `fineract-provider` | ~163 |
| `fineract-loan` | ~37 |
| `fineract-savings` | ~34 |
| `integration-tests` | ~21 |
| `fineract-working-capital-loan` | ~20 |
| `fineract-core` / `fineract-accounting` | ~7 each |
| `fineract-investor` | ~1 |

#### Provider classes that implement / wire charge (move to charge-impl in Step 3)

| Class | Role |
|-------|------|
| `…provider…charge.service.ChargeReadPlatformServiceImpl` | Read impl |
| `…provider…charge.service.ChargeWritePlatformServiceJpaRepositoryImpl` | Write impl |
| `…provider…charge.starter.ChargeConfiguration` | `@Bean` wiring |
| `…provider…charge.util.ConvertChargeDataToSpecificChargeData` | Utility (review ownership) |

#### Charge types living in **fineract-core** (decision for Step 0)

| Type | Decision (Step 0) |
|------|-------------------|
| `portfolio.charge.data.ChargeData` | **Keep in core temporarily** (wide template DTO + accounting/tax deps). Inter-module catalog use → new slim `ChargeDefinitionData` in moduleapi. Later PR: move/slim ChargeData into charge-api when accounting types are ports. |
| `portfolio.charge.domain.ChargeTimeType` (+ converter) | **Keep in core temporarily** (heavily used by loan/savings). Long-term: charge-api enum package. |
| `portfolio.charge.exception.ChargeParameterUpdateNotSupportedException` | Keep with Charge entity updates (impl); not a foreign port type. |

#### Module API after Step 0

| Type | Location | Role |
|------|----------|------|
| `ChargeDefinitionPort` | `…charge.moduleapi` | existsActive / findActive / find / getActive |
| `ChargeDefinitionData` | `…charge.moduleapi` | Pure catalog projection (integer enum codes) |
| `ChargeDefinitionPortJpaAdapter` | `…charge.service` | Spring `@Service` adapter (stays in impl after split) |

Unit tests: `ChargeDefinitionPortJpaAdapterTest` (4 cases).

### 2.3 Target structure (to-be)

```text
fineract-charge/
  README.md
  build.gradle                      # :fineract-charge  compatibility façade (api + impl)
  api/                              # :fineract-charge-api
  impl/                             # :fineract-charge-impl  (main only)
  test/                             # :fineract-charge-test   Fragment-Host → charge.impl
```

```gradle
// settings.gradle (target)
include ':fineract-charge-api'
project(':fineract-charge-api').projectDir = file('fineract-charge/api')
include ':fineract-charge-impl'
project(':fineract-charge-impl').projectDir = file('fineract-charge/impl')
include ':fineract-charge-test'
project(':fineract-charge-test').projectDir = file('fineract-charge/test')
include ':fineract-charge'   // façade
```

Optional: `fineract-charge-integrationtest` **only if** shared fixtures are needed by multiple modules (default: **not** required; loan/savings keep their own tests).

### 2.4 Bundle-SymbolicName (target)

| Project | Bundle-SymbolicName |
|---------|---------------------|
| `:fineract-charge-api` | `org.apache.fineract.charge.api` |
| `:fineract-charge-impl` | `org.apache.fineract.charge.impl` |
| `:fineract-charge-test` | `org.apache.fineract.charge.test` (`Fragment-Host: org.apache.fineract.charge.impl`) |
| `:fineract-charge` (façade) | not a long-term OSGi feature; Boot compatibility only |

### 2.5 Target runtime diagram

```mermaid
flowchart TB
  API[charge-api<br/>moduleapi + enums + service ports + DTOs]
  IMPL[charge-impl<br/>JPA Charge, handlers, REST optional, Spring]
  TST[charge-test<br/>Fragment-Host → charge.impl]
  FAC[charge façade<br/>api + impl]
  REG[(OSGi Service Registry)]
  LOAN[loan / savings / accounting / …]
  PROV[provider composition root]

  IMPL --> API
  FAC --> API
  FAC --> IMPL
  LOAN -->|Import-Package / compile api only| API
  LOAN -->|lookup service| REG
  IMPL -->|register ChargeDefinitionPort<br/>ChargeReadPort / ChargeWritePort| REG
  PROV -->|runtime wire impl + façade during transition| IMPL
  TST -.->|Fragment-Host| IMPL
```

---

## 3. Contract vs implementation (what goes where)

### 3.1 `:fineract-charge-api` — pure contracts

**Include (Export-Package candidates):**

| Area | Examples | Notes |
|------|----------|--------|
| **moduleapi ports** | `ChargeDefinitionPort` (expand), catalog read/write ports | OSGi service interfaces |
| **Stable enums / VOs** | `ChargeAppliesTo`, `ChargeTimeType`, `ChargeCalculationType`, `ChargePaymentMode` | Today leaked as “domain”; treat as published language |
| **DTOs** | `ChargeData` (or slimmed catalog DTO) | Prefer move from core → charge-api over time |
| **Catalog exceptions** | `ChargeNotFoundException`, `ChargeIsNotActiveException`, apply/update/delete rules | Not loan-account charge lifecycle exceptions |

**Exclude from api:**

- JPA `@Entity` (`Charge`), repositories, converters wired to EclipseLink  
- Spring `@Service` / `@Configuration` / `@Component`  
- Jersey/Spring MVC REST resources  
- CQRS handlers, deserializers that depend on platform JSON plumbing (unless pure)  
- LoanCharge* / SavingsAccountCharge* types (loan/savings BC)

**Rules for api (same as command pilot):**

- No Spring Boot, no JPA, no servlet/Jersey types on the export surface  
- Depend only on shared kernel (`fineract-core` subset) where unavoidable; track and shrink  
- **Export-Package:** `…charge.moduleapi`, selected `…charge.data`, enum packages, catalog `exception` as needed  

**OSGi services (register from impl):**

| Service interface | Provider |
|-------------------|----------|
| `ChargeDefinitionPort` | charge-impl (exists; expand methods) |
| Catalog **read** port (new or `ChargeReadPlatformService` purged of platform leakage) | charge-impl |
| Catalog **write** port (new or cleaned `ChargeWritePlatformService`) | charge-impl |

Prefer **new moduleapi ports** that return DTOs/IDs over exporting legacy `*PlatformService` if those still require `JsonCommand` / infrastructure types. If `JsonCommand` must stay temporarily, document as **known debt** and keep write port behind an application service inside impl only (REST/handler in impl).

### 3.2 `:fineract-charge-impl` — domain + adapters + Spring

| Include | Notes |
|---------|--------|
| `domain.Charge` + repositories/wrappers | JPA aggregate root of the catalog |
| Service *implementations* | Move from provider into this module |
| Handlers, serialization, request mapping | Application layer |
| REST `ChargesApiResource` | Driven adapter (or later separate REST bundle) |
| Spring configuration / component scan | Allowed |
| `ChargeOsgiServiceRegistrar` (name TBD) | Reflection-based Service Registry bridge (command pattern) |

**Export-Package:** minimal (prefer **none** for domain packages). Other BCs must not compile against `Charge` entity.

### 3.3 `:fineract-charge-test` — Fragment-Host

- **Fragment-Host:** `org.apache.fineract.charge.impl`  
- White-box unit tests of catalog services/handlers  
- `testImplementation` of impl (+ core/test stack)  
- No production code in main  

### 3.4 Compatibility façade `:fineract-charge`

During migration, keep top-level/façade project that re-exports **api + impl** so existing `implementation project(':fineract-charge')` keeps compiling. Retire after Step 8.

---

## 4. Step-by-step plan (PRs)

Execute as **separate PRs**. Checkboxes start open; update when done.

### Step 0 — Baseline, inventory, Module API growth ✅

1. [x] Freeze baseline: `./gradlew :fineract-charge:test :fineract-loan:compileJava :fineract-savings:compileJava` — **BUILD SUCCESSFUL** (charge had no tests before; loan/savings compile OK)  
2. [x] Document foreign imports of `Charge`, enums, services — refreshed **§2.2**  
3. [x] List provider classes that implement charge interfaces — **§2.2 Provider table** (Step 3 move target)  
4. [x] List charge types living in **core** — **§2.2 Core decision table** (ChargeData / ChargeTimeType stay kernel for now)  
5. [x] Expand **Module API** before physical split ([14.6](14_module_api_boundaries.md)):
   - [x] `ChargeDefinitionData` (slim pure DTO)  
   - [x] `ChargeDefinitionPort`: `existsActiveCharge`, `findActiveCharge`, `findCharge`, `getActiveCharge`  
   - [x] `ChargeDefinitionPortJpaAdapter` + unit tests (4)  
   - [ ] *Deferred to Step 8:* list/filter ports for loan product applicable charges (today still `ChargeReadPlatformService`)  
6. [x] ArchUnit: freeze rules for loan/savings → charge internals **already exist** in `ModuleApiBoundaryRulesTest` (`loan_must_not_depend_on_charge_internals`, `savings_must_not_depend_on_charge_internals`); no change required in Step 0 — shrink freeze via consumer retarget in Step 8  

**Exit:** Ports exist for single-id catalog lookup; inventory agreed; baseline green.  
**Follow-ups for later steps:** provider impl relocation; consumer switch from `Charge` / `ChargeRepositoryWrapper` to port; optional list query ports.

### Step 1 — Introduce projects + settings ✅

1. [x] Create `fineract-charge/api`, `impl`, `test`  
2. [x] `settings.gradle`: `:fineract-charge-api` / `-impl` / `-test` with `projectDir`  
3. [x] api = `java-library`, no Spring Boot / JPA (empty sources until Step 2); impl = Spring + JPA + depends on api; **all production sources moved to impl**  
4. [x] `:fineract-charge` is compatibility **façade** (`api` re-export of api+impl)  
5. [x] Root `build.gradle` lists include charge-api / charge-impl / charge-test  
6. [x] Unit tests live under `fineract-charge/test` (Fragment-Host manifest on test jar)

**Exit:** Modules build; consumers still use `:fineract-charge` façade; `:fineract-charge-test:test` green (4 tests); loan/savings compile OK.

### Step 2 — Extract api contracts ✅

1. [x] Move `moduleapi` + expanded ports into `charge/api`  
2. [x] Move pure catalog enums into api (same packages for binary compatibility): `ChargeAppliesTo`, `ChargeCalculationType`, `ChargePaymentMode` — JPA converters stay on impl  
3. [x] Move catalog exceptions to api: `ChargeNotFoundException`, `ChargeIsNotActiveException`, apply/update/delete/penalty catalog types — **not** LoanCharge*/ShareAccount* (remain on impl)  
4. [x] `ChargeData` / `ChargeTimeType`: **(b)** leave in `fineract-core` for now (Step 0); inter-module catalog uses `ChargeDefinitionData`  
5. [x] No Spring/JPA/REST in api sources (`ChargeNotFoundException` cause is `Throwable`, not Spring JDBC)  
6. [x] Export-Package: `moduleapi`, `domain` (enums only), `exception` (catalog)  

**Exit:** `:fineract-charge-api:jar` is pure contracts; façade still re-exports api+impl; loan/savings/provider compile; charge-test green.

### 2.x As-built package placement (after Step 2)

| Package / type | Location |
|----------------|----------|
| `…charge.moduleapi.*` | **api** |
| `ChargeAppliesTo`, `ChargeCalculationType`, `ChargePaymentMode` | **api** (`…domain`) |
| Catalog exceptions listed above | **api** (`…exception`) |
| `Charge` entity, repositories, converters | **impl** |
| LoanCharge* / ShareAccount* exceptions | **impl** (debt: move to loan/savings later) |
| Handlers, services, REST | **impl** |
| `ChargeData`, `ChargeTimeType` | **core** (temporary kernel) |

### Step 3 — Move remaining implementation from provider into charge-impl ⏳

1. [x] Catalog `domain`/handlers/service interfaces/REST already on `charge/impl` (Step 1)  
2. [ ] **Move** `ChargeReadPlatformServiceImpl` / `ChargeWritePlatformServiceJpaRepositoryImpl` from **provider** into impl  
3. [ ] Move/adjust `ChargeConfiguration` beans into charge-impl (or keep provider as composition-only wiring that imports impl config)  
4. [x] Façade re-exports api + impl for Boot  
5. [x] Impl depends on api + tax/core; **not** on loan/savings  

**Exit:** Provider no longer owns charge catalog service implementations; application boots with façade.

### Step 4 — Bundle metadata ⏳

| Header | api | impl | test |
|--------|-----|------|------|
| `Bundle-SymbolicName` | `org.apache.fineract.charge.api` | `org.apache.fineract.charge.impl` | `org.apache.fineract.charge.test` |
| `Export-Package` | moduleapi + contract packages | none (or starter only if required) | n/a |
| `Import-Package` | core/kernel as needed | api + Spring + JPA + … | host |
| `Fragment-Host` | — | — | `org.apache.fineract.charge.impl` |

Bootstrap with `jar { manifest { attributes … } }` (bnd optional later), same as command.

### Step 5 — Fragment-Host unit tests ⏳

1. [ ] Place white-box tests under `fineract-charge/test/src/test`  
2. [ ] Impl remains production **main only**  
3. [ ] `./gradlew :fineract-charge-test:test` green  
4. [ ] Do **not** create integrationtest unless a second module needs shared charge fixtures  

### Step 6 — Spring↔OSGi service registrar ⏳

1. [ ] Add `…charge.impl.osgi.ChargeOsgiServiceRegistrar` (reflection / optional BundleContext — command pattern)  
2. [ ] Register at least `ChargeDefinitionPort` + any new read ports  
3. [ ] Boot path without OSGi remains unchanged  
4. [ ] **No Karaf Features**

### Step 7 — Consumers compile against api (mechanical) ⏳

| Consumer | Target compile dep | Runtime |
|----------|-------------------|---------|
| loan, savings, accounting, investor, progressive, working-capital | `:fineract-charge-api` | provider brings impl |
| provider | façade or api+impl | composition root |
| integration-tests | runtimeElements of façade/impl as today | unchanged initially |

Gradle: replace `implementation project(':fineract-charge')` with **api** for domain modules; keep façade for provider until Step 8 done.

### Step 8 — Consumer retarget (semantic) ⏳

Hardest step — incremental PRs by consumer:

1. [ ] Replace `Charge` entity usage with ports/DTOs in **new** code paths first  
2. [ ] Loan product / loan charge setup: resolve catalog via port, map to loan-local types  
3. [ ] Savings / shares / accounting mappings: same  
4. [ ] Stop exporting / depending on `ChargeRepositoryWrapper` outside impl  
5. [ ] ArchUnit: forbid foreign `…charge.domain.Charge` (and shrink freeze)  
6. [ ] Deprecate façade `:fineract-charge` when domain modules no longer need it  

**Note:** Full elimination of `Charge` imports from loan may span multiple PRs; track residual freeze entries explicitly.

### Step 9 — Documentation & acceptance ⏳

1. [ ] Update this plan status table to **done** per step  
2. [ ] Module READMEs under `fineract-charge/{api,impl,test}`  
3. [ ] [osgi/README.md](../../osgi/README.md) pilot table row for charge  
4. [ ] [15.6 rollout](15_osgi_bundle_refactoring.md#suggested-rollout-order-postcommand-pilot) — mark charge as in progress/done  
5. [ ] Optional Gherkin `@adr-022` charge service present/absent  

**Acceptance criteria**

| # | Criterion | Status |
|---|-----------|--------|
| 1 | api, impl, test fragment artifacts build | pending |
| 2 | api has no Spring / JPA / REST | pending |
| 3 | Domain modules compile on **charge-api** only (provider exception) | pending |
| 4 | Ports registered in OSGi Service Registry (bridge present) | pending |
| 5 | No Karaf Feature descriptors | pending |
| 6 | Spring still wires impl under Boot | pending |
| 7 | Fragment-Host tests green | pending |
| 8 | Sources under `fineract-charge/{api,impl,test}` | pending |
| 9 | No *new* foreign uses of `Charge` entity; freeze only shrinks | pending |
| 10 | Provider no longer hosts charge catalog service impls | pending |

---

## 5. Suggested PR sequence

| PR | Title (suggested) | Steps |
|----|-------------------|--------|
| PR-0 | charge: inventory + expand ChargeDefinitionPort / moduleapi | 0 |
| PR-1 | charge: api/impl/test Gradle shells + façade | 1 |
| PR-2 | charge: extract charge-api contracts (ports, enums, DTO policy) | 2 |
| PR-3 | charge: move catalog stack into charge-impl; pull impls from provider | 3 |
| PR-4 | charge: OSGi manifests | 4 |
| PR-5 | charge: Fragment-Host unit tests | 5 |
| PR-6 | charge: OSGi service registrar | 6 |
| PR-7 | charge: domain modules depend on charge-api | 7 |
| PR-8+ | charge: retarget loan/savings/… off Charge entity | 8 |
| PR-final | charge: docs, freeze shrink, façade deprecate | 9 |

---

## 6. Risks and mitigations

| Risk | Mitigation |
|------|------------|
| Widespread `Charge` entity coupling | Expand ports first; freeze new imports; multi-PR retarget; temporary façade |
| Types split across **core** and charge | Explicit Step 0 decision; prefer charge-api ownership of catalog DTO/enums |
| Service impls still in **provider** | Step 3 move is mandatory; scan provider for leftover charge components |
| Enum duplication (core vs charge) | Single source of truth in api; delete duplicates |
| `JsonCommand` on write API | Keep write application service in impl; expose only high-level ports to other BCs |
| Tax dependency | impl may depend on tax-api later; until tax is split, depend on `fineract-tax` monolith |
| LoanCharge* exceptions in charge module | Do not put on charge-api export; migrate to loan in a follow-up |
| Nested `projectDir` breaks CI name lists | Keep Gradle names `fineract-charge-api` etc. stable |
| Equinox not in CI | Manifest + unit tests first; optional Equinox smoke |

---

## 7. Out of scope

- Full **loan charge** / **savings charge** aggregate redesign  
- Event-sourcing the charge catalog ([ADR-020](decisions/ADR-020-event-sourcing-writes-pflicht.md))  
- Karaf Features packaging  
- Removing Spring from charge-impl  
- Running full Fineract inside Equinox as the primary process  
- Splitting tax in the same PR series (coordinate only: charge-impl may keep depending on tax monolith until tax Wave 1)

---

## 8. Commands cheat sheet

```bash
# After shells exist
./gradlew :fineract-charge-api:jar \
  :fineract-charge-impl:jar \
  :fineract-charge-test:test \
  :fineract-charge:jar

# Consumer compile check (examples)
./gradlew :fineract-loan:compileJava \
  :fineract-savings:compileJava \
  :fineract-accounting:compileJava \
  :fineract-provider:compileJava

# Equinox experiment (optional)
# cp fineract-charge/api/build/libs/*.jar osgi/bundles/
# cp fineract-charge/impl/build/libs/*.jar osgi/bundles/
# cp fineract-charge/test/build/libs/*.jar osgi/bundles/   # Fragment-Host = charge.impl
```

---

## 9. Relation to architecture docs

| Artifact | Relation |
|----------|----------|
| [15](15_osgi_bundle_refactoring.md) §15.6 | Charge is Wave‑1 #1 after command |
| [15a command](15_osgi_bundle_refactoring_fineract-command.md) | Mechanical template (shells, façade, Fragment-Host, registrar) |
| [14 Module API](14_module_api_boundaries.md) | Ports before physical split |
| [10 Context map](10_domain_context_map.md) | Charge Catalog BC |
| [ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md) | Bundle layout + Service Registry |
| [osgi/README](../../osgi/README.md) | Equinox scaffold |

---

*Navigation:* [15 playbook](15_osgi_bundle_refactoring.md) · [command pilot](15_osgi_bundle_refactoring_fineract-command.md) · [ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md) · [14 Module API](14_module_api_boundaries.md)
