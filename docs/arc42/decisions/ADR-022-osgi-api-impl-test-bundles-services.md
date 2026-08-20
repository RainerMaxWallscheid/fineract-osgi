# ADR-022 – OSGi api / impl / test bundles with Service Registry (no Karaf Features)

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Extensibility, Maintainability, Testability, Deployability |
| **Related to** | [ADR-002](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md), [ADR-003](ADR-003-spring-boot-gradle-module-als-kern-beibehalten.md), [ADR-017](ADR-017-hexagonale-architektur.md), [ADR-021](ADR-021-modul-kommunikation-nur-ueber-module-api.md) |

### Context

fineract-osgi already has Gradle domain modules and a growing `moduleapi` surface ([ADR-021](ADR-021-modul-kommunikation-nur-ueber-module-api.md)). Runtime modularity uses **Eclipse Equinox** ([ADR-002](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md)). Spring Boot remains the application and DI foundation inside the core ([ADR-003](ADR-003-spring-boot-gradle-module-als-kern-beibehalten.md)).

Still missing is a concrete **bundle layout** and wiring rule:

- How are subprojects split into OSGi bundles?
- How do tests attach to production bundles?
- What is the **only** allowed runtime access path between bundles?
- Does Spring stay inside bundles, and must it be removed before the OSGi refactor?

Without an explicit decision, teams risk either a big-bang Spring removal or introducing **Apache Karaf Features** as the inter-module integration mechanism.

### Decision

#### 1. Inter-bundle access = OSGi Service Registry only

- Bundles publish and consume **OSGi services** registered under interfaces from the **api** bundle.
- Consumers never depend on another module’s **impl** types at compile time (Gradle `implementation` of a foreign `-impl` is forbidden for domain modules).
- Package **Export-Package** is limited to api / shared-kernel contracts; impl packages stay private (registrar / DS implementation types are not exported).
- Optional services: bind via Service Tracker / Declarative Services; missing service → **degradation**, not total failure ([ADR-002](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md)).

#### 2. Explicit non-goal: Apache Karaf Features (and similar feature install models)

- **Do not** use **Karaf Features**, OSGi Feature Model install descriptors, or other “feature XML” packaging as the **integration contract** between modules.
- Install/start order may use plain Equinox (`osgi/bundles`, `config.ini`, start levels) or simple scripts; ops packaging is separate from the Java API.
- Karaf as an optional **distribution shell** remains deferred ([08.2](../08_design_decisions.md)); it is **not** required and not the module-to-module API.

#### 3. Subproject layout: api / impl / test bundles

Each logical domain (or platform) module is organized as Gradle subprojects that map 1:1 to OSGi bundles:

```text
fineract-<name>/
  fineract-<name>-api/     # interface / contract bundle
  fineract-<name>-impl/    # implementation bundle
  fineract-<name>-test/    # test fragment bundle(s)
```

| Bundle | Role | OSGi rules |
|--------|------|------------|
| **`-api`** | Ports (`moduleapi`), stable DTOs/IDs, service interfaces | **Export-Package** contract packages only; no Spring, JPA, REST, EclipseLink |
| **`-impl`** | Domain, handlers, adapters, Spring configuration | Implements and **registers** OSGi services; imports api; no `Export-Package` |
| **`-test`** | Unit / white-box tests | **`Fragment-Host`** points at the **impl** host (primary); pure contract tests may stay non-fragment on `-api` |

#### 4. Test bundles use Fragment-Host

- Primary pattern: `Fragment-Host: <impl Bundle-SymbolicName>` so tests share the host classloader and can exercise internal packages without exporting them to production consumers.
- Prefer **one host per test fragment** (usually the impl bundle).
- Contract-only tests that only mock api interfaces do not need a fragment.

#### 5. Spring stays inside impl bundles — do not remove Spring before OSGi

| Concern | Mechanism |
|---------|-----------|
| **Between bundles** | OSGi Service Registry (+ events / shared kernel) — **not** Spring `@Autowired` across bundles |
| **Inside `-impl`** | Spring DI, Spring Data JPA, Security, Batch, Boot auto-config — **allowed and expected** |
| **On `-api` surface** | Pure Java; no Spring types |

- **Do not** remove Spring Boot / Spring Framework as a prerequisite for the OSGi refactor.
- Pure OSGi Blueprint / DS-only core without Spring remains **rejected** ([ADR-003](ADR-003-spring-boot-gradle-module-als-kern-beibehalten.md)).
- A small **Spring↔OSGi bridge** in the composition root (`fineract-provider` or `fineract-osgi-bridge`) publishes selected beans as OSGi services under **api** interfaces and optionally injects optional OSGi services into Spring.

#### 6. Mapping Module API → OSGi

| Today (ADR-021) | Target (this ADR) |
|-----------------|-------------------|
| `..moduleapi..` packages | Exported packages of `-api` bundles |
| Port interfaces | OSGi service interfaces |
| Provider wires Spring beans | Bridge registers the same interfaces in the Service Registry |
| ArchUnit freeze against foreign internals | Plus: no compile dependency on foreign `-impl` |

