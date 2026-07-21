# ADR-016 – JPA Expansion and Read/Write Persistence

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Maintainability, Performance, Reliability, Compatibility |

### Context

fineract-osgi already uses:

- **Spring Data JPA** as the repository API (`JpaRepository`, specs, auditing),
- **EclipseLink 4.x** as the JPA provider (Hibernate excluded, static weaving),
- **RoutingDataSource** for multi-tenancy (one EMF, tenant via JDBC routing),
- **JdbcTemplate + RowMapper** for a large share of **ReadPlatformServices** (lists, reports, partial SQL).

This is not a pure JPA system but a **hybrid**: writes/domain often JPA, heavy reads often SQL. Expansion without guardrails risks either “everything to JPA” (risk for COB/reports) or further growing JDBC/wrapper sprawl.

Already present and to be used:

- `JPAConfig` / `EclipseLinkJpaVendorAdapter`, `ExtendedJpaTransactionManager`
- `EntityManagerFactoryCustomizer` (extra packages, vendor properties, post-processors)
- Repository-wrapper pattern, occasional criteria/specs (e.g. client search)

### Decision

#### Persistence cut (CQRS-aligned)

| Path | Technology | Responsibility |
|------|------------|----------------|
| **Write / domain (target)** | **Event sourcing** ([ADR-020](ADR-020-event-sourcing-writes-pflicht.md)) | Append-only event store; aggregates decide events |
| **Write / domain (transition)** | Spring Data JPA + EclipseLink | Legacy state until aggregate cutover; no new state-only without an event plan |
| **Snapshots / materialized state** | JPA or SQL tables | Derived from events; performance |
| **Simple reads** | JPA projection / specs / EntityGraph / projector tables | Lookup, small lists, filter APIs |
| **Complex reads / reports / COB SQL / journal** | JdbcTemplate, SQL, possibly DB views | Performance; accounting double-entry relational |

The **read vs. write** hybrid remains; the **write source of truth** moves to events (mandatory in the target picture).

#### Provider and stack (fixed)

- **No** switch to Hibernate.
- Spring Data remains the **primary** programming interface; direct `EntityManager` use only in custom fragments/infrastructure.
- Multi-tenancy remains **RoutingDataSource + one EMF** (no EMF-per-tenant in this ADR).

#### Evolution stages (binding scope of this ADR)

| Stage | Scope | In scope | Examples |
|-------|--------|----------|----------|
| **S1 – Hygiene** | Repository API & readability | Specs, projections, targeted EntityGraphs/fetch joins, wrapper reduction, converters/embeddables | Client/loan lookups, filter APIs |
| **S2 – Performance** | EclipseLink tuning | JDBC batch writing, query hints (timeout, read-only, fetch size), **selective** L2 cache only for master data | COB bulk, codes/currency/permissions |

**S3+** (deeper module SPI, broad JDBC→projection migration, OSGi dynamic PU) are **roadmap**, but **not** deliverables of this ADR — separate follow-on cuts after review of S1/S2.

#### Concrete guardrails S1

1. New write paths: domain repositories in `**.domain` / `**.repository`; no SQL in REST resources.  
2. Dynamic filters: `JpaSpecificationExecutor` / criteria instead of growing string-SQL variants where domain-feasible.  
3. N+1: targeted `@EntityGraph` / fetch joins at measured hotspots — no global eager fetch.  
4. `RepositoryWrapper`: shared “findByIdOrThrow” semantics; no parallel exception patterns per module.  
5. Value objects/enums: expand `AttributeConverter` and embeddables (consistency with existing converters).

#### Concrete guardrails S2

1. Batch writing and hints only for **identified** bulk/job paths, with IT/measurement.  
2. L2 cache **not** enabled globally; only explicitly approved reference entities; check tenant safety.  
3. Keep static weaving; custom modules via `EntityManagerFactoryCustomizer`.  
4. Document EclipseLink JPQL peculiarities (CASE, unary minus, …) and do not “optimize away” existing workarounds without tests.

#### Non-Goals (explicit)

| Non-Goal | Rationale |
|----------|-----------|
| Migrating **all** ReadPlatformServices from JDBC to JPA | Reports/COB/partial SQL are often intentionally SQL |
| Provider switch to Hibernate | High risk, EclipseLink-specific code and weaving |
| **EMF per tenant** | Memory/startup; RoutingDataSource suffices for DB isolation |
| Global second-level cache | Stale data + multi-tenant |
| JPA as the sole **durable** write source of truth | Contradicts [ADR-020](ADR-020-event-sourcing-writes-pflicht.md); JPA remains for snapshots/reads/transition |
| Replacing Spring Batch / job SQL with JPA-only COB | Different load and isolation profiles |

### Alternatives

| Option | Assessment |
|--------|------------|
| All JDBC (abolish JPA) | Loses domain model, auditing, tx integration |
| All JPA (abolish JDBC) | Breaks heavy reads/COB; EclipseLink risks |
| Hibernate instead of EclipseLink | Rewrite without clear gain; non-goal |
| EMF per tenant | Strong isolation, too expensive as default |

### Consequences

- **+** Clear write/read cut; teams know when JPA vs. JDBC  
- **+** S1/S2 are reviewable and measurable, without architecture big-bang  
- **+** Uses existing Spring Data and EMF customizer SPI  
- **−** Two persistence styles remain (documentation and code-review discipline needed)  
- **−** S2 tuning is EclipseLink-specific (no “portable default” without tests)  
- **−** Projection migration of individual reads needs API parity tests (flat JSON, partial response)

### Implementation notes

| Artifact | Role |
|----------|------|
| `JPAConfig` | EMF, packages, EclipseLink adapter |
| `EntityManagerFactoryCustomizer` | Module extensions |
| `ExtendedJpaTransactionManager` | Tx, read-only mode, EclipseLink dialect |
| `*Repository` / `*RepositoryWrapper` | Write and lookup access |
| `*ReadPlatformServiceImpl` + `JdbcTemplate` | Complex reads (remain allowed) |

Recommended order: **S1 in 1–2 pilot modules** (e.g. Client + one loan lookup path) → metrics/N+1 → **S2 only at measured hotspots**.

### Related

- [ADR-003](ADR-003-spring-boot-gradle-module-als-kern-beibehalten.md) Spring Boot + modules  
- [ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md) CQRS / commands  
- [ADR-008](ADR-008-multi-tenancy-mit-getrennten-tenant-datenbanken.md) Multi-tenancy  
- [ADR-009](ADR-009-postgresql-als-primaere-datenbank-fuer-fineract-osgi.md) PostgreSQL  
- [ADR-020](ADR-020-event-sourcing-writes-pflicht.md) Event sourcing writes (mandatory)  
- Crosscutting data access: [06.12](../06_crosscutting_concepts.md) · Quality maintainability/perf: [07](../07_quality_attributes.md)

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
