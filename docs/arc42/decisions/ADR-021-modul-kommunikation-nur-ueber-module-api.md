# ADR-021 – Module Communication Only via Module API

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Maintainability, Extensibility, Testability, Compatibility |
| **Related to** | [ADR-017](ADR-017-hexagonale-architektur.md), [ADR-019](ADR-019-domain-driven-design.md), [ADR-002](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md) |

### Context

fineract-osgi is a **modular monolith** (Gradle modules ≈ bounded contexts). Today modules often access foreign **internals** directly:

- JPA entities (`Loan`, `Charge`, `GLAccount`, …)
- WritePlatformService implementations
- Handlers, repositories, starter configuration

This contradicts hexagon (ports at module boundaries) and DDD (no freely shared aggregates across context boundaries). OSGi feature bundles need the same **stable ports**.

At the same time, `..api..` packages are historically often **REST driving adapters** (`*ApiResource`) – **not** the module public API. Hence a new, explicit name.

### Decision

**Subprojects (domain modules) communicate with each other only through a published Module API** – not through domain entities, service implementations, or REST resource classes.

#### Naming convention

| Term | Package pattern | Role |
|------|-----------------|------|
| **Module API** | `..moduleapi..` | **Only** allowed domain interface for *other* modules (ports, commands/queries as interfaces, stable DTOs/IDs) |
| **REST API** | `..api..` (historical) | Driving adapter HTTP – **not** for module-to-module |
| **Internal** | `..domain..`, `..service..`, `..handler..`, `..starter..`, repositories, mapper impls | Module-internal only |
| **Shared kernel** | deliberately narrow in `fineract-core` | Money, Tenant, ExternalId, Permissions, command metamodel – no business aggregate |

```text
┌─────────────────┐         moduleapi / Events          ┌─────────────────┐
│  fineract-loan  │ ──────────────────────────────────► │ fineract-charge │
│  domain/service │         (Ports, DTOs, IDs)          │  moduleapi      │
│  REST api       │                                     │  domain (hidden)│
└─────────────────┘                                     └─────────────────┘
```

#### Allowed integration means between modules

1. **Module API** (`..moduleapi..`) – ports + stable transfer objects  
2. **Domain / business events** (published language, see event catalog)  
3. **Shared kernel** (narrow)  
4. **Avro / external event schemas** for asynchronous downstream integrations  

#### Forbidden (target; legacy frozen via ArchUnit)

- Import of foreign `..domain..` entities  
- Call of foreign `*WritePlatformService`/repository **implementations**  
- Dependency on foreign REST `..api..` resources or `*JsonInputParams` from REST packages  
- “Utility” access to foreign `handler`/`starter`

#### Hexagon mapping

| Hexagon | Module-internal | Across module boundary |
|---------|-----------------|------------------------|
| Domain | Aggregates, invariants | **never** exported directly |
| Application | Handlers, use cases | optional ports in `moduleapi` |
| Ports | Interfaces in `moduleapi` | **yes** – that is the Module API |
| Adapters | REST, JPA, Kafka, OSGi | REST not imported by foreign modules |

#### Evolution stages

| Stage | Content |
|-------|---------|
| **M1** | This ADR + ArchUnit rules with freeze baseline |
| **M2** | Per domain module `moduleapi` package + `package-info`; new cross-module features **only** via Module API |
| **M3** | Extract hotspot ports (e.g. charge lookup, GL mapping, client guard) and shrink freeze store |
| **M4** | Gradle `java-library` / separate `-api` artifacts or OSGi export packages = `moduleapi` only; physical **api/impl/test** bundles + Service Registry → [ADR-022](ADR-022-osgi-api-impl-test-bundles-services.md) / [15](../15_osgi_bundle_refactoring.md) |

### Alternatives

| Option | Assessment |
|--------|------------|
| Misuse REST `..api..` as module API | Confuses driving adapter ↔ port; rejected |
| Microservices per module immediately | too expensive; Module API scales in the monolith and toward OSGi |
| Share everything in `fineract-core` | Shared kernel explodes; rejected |
| Code review only without ArchUnit | Regressions uncontrolled |

### Consequences

- **+** Clear context boundaries, better testability, OSGi-ready ports  
- **+** Fits context map, event catalog, entity ArchUnit rules  
- **−** Existing code violates rules heavily → **FreezingArchRule** until strangler takes hold  
- **−** Teams must define a port in `moduleapi` first for cross-module features  

### Non-Goals

- Immediate rename of all REST `api` packages  
- Big-bang extraction of all service interfaces  
- Provider shell may wire modules (composition root) – it is not a domain module under this rule  

### Enforcement

- ArchUnit: [`ModuleApiBoundaryRulesTest`](../../../fineract-architecture/src/test/java/org/apache/fineract/architecture/ModuleApiBoundaryRulesTest.java)  
- Docs: [13 ArchUnit](../13_archunit_bounded_context_rules.md), [14 Module API](../14_module_api_boundaries.md)  
- Freeze store: `fineract-architecture/src/test/resources/archunit_store/`

### Related

- [ADR-017 Hexagon](ADR-017-hexagonale-architektur.md) – ports at boundaries  
- [ADR-019 DDD](ADR-019-domain-driven-design.md) – context map without entity sharing  
- [ADR-002 OSGi](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md) – exportable contracts  
- [ADR-022 OSGi api/impl/test + services](ADR-022-osgi-api-impl-test-bundles-services.md) – physical bundle split; Service Registry (no Karaf Features)  
- [10 Context Map](../10_domain_context_map.md)

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
