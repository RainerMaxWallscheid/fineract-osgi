# 9. Glossary

Glossary for the arc42 documentation of **fineract-osgi**. Entries are alphabetical (mixed English terms as used in the chapters). Domain Fineract terms and architecture abbreviations are treated equally.

**Legend**

| Tag | Meaning |
|-----|---------|
| *A* | Architecture / arc42 |
| *B* | Operations / Deployment |
| *F* | Domain Core Banking |
| *T* | Technology / Framework |

Chapter references: [01](01_introduction.md)–[13](13_archunit_bounded_context_rules.md).

---

## 9.1 A–C

| Term | Tag | Definition |
|------|:---:|------------|
| **Actuator** | T | Spring Boot endpoints for health, metrics, etc. (`/fineract-provider/actuator/...`). Used for K8s probes. → [05](05_deployment_view.md) |
| **ADR** | A | *Architecture Decision Record* – documented design decision (Chapter 8, ADR-light). → [08](08_design_decisions.md) |
| **Aggregate** | A/T | DDD: consistency boundary and write unit (root + related entities). → [ADR-019](decisions/ADR-019-domain-driven-design.md), Canvas [11](11_aggregate_canvas.md) |
| **Aggregate Canvas** | A | Compact description of an aggregate: root, members, invariants, commands, events, conflicts. → [11](11_aggregate_canvas.md) |
| **ArchUnit** | T | Library for architecture/dependency tests (e.g. bounded-context boundaries). → [13](13_archunit_bounded_context_rules.md) |
| **All-in-One** | B | Deployment topology in which read, write, batch manager, and worker are active in **one** process. → [05](05_deployment_view.md) |
| **AppUser** | F/T | Authenticated back-office user in Fineract; permissions via roles/permissions. |
| **arc42** | A | Template for architecture documentation (context, building blocks, runtime, deployment, quality, ADRs, …). |
| **Audit / Command Audit** | F/T | Traceable record of write operations, typically in `m_portfolio_command_source`. → [06](06_crosscutting_concepts.md) |
| **AuthN / AuthZ** | T | *Authentication* (who?) and *Authorization* (allowed?). → [06](06_crosscutting_concepts.md) |
| **Batch Manager** | B | Node role that plans and partitions jobs (e.g. COB) (`batch-manager-enabled`). Exactly one active manager per cluster. → [05](05_deployment_view.md) |
| **Batch Worker** | B | Node role that executes job partitions (`batch-worker-enabled`). Horizontally scalable. → [05](05_deployment_view.md) |
| **Bundle (OSGi)** | T | Installable OSGi unit (JAR) with manifest, lifecycle, and optional services. → [04](04_runtime_view.md), [05](05_deployment_view.md) |
| **Business Date** | F | Domain business-day date of a tenant; controls e.g. booking logic and COB. Filter: `BusinessDateFilter`. |
| **Bounded Context** | A | DDD: explicit boundary of a domain model (often a domain module). → [ADR-019](decisions/ADR-019-domain-driven-design.md), [10 Context Map](10_domain_context_map.md) |
| **Anti-Corruption Layer (ACL)** | A | DDD: translation layer that shields foreign/external models from the own bounded context (e.g. Interop, AI, legacy JSON). → [10](10_domain_context_map.md) |
| **Boy Scout Rule** | A | Leave touched code a bit cleaner than found (within PR scope). → [ADR-018](decisions/ADR-018-clean-code.md) |
| **Business Event** | T | Domain event after a domain change (e.g. Loan created); internal or as external event. → [06](06_crosscutting_concepts.md), inventory [12](12_event_catalog.md) |
| **Business Step** | F/T | Single step in a COB/job pipeline (e.g. accrual, penalty). |
| **Circuit Breaker** | T | Resilience pattern: temporarily stops calls to a failing downstream (e.g. AI API). |
| **COB** | F | *Close of Business* – periodic day-end processing (interest, penalties, status, etc.), often partitioned. → [04](04_runtime_view.md) |
| **Command** | T | Write instruction in the CQRS model; legacy as `CommandWrapper`/`JsonCommand`, new as type-safe `Command<REQ>`. |
| **Command Dispatcher** | T | Component in module `fineract-command` that routes commands to handlers (sync/async/Disruptor). → [04](04_runtime_view.md) |
| **Command Handler** | T | Executes the domain write logic for a command type (`NewCommandSourceHandler` or `CommandHandler<REQ,RES>`). |
| **Command Hook** | T | Before/after/error callback around command execution (e.g. username, timestamp). |
| **Compatibility** | A | Quality goal: stable REST contracts despite internal migration. → [07](07_quality_attributes.md) |
| **Conformist (CF)** | A | DDD context map: downstream largely adopts the upstream model unchanged. → [10](10_domain_context_map.md) |
| **Context Map** | A | DDD: map of bounded contexts and their integration relationships (U/D, OHS, ACL, …). → [10](10_domain_context_map.md) |
| **Core Domain** | A | DDD: strategically differentiating part of the domain (here mainly loan servicing, savings). → [10](10_domain_context_map.md) |
| **Correlation-ID** | B/T | Cross-request trace ID (header e.g. `X-Correlation-ID`) for logs and support. → [06](06_crosscutting_concepts.md) |
| **Customer/Supplier (C/S)** | A | DDD context map: downstream is customer of the upstream (explicit supply relationship). → [10](10_domain_context_map.md) |
| **Clean Code** | A | Practices for readable, testable, maintainable code (names, small units, Boy Scout, SOLID orientation). → [ADR-018](decisions/ADR-018-clean-code.md) |
| **CQRS** | A/T | *Command Query Responsibility Segregation* – separation of write and read paths. → [06](06_crosscutting_concepts.md), [08](08_design_decisions.md) |

