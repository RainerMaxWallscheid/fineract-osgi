# fineract-document – OSGi api / impl / test refactoring plan

Wave‑2 module after Wave 1 (charge / rates / tax)
([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — Steps **0–9** (api/impl/test + `ContentStoreService` / `ContentStreamPort`; provider bulk-import on ports; composition root still api+impl) |
| **Module** | Document management + content store (FS / S3) |
| **No façade** | Compose with `:fineract-document-api` + `:fineract-document-impl` explicitly |

**Inter-bundle access:** OSGi **Service Registry** (`ContentStoreService`, document read/write ports).  
**Spring:** stays in **document-impl** (including `ContentStoreConfig`).

---

## 1. Why document is next

| Criterion | Fit |
|-----------|-----|
| Hexagonal | Real replaceable adapter: **FS vs S3** via `ContentStoreService` |
| Size | ~85 main types |
| Consumers | **provider** (bulk import, staff/client images) + war; few domain modules |
| Ports | `ContentStoreService` already exists; document/image read-write interfaces |

---

## 2. Layout (as-built)

```text
fineract-document/
  README.md
  api/     → :fineract-document-api
  impl/    → :fineract-document-impl
  test/    → :fineract-document-test  (Fragment-Host → document.impl)
```

| Gradle | Bundle-SymbolicName | Export |
|--------|---------------------|--------|
| `:fineract-document-api` | `org.apache.fineract.document.api` | contentstore + documentmanagement contracts |
| `:fineract-document-impl` | `org.apache.fineract.document.impl` | util/config/processor residual for provider |
| `:fineract-document-test` | `org.apache.fineract.document.test` | Fragment-Host |

---

## 3. Package placement

| Package | Slice |
|---------|--------|
| `…contentstore.moduleapi` | **api** — package docs |
| `…contentstore.service.ContentStoreService` | **api** — **primary OSGi port** |
| `…contentstore.data` / `exception` | **api** |
| `…documentmanagement.service` (interfaces) | **api** |
| `…documentmanagement.data` / `exception` / `command` / constants | **api** |
| FS/S3 services, detectors, policies, processors, util, config | **impl** |
| REST, handlers, domain, mappers, events | **impl** |
| `…document.impl.osgi` | **impl** — `DocumentOsgiServiceRegistrar` |

**Not in this module:** `EntityImageIdAdapter` lives in **fineract-core** (kernel trick).

---

## 4. Steps

### Step 0 — Baseline ✅
Inventory: provider bulk-import + image adapters; war packaging.

### Step 1 — Project shells ✅
`settings.gradle` → api / impl / test; no façade.

### Step 2 — Extract api ✅
Content store port + document/image service interfaces + DTOs/commands/exceptions.

### Step 3 — Impl under document-impl ✅
FS/S3, policies, processors, REST, handlers, domain, registrar.

### Step 4 — Bundle metadata ✅
Manifest Export/Import/Fragment-Host.

### Step 5 — Fragment-Host tests ✅
Existing contentstore/document tests + registrar smoke test under document-test.

### Step 6 — OSGi registrar ✅
`DocumentOsgiServiceRegistrar` → `ContentStoreService`, `DocumentReadPlatformService`, `DocumentWritePlatformService`.

### Step 7 — Mechanical consumer Gradle ✅
| Consumer | Edge |
|----------|------|
| provider / war | api + **impl** (composition root loads Spring beans) |

### Step 8 — Semantic residual ✅
- [x] Provider bulk-import uses `ContentStreamPort` (not `ContentPipe`)
- [x] `ContentPipe` implements `ContentStreamPort`; registered in OSGi
- [x] Impl no longer exports util/processor packages (AWS/FS stay internal)
- [x] Pure DTO/port types on document-api; composition root keeps api+impl

### Step 9 — Docs ✅
This plan + module README + osgi / parent 15 updates.

---

## 5. Commands

```bash
./gradlew :fineract-document-api:jar :fineract-document-impl:jar :fineract-document-test:test
./gradlew :fineract-provider:compileJava
```