#### 7. Refactoring is stepwise (no big bang)

Full playbook: [15 OSGi Bundle Refactoring](../15_osgi_bundle_refactoring.md).

| Stage | Content |
|-------|---------|
| **B0** | Guardrails: ArchUnit Module API, `moduleapi` ports (already started) |
| **B1** | Bundle tooling (bnd / manifests, symbolic names, export whitelist) |
| **B2** | Pilot split of one small module into api/impl/test — **done for `fineract-command`**; Waves **1–4** domain modules **complete** (see [15.6](../15_osgi_bundle_refactoring.md#suggested-rollout-order-postcommand-pilot)) |
| **B3** | Spring↔OSGi bridge in composition root — **done** (empty-catalog activators catalog-wide; every Equinox-safe PILOT_PORT hosted via `osgi/CompositionRootOsgiBridge`; optional Boot embed `fineract.osgi.enabled` registers every Equinox-safe hosted Spring port, exposes `OsgiServiceLookup` and OSGi-backed Spring beans when Boot has none, and may install `fineract.osgi.catalog-dir`; `ContentStreamPort` / `PaymentDetailWritePlatformService` empty-catalog only; `CommandDispatcher` hosted-only; per-module `*OsgiServiceRegistrar` remains the Boot classpath path) |
| **B4** | Consumers obtain ports only via OSGi services (or bridge façade), not foreign impl — **done** (`./gradlew checkForeignImplDeps`; leftover JPA `*-impl` edges allow-listed); full OSGi lookup **started** (`ChargeDefinitionPort` is a `@Primary` Service Registry façade when `fineract.osgi.enabled=true`; remaining PILOT_PORTs still Spring-inject) |
| **B5** | Roll out further domain modules — **done** (ranked waves + leftover peels 1–30 closed; `./gradlew checkArchUnitFreeze` holds the leftover freeze-store budget). Freeze shrink **started** (662 leftover JPA/entity lines; leftover catalog enums closed onto `moduleapi`; WC journals use `WorkingCapitalLoanJournalPort`; savings journals use `SavingsJournalPort`; loan-transaction journals use `LoanJournalPort`; investor transfer status checks use `LoanDataForExternalTransfer.getLoanStatusName()`; transfer journals use `ExternalOwnerTransferJournalPort`; no core peel). Do not peel `fineract-provider` or remaining `fineract-core` kernel types |
| **B6** | Optional: DS-only for Equinox-safe empty catalog ports — **done** (every Equinox-safe empty catalog port and the command dispatcher graph via `Service-Component` + staged Felix SCR, including loan / progressive-loan / WC-loan / COB / security; impl `Export-Package` empty; no Bundle-Activator remains; no-port modules have no Equinox activator; `check-manifests` holds DS descriptors, the DS extender requirement, provide interfaces as PILOT_PORTs, unused Framework imports, and start paths; Boot registrar stays Spring) |

### Alternatives

| Option | Assessment |
|--------|------------|
| **Apache Karaf Features as module contract** | Rejected for integration; heavier platform, couples deploy model to Java boundaries; Equinox + Service Registry is enough |
| **Gradle modules only (no OSGi services)** | Insufficient for runtime optional extensions ([ADR-002](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md)) |
| **Remove Spring first, then OSGi** | Rejected: multi-year rewrite; loses Batch/Security/JPA; violates [ADR-003](ADR-003-spring-boot-gradle-module-als-kern-beibehalten.md) |
| **Single fat bundle per domain (no api/impl split)** | Weaker isolation; consumers can leak to internals |
| **Test bundle as normal Require-Bundle on impl** | Forces export of test-only packages; Fragment-Host preferred |
| **Blueprint / Gemini Blueprint as sole DI** | Rejected for core; Spring remains inside impl |

### Consequences

- **+** Clear api/impl separation ready for hot-deploy and customer-specific impl bundles  
- **+** Inter-bundle contract is the same as Module API + OSGi Service Registry (one story for build and runtime)  
- **+** Spring continuity; domain migration stays incremental  
- **+** Tests stay powerful without polluting production Export-Package  
- **−** Two DI worlds (Spring inside, OSGi between) need an explicit bridge  
- **−** Physical split of existing modules is multi-step work  
- **−** Teams must not introduce Karaf Feature descriptors as a substitute for service interfaces  

### Non-Goals

- Immediate split of all modules  
- Mandatory Karaf runtime  
- Removing Spring from the core banking path  
- Using REST `..api..` packages as OSGi exports  

### Related

- Playbook: [15 OSGi Bundle Refactoring](../15_osgi_bundle_refactoring.md)  
- Command module naming (no `…-core`): [ADR-023](ADR-023-fineract-command-module-naming.md)  
- Module API: [14](../14_module_api_boundaries.md), [ADR-021](ADR-021-modul-kommunikation-nur-ueber-module-api.md)  
- Runtime OSGi: [04.4](../04_runtime_view.md)  
- Crosscutting OSGi: [06.7](../06_crosscutting_concepts.md)  
- Equinox scaffold: [`osgi/`](../../../osgi/README.md)

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
