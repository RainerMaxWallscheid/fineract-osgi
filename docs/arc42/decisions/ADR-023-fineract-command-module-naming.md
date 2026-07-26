# ADR-023 – Name the command capability `fineract-command` (drop `…-core`)

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Maintainability, Extensibility, Clarity (DDD / Hexagon / OSGi) |
| **Related to** | [ADR-022](ADR-022-osgi-api-impl-test-bundles-services.md), [ADR-021](ADR-021-modul-kommunikation-nur-ueber-module-api.md), [ADR-017](ADR-017-hexagonale-architektur.md), [ADR-019](ADR-019-domain-driven-design.md), [ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md), [ADR-002](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md) |

### Context

After the OSGi pilot ([ADR-022](ADR-022-osgi-api-impl-test-bundles-services.md)), the modern CQRS command stack was split into api / impl / test and optional satellites (jdbc, async, disruptor, audit). A **compatibility façade** kept the Gradle name `:fineract-command`, so real sources were temporarily placed under **`fineract-command-core/{api,impl}`** with projects `:fineract-command-core-api` / `:fineract-command-core-impl` and BSNs `org.apache.fineract.command.core.api` / `.core.impl`.

That layout was packaging history, not a clearer domain border:

| Force | Issue with the temporary `…-command-core` name |
|-------|------------------------------------------------|
| **DDD** | “Command” is **platform / application** infrastructure (write pipeline), not a portfolio BC—and not “domain core”. The suffix **core** adds no ubiquitous language. |
| **Hexagon** | Ports live in **api**, application + default adapters in **impl**. “Core” is often read as **domain model**, which this stack is not. |
| **OSGi** | Needed split is **api vs impl vs optional services**, not a middle name “core”. |
| **Collision** | **`fineract-core`** is already the shared-kernel module; `fineract-command-core` confuses newcomers. |
| **Prominence** | The empty façade owned the good name; the real module was demoted to `-core`. |

### Decision

1. **Module / capability name = `fineract-command`**  
   That name is the border of the command-processing capability on the platform map (supporting / generic application infrastructure for CQRS writes—[ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md)).

2. **Drop `fineract-command-core` as a product / directory / Gradle coordinate prefix**  
   Filesystem and project names use **`fineract-command`**, not `…-command-core`.

3. **Layout (implemented with this ADR)**

```text
fineract-command/
  api/                 # Gradle :fineract-command-api   → ports, OSGi Export-Package
  impl/                # Gradle :fineract-command-impl  → app + default adapters, Spring, OSGi registrar
  build.gradle         # optional compatibility façade (re-exports api + impl)
  README.md

fineract-command/test/              # Fragment-Host → command.impl (unit tests)
fineract-command-integrationtest/  # shared IT fixtures for all command modules
fineract-command-jdbc/ # optional driven adapter
fineract-command-async/
fineract-command-disruptor/
fineract-command-audit/
```

4. **Gradle project names**

| Role | Project | `projectDir` |
|------|---------|--------------|
| Ports | `:fineract-command-api` | `fineract-command/api` |
| Default impl | `:fineract-command-impl` | `fineract-command/impl` |
| Façade (temporary) | `:fineract-command` | `fineract-command/` (aggregator only) |
| Unit test fragment | `:fineract-command-test` | `fineract-command/test` |
| Shared IT fixtures | `:fineract-command-integrationtest` | `fineract-command-integrationtest/` |

5. **OSGi Bundle-SymbolicName**

| Bundle | BSN |
|--------|-----|
| api | `org.apache.fineract.command.api` |
| impl | `org.apache.fineract.command.impl` |
| unit test fragment | `org.apache.fineract.command.test` (`Fragment-Host: org.apache.fineract.command.impl`) |
| IT support | `org.apache.fineract.command.integrationtest` (no Fragment-Host) |
| satellites | `org.apache.fineract.command.jdbc` / `.async` / … (unchanged policy) |

6. **Java packages**  
   Keep existing package names for binary stability of this pilot (e.g. `org.apache.fineract.command.core` for port types, `…command.impl.config` for Spring properties). **Module path ≠ Java package rename** in this ADR. A future cleanup may introduce `…command.moduleapi` if desired ([ADR-021](ADR-021-modul-kommunikation-nur-ueber-module-api.md)).

7. **Hexagon / DDD placement (explicit)**

| Hexagon | Command stack |
|---------|----------------|
| Ports | `:fineract-command-api` |
| Application + default adapters | `:fineract-command-impl` |
| Optional driven / alternate adapters | jdbc, async, disruptor, audit |
| Domain aggregates (Loan, …) | **out of this module** |

Context map: **platform application infrastructure**, not a loan/savings bounded context.

8. **Still multi-bundle**  
   This ADR renames and regroups; it does **not** collapse api/impl/satellites into one OSGi bundle. Optional `CommandDispatcher` / `CommandStore` remain separate install units.

### Alternatives

| Option | Assessment |
|--------|------------|
| Keep `fineract-command-core` permanently | Rejected: weak DDD/hexagon signal; confuses with `fineract-core` |
| Rename capability to `fineract-cqrs` / `fineract-command-platform` | Possible later; longer; no stronger BC signal than `command` |
| Nested Gradle path only (`:fineract-command:api`) | Deferred: root `it.name` lists use short names; flat project names + `projectDir` match existing conventions |
| Merge api into impl | Rejected (OSGi Export-Package / ADR-022) |

### Consequences

- **+** Module name matches capability and docs  
- **+** api/impl under one directory tree reflect hexagon slices of **one** module  
- **+** BSNs shorter and aligned with OSGi practice  
- **−** One-time rename of Gradle paths, deps, docs, Fragment-Host  
- **−** Façade still named `:fineract-command` until consumer retarget removes it  
- **−** Java package `…command.core` remains until a separate package migration  

### Non-Goals

- Renaming all Java packages under `org.apache.fineract.command.core`  
- Merging optional satellites into impl  
- Full Fineract-in-OSGi container packaging  

### Related

- Pilot plan: [15_osgi_bundle_refactoring_fineract-command.md](../15_osgi_bundle_refactoring_fineract-command.md)  
- Bundle split rules: [ADR-022](ADR-022-osgi-api-impl-test-bundles-services.md)  
- Module API: [ADR-021](ADR-021-modul-kommunikation-nur-ueber-module-api.md)  

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