---

## 9.2 D–F

| Term | Tag | Definition |
|------|:---:|------------|
| **DataSource Routing** | T | Selection of the JDBC connection based on the current tenant context. |
| **Defense in Depth** | A | Multi-layered security (TLS/proxy, AuthN/Z, tenant, audit). → [08](08_design_decisions.md) |
| **Degradation** | A | Controlled continuation without optional feature (e.g. AI bundle missing). → [04](04_runtime_view.md) |
| **Deployable** | B | Runtime artifact (container image, JAR, bundle) rolled out on infrastructure. → [05](05_deployment_view.md) |
| **Domain-Driven Design (DDD)** | A | Domain modeling with bounded contexts, aggregates, ubiquitous language, and domain events. → [ADR-019](decisions/ADR-019-domain-driven-design.md) |
| **Disruptor** | T | LMAX Disruptor – optional high-performance, non-blocking command-dispatcher variant. |
| **Docker Compose** | B | Orchestration of local multi-container setups; reference files `docker/docker-compose*.yml`. → [05](05_deployment_view.md) |
| **DTO** | T | *Data Transfer Object* – typed payload between API, command, and domain (goal of the new command stack). |
| **DTO Composition** | A | Specialized API DTOs hold shared fields as component or flat copy instead of inheritance; wire JSON stays flat. → [ADR-015](decisions/ADR-015-api-dtos-composition-statt-vererbung.md) |
| **EclipseLink** | T | JPA provider in fineract-osgi (instead of Hibernate); static weaving, Spring `EclipseLinkJpaVendorAdapter`. → [ADR-016](decisions/ADR-016-jpa-ausbau-read-write-persistenz.md) |
| **Equinox** | T | Eclipse OSGi framework, intended as OSGi runtime in fineract-osgi. → [05](05_deployment_view.md), [08](08_design_decisions.md) |
| **Event Catalog** | A | Inventory of Business Event TYPEs and mapping to domain/ES events. → [12](12_event_catalog.md) |
| **Event Sourcing** | A | Persistence pattern: state as append-only sequence of domain events; mandatory for domain writes. → [ADR-020](decisions/ADR-020-event-sourcing-writes-pflicht.md) |
| **Event Store** | T | Append-only store of aggregate event streams (write source of truth). → [ADR-020](decisions/ADR-020-event-sourcing-writes-pflicht.md) |
| **External Event** | T | Event published for systems outside the process (Kafka/JMS). Catalog: [12](12_event_catalog.md). |
| **External Event Configuration** | T | Table `m_external_event_configuration`: every concrete `BusinessEvent` type (except `NoExternalEvent`) must be registered at boot, otherwise the app does not start. → [12.9](12_event_catalog.md#129-pflicht-external-event-konfiguration-in-der-db), [06.6](06_crosscutting_concepts.md) |
| **Fail-Closed** | A | On error/timeout of the downstream (e.g. AI) the operation is **rejected**. → [06](06_crosscutting_concepts.md) |
| **Fail-Open** | A | On error/timeout the core operation **continues** (default for async AI). → [08](08_design_decisions.md) |
| **Flatten (API JSON)** | T | Serialization of composed DTOs so that shared and specialized fields appear at root level (Gson/Jackson), without breaking change. → [ADR-015](decisions/ADR-015-api-dtos-composition-statt-vererbung.md) |
| **FineractGsonTypeAdapterRegistrar** | T | SPI interface in `fineract-core`; modules register Gson TypeAdapter via `ServiceLoader` in `GoogleGsonSerializerHelper`. → [06.13](06_crosscutting_concepts.md) |
| **Feature Bundle** | T | OSGi **impl** bundle with optional domain/integration function (AI, product rules, …). Informal name only — integration is via the **Service Registry**, not Apache Karaf Features. → [ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md) |
| **Fragment-Host** | T | OSGi manifest header: a fragment bundle attaches to a host (typically `*-impl`) and shares its classloader; used for test bundles. → [15](15_osgi_bundle_refactoring.md) |
| **fineract-command** | T | Module for the modern, type-safe command stack parallel to the legacy pipeline. |
| **fineract-osgi** | A | This workstream/fork: Fineract core + OSGi modularity + AI extensibility. → [01](01_introduction.md) |
| **fineract-provider** | T | Main application module (boot, REST, wiring of domain modules). |
| **fineract_tenants** | T | Registry database/schema with tenant metadata and connection info. → [05](05_deployment_view.md) |

---

## 9.3 G–L

| Term | Tag | Definition |
|------|:---:|------------|
| **Generic Subdomain** | A | DDD: replaceable/standardizable domain (IAM, documents, validation, …). → [10](10_domain_context_map.md) |
| **Gherkin** | A | BDD notation (Given/When/Then); requirement artifacts under [`docs/gherkin/`](../gherkin/README.md), tagged with `@arc42-*` / `@adr-*` / `@quality-Q-*`. → [08](08_design_decisions.md) |
| **HikariCP** | T | JDBC connection pool of Fineract; configuration via `FINERACT_HIKARI_*`. |
| **Hook** | T | Configurable integration/webhook on business events; also command hooks in the new stack. |
| **Hexagonal Architecture** | A | *Ports & Adapters* – domain in the center, driving/driven adapters at the edge; guiding model for fineract-osgi. → [ADR-017](decisions/ADR-017-hexagonale-architektur.md) |
| **Hot-Deploy** | B | Reload/update of OSGi bundles without full app rebuild. |
| **Hot-Path** | A | Latency-critical request path (typically synchronous writes) – AI by default **not** sync on it. → [07](07_quality_attributes.md) |
| **Idempotency Key** | T | Client-side key that deduplicates retries of the same write. → [06](06_crosscutting_concepts.md) |
| **IdP** | T | *Identity Provider* – external authentication source (OIDC). |
| **Jakarta Validation** | T | Bean Validation annotation model for DTO constraints in the new command stack. |
| **Job Partition** | B/T | Subset of COB/batch work that a worker takes on. |
| **JsonCommand** | T | Legacy command payload as parsed JSON with string keys. |
| **JWT** | T | *JSON Web Token* – often carrier of the OIDC/OAuth2 identity. |
| **Kubernetes (K8s)** | B | Container orchestration; sample manifests under `kubernetes/`. → [05](05_deployment_view.md) |
| **Legacy Command Pipeline** | T | Previous write path via `PortfolioCommandSourceWritePlatformService` / `SynchronousCommandProcessingService`. |
| **Liquibase** | T | Schema migration tool; typically active only on leading/manager node, workers often disabled. |
| **Loan Application** | F | Loan application/account in the portfolio module; central runtime example. → [04](04_runtime_view.md) |
| **Liveness / Readiness** | B | Health probes: process is alive or may receive traffic. |

---

## 9.4 M–O

| Term | Tag | Definition |
|------|:---:|------------|
| **Maker-Checker** | F | Four-eyes principle: command waits for approval before domain persistence is finalized. → [06](06_crosscutting_concepts.md) |
| **MDC** | T | *Mapped Diagnostic Context* – contextual log fields (tenant, Correlation-ID, …). |
| **Mode Flags** | B | Switches `fineract.mode.read/write/batch-*-enabled` for role control of a node. → [05](05_deployment_view.md) |
| **Module API** | A | Published port surface of a Gradle domain module (`..moduleapi..`); only allowed domain dependency for other modules. ≠ REST `..api..`. → [ADR-021](decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md), [14](14_module_api_boundaries.md) |
| **Multi-Tenancy** | A/F | One deployment serves many institutions (tenants) with isolated data/contexts. → [06](06_crosscutting_concepts.md) |
| **Node ID** | B | `FINERACT_NODE_ID` – unique identifier of an instance in the cluster. |
| **Observability** | B | Ability to recognize state via logs, metrics, and traces. → [06](06_crosscutting_concepts.md), [07](07_quality_attributes.md) |
| **OIDC** | T | *OpenID Connect* – authentication protocol on OAuth2; in Fineract configurable per tenant. |
| **Open Host Service (OHS)** | A | DDD context map: upstream offers a stable API/events for multiple downstream consumers. → [10](10_domain_context_map.md) |
| **OpenAPI** | T | Specification of the REST API; basis for `fineract-client` and contract tests. |
| **Operability** | A | Quality goal: operability, diagnosis, deploy. → [07](07_quality_attributes.md) |
| **OSGi** | T | *Open Services Gateway initiative* – modularity and service framework standard. → [08](08_design_decisions.md), [ADR-002](decisions/ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md) |
| **OSGi api / impl / test** | A | Bundle split: contract bundle, implementation bundle, test fragment. → [ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md), [15](15_osgi_bundle_refactoring.md) |
| **OSGi Service Registry** | T | Runtime directory in which bundles publish and consume services; **only** allowed inter-bundle access path for module ports (not Karaf Features). → [06.7](06_crosscutting_concepts.md), [ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md) |
| **OTLP** | T | *OpenTelemetry Protocol* – export of traces/metrics (e.g. to Tempo). |
| **Outbox Pattern** | T | Reliable publishing of events via a DB table + dispatcher (open point). → [06](06_crosscutting_concepts.md) |

---

## 9.5 P–S

| Term | Tag | Definition |
|------|:---:|------------|
| **Permission** | F | Fine-grained right assigned to roles and checked before commands. |
| **Platform Security Context** | T | Runtime context of the current user and their rights. |
| **Policy Gate** | A | Synchronous decision point (e.g. AI score) before continuing a command. → [04](04_runtime_view.md) |
| **Port (Hexagon)** | A | Domain interface between application/domain and adapter (not a TCP port). → [ADR-017](decisions/ADR-017-hexagonale-architektur.md) |
| **PostgreSQL** | B | Primary target database in the fineract-osgi reference architecture. → [08](08_design_decisions.md) |
| **Published Language (PL)** | A | DDD: shared integration vocabulary between contexts (events, commands, DTOs/Avro). → [10](10_domain_context_map.md) |
| **Quality Scenario** | A | Measurable quality scenario (stimulus, environment, response, measure). → [07](07_quality_attributes.md) |
| **Read Node** | B | Instance with `read-enabled` (and typically without write/batch), for queries/reports. |
| **Remote Job Message Handler** | T | Mechanism for distributing job work (Spring Events, JMS, or Kafka). |
| **Reverse Proxy / WAF** | B | Recommended layer in front of the API (TLS termination, DDoS, routing). → [`SECURITY.md`](../../SECURITY.md) |
| **RPO / RTO** | B | *Recovery Point/Time Objective* – maximum tolerated data loss or recovery time. → [07](07_quality_attributes.md) |
| **Runtime View** | A | arc42 view of dynamic flows and scenarios. → [04](04_runtime_view.md) |
| **SACCO** | F | *Savings and Credit Cooperative* – typical user group in the microfinance context. → [02](02_context_and_scope.md) |
| **Service Tracker** | T | OSGi helper for tracking service availability (bind/unbind). |
| **SLO** | B | *Service Level Objective* – targeted operational metric (latency, availability). → [07](07_quality_attributes.md) |
| **Shared Kernel (SK)** | A | DDD: jointly used types in `fineract-core`. As-is leftover (`~802` types) **is** the kernel; **growth** stays narrow (no new business aggregates in core). → [10](10_domain_context_map.md), [ADR-021](decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md), [core slices](15_osgi_bundle_refactoring_fineract-core-slices.md) |
| **Spring Boot** | T | Application framework of the Fineract core; retained per ADR-003. → [08](08_design_decisions.md) |
| **Spring Events** | T | In-process events; default for local job distribution without broker. |
| **Supporting Subdomain** | A | DDD: needed for operation, but not the strategic core (Client, Accounting, Products, COB, …). → [10](10_domain_context_map.md) |
| **SynchronousCommandProcessingService** | T | Central legacy component for synchronous command execution. |

---

## 9.6 T–Z

| Term | Tag | Definition |
|------|:---:|------------|
| **Tenant** | F | Logical institution/mandator with its own domain database and configuration. |
| **Tenant Context** | T | Thread/request-bound tenant information (ID, DS, timezone, user, business date). |
| **ThreadLocalContext** | T | Holder of the tenant/request context; must be cleared after request/job. → [06](06_crosscutting_concepts.md) |
| **Trust Boundary** | A | Boundary between trusted and untrusted (primarily HTTPS API). → [`SECURITY.md`](../../SECURITY.md) |
| **Two-Factor (2FA)** | T | Second authentication step (OTP etc.) in addition to password/OIDC. |
| **Ubiquitous Language** | A | Shared domain language in code, API, Gherkin, and docs. → [ADR-019](decisions/ADR-019-domain-driven-design.md) |
| **Upstream / Downstream (U/D)** | A | DDD context map: downstream depends on the model/API of the upstream. → [10](10_domain_context_map.md) |
| **Write Node** | B | Instance with `write-enabled` for CQRS commands. |
| **xAI Grok API** | T | External AI inference API; reference integration for scoring/analysis bundles. → [06](06_crosscutting_concepts.md), [08](08_design_decisions.md) |

---

## 9.7 Modules & Artifacts (Repo Orientation)

| Name | Short description |
|------|-------------------|
| `fineract-provider` | Bootable server, REST, wiring |
| `fineract-core` | Shared kernel (platform + accepted hub / fund-style residual). Do not full api/impl; do not peel leftovers. |
| `fineract-command` | New command stack |
| `fineract-command-async` / `-disruptor` / `-jdbc` / `-audit` | Optional command implementation variants |
| `fineract-loan` / `fineract-savings` / `fineract-accounting` / … | Domain modules |
| `fineract-security` | AuthN/Z, tenant filters, OIDC, 2FA |
| `fineract-validation` | Validation support |
| `fineract-cob` | COB-related components (where extracted) |
| `fineract-client` / `fineract-client-feign` | Generated/API clients |
| `docs/arc42/` | This architecture documentation |
| `docs/gherkin/` | BDD features incl. mapping to arc42 ([README](../gherkin/README.md)) |
| `osgi/` | Equinox start, `config.ini`, bundles, logs |
| `config/docker/` | Compose building blocks, env files, observability |
| `kubernetes/` | Sample manifests and start scripts |
| `SECURITY.md` | Threat model (upstream basis) |

---

## 9.8 Configuration and Environment Variables (Selection)

| Variable / Property | Meaning |
|---------------------|---------|
| `FINERACT_NODE_ID` | Unique node identifier |
| `FINERACT_MODE_READ_ENABLED` | Read API active |
| `FINERACT_MODE_WRITE_ENABLED` | Write/Command API active |
| `FINERACT_MODE_BATCH_MANAGER_ENABLED` | Batch orchestration active |
| `FINERACT_MODE_BATCH_WORKER_ENABLED` | Batch execution active |
| `FINERACT_HIKARI_*` | JDBC pool and datasource |
| `FINERACT_DEFAULT_TENANTDB_*` | Default tenant DB parameters |
| `FINERACT_LIQUIBASE_ENABLED` | Schema migration on/off (workers often `false`) |
| `LOAN_COB_CHUNK_SIZE` / `PARTITION_SIZE` / `POLL_INTERVAL` | COB throughput tuning |
| `FINERACT_REMOTE_JOB_MESSAGE_HANDLER_*` | Spring Events / JMS / Kafka for jobs |
| `FINERACT_EXTERNAL_EVENTS_*` | External event publisher |
| `FINERACT_LOGGING_HTTP_CORRELATION_ID_*` / `fineract.correlation.*` | Correlation-ID |
| `FINERACT_MANAGEMENT_PROMETHEUS_ENABLED` | Prometheus metrics |
| `FINERACT_MANAGEMENT_OLTP_*` | OTLP export |
| `FINERACT_SERVER_SSL_ENABLED` | HTTPS in the server |

Full lists: `fineract-provider/.../application.properties`, `config/docker/env/`.

---

## 9.9 Ports (Reference)

| Port | Use |
|-----:|-----|
| **8443** | HTTPS REST + Actuator |
| **5432** | PostgreSQL |
| **3306** | MySQL/MariaDB (alternative/examples) |
| **9092** | Kafka |
| **61616** | ActiveMQ (JMS) |
| **2501** | Equinox Console (admin network only) |
| **5000** | JDWP debug (dev only) |
| **4318** | OTLP HTTP (Tempo or similar) |

→ Details: [05 Deployment View](05_deployment_view.md)

---

## 9.10 Abbreviations (Quick Reference)

| Abbr. | Long form |
|-------|-----------|
| ADR | Architecture Decision Record |
| API | Application Programming Interface |
| BDD | Behavior-Driven Development |
| COB | Close of Business |
| CQRS | Command Query Responsibility Segregation |
| DB | Database |
| DTO | Data Transfer Object |
| HA | High Availability |
| JMS | Java Message Service |
| JWT | JSON Web Token |
| K8s | Kubernetes |
| AI | Artificial Intelligence (German: KI) |
| LB | Load Balancer |
| MDC | Mapped Diagnostic Context |
| ML | Machine Learning |
| MTTD / MTTR | Mean Time To Detect / Recover |
| NFR | Non-Functional Requirement |
| OIDC | OpenID Connect |
| OSGi | Open Services Gateway initiative |
| OTLP | OpenTelemetry Protocol |
| PII | Personally Identifiable Information |
| RPO / RTO | Recovery Point / Time Objective |
| SLA / SLO | Service Level Agreement / Objective |
| TLS | Transport Layer Security |
| UI | User Interface |
| WAF | Web Application Firewall |
| 2FA | Two-Factor Authentication |

---

## 9.11 Conceptual Distinctions

| Do not confuse | Difference |
|----------------|------------|
| **Command** vs. **Business Event** | Command = intentional write instruction; Event = fact after change |
| **Bundle** vs. **Gradle module** | Module = build time; Bundle = OSGi runtime artifact |
| **Tenant DB** vs. **fineract_tenants** | Domain data vs. registry/metadata |
| **Batch Manager** vs. **Worker** | Orchestration vs. execution |
| **Hook (Fineract)** vs. **Command Hook** | External/business integration vs. pipeline interceptor in the new stack |
| **Fail-Open** vs. **Degradation** | Error policy for downstream vs. missing optional component |
| **Read Node** vs. **Read-only Tenant DB** | App role vs. DB connection type |
| **Sync AI Policy Gate** vs. **Async Enrichment** | blocks command vs. enriches afterward |

---

## 9.12 Maintaining the Glossary

- Add new ADR or runtime terms here in the matching alphabetical group.  
- Keep abbreviations in 9.10 and full definitions in 9.1–9.6 consistent.  
- On renames in code (classes/env), briefly mention both spellings.  
- Do not unnecessarily translate English upstream terms when the code is English.

---

*Back*: [08 Design Decisions](08_design_decisions.md) · *Overview*: [README](README.md)
