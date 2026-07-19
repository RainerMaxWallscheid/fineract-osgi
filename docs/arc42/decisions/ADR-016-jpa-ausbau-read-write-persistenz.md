# ADR-016 – JPA-Ausbau und Read/Write-Persistenz

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Maintainability, Performance, Reliability, Compatibility |

### Kontext

fineract-osgi nutzt bereits:

- **Spring Data JPA** als Repository-API (`JpaRepository`, Specs, Auditing),
- **EclipseLink 4.x** als JPA-Provider (Hibernate ausgeschlossen, Static Weaving),
- **RoutingDataSource** für Multi-Tenancy (eine EMF, Tenant über JDBC-Routing),
- **JdbcTemplate + RowMapper** für einen großen Teil der **ReadPlatformServices** (Listen, Reports, Partial SQL).

Das ist kein reines JPA-System, sondern ein **Hybrid**: Writes/Domain oft JPA, schwere Reads oft SQL. Ausbau ohne Leitplanken droht entweder „alles nach JPA“ (Risiko, COB/Reports) oder weiter wachsender JDBC-/Wrapper-Wildwuchs.

Bereits vorhanden und zu nutzen:

- `JPAConfig` / `EclipseLinkJpaVendorAdapter`, `ExtendedJpaTransactionManager`
- `EntityManagerFactoryCustomizer` (zusätzliche Packages, Vendor-Properties, Post-Processors)
- Repository-Wrapper-Pattern, vereinzelt Criteria/Specs (z. B. Client-Search)

### Entscheidung

#### Persistenz-Schnitt (CQRS-konform)

| Pfad | Technologie | Verantwortung |
|------|-------------|----------------|
| **Write / Domain (Ziel)** | **Event Sourcing** ([ADR-020](ADR-020-event-sourcing-writes-pflicht.md)) | Append-only Event Store; Aggregates entscheiden Events |
| **Write / Domain (Übergang)** | Spring Data JPA + EclipseLink | Legacy-State bis Aggregat-Cutover; kein neues State-only ohne Event-Plan |
| **Snapshots / materialisierter Zustand** | JPA oder SQL-Tabellen | Abgeleitet aus Events; Performance |
| **Einfache Reads** | JPA Projection / Specs / EntityGraph / Projector-Tabellen | Lookup, kleine Listen, Filter-APIs |
| **Komplexe Reads / Reports / COB-SQL / Journal** | JdbcTemplate, SQL, ggf. DB-Views | Performance; Accounting-Double-Entry relational |

Der Hybrid **Read vs. Write** bleibt; die **Write-Source-of-Truth** wandert zu Events (Pflicht im Zielbild).

#### Provider und Stack (fix)

- **Kein** Wechsel zu Hibernate.
- Spring Data bleibt die **primäre** Programmierschnittstelle; direkter `EntityManager`-Einsatz nur in Custom-Fragments/Infrastruktur.
- Multi-Tenancy bleibt **RoutingDataSource + eine EMF** (kein EMF-pro-Tenant in diesem ADR).

#### Ausbaustufen (verbindlicher Scope dieses ADR)

| Stufe | Scope | In Scope | Beispiele |
|-------|--------|----------|-----------|
| **S1 – Hygiene** | Repository-API & Lesbarkeit | Specs, Projections, gezielte EntityGraphs/Fetch-Joins, Wrapper-Reduktion, Converter/Embeddables | Client/Loan-Lookupups, Filter-APIs |
| **S2 – Performance** | EclipseLink-Tuning | JDBC batch-writing, Query-Hints (timeout, read-only, fetch-size), **selektiver** L2-Cache nur für Stammdaten | COB-Bulk, Codes/Currency/Permissions |

**S3+** (Modul-SPI-Vertiefung, breite JDBC→Projection-Migration, OSGi-dynamische PU) sind **Roadmap**, aber **nicht** Liefergegenstand dieses ADR — eigene Folgeschnitte nach Review von S1/S2.

#### Konkrete Leitplanken S1

1. Neue Write-Pfade: Domain-Repositories in `**.domain` / `**.repository`; keine SQL in REST-Resources.  
2. Dynamische Filter: `JpaSpecificationExecutor` / Criteria statt wachsender String-SQL-Varianten, wo fachlich möglich.  
3. N+1: gezielt `@EntityGraph` / fetch joins an gemessenen Hotspots — kein globales Eager-Fetch.  
4. `RepositoryWrapper`: gemeinsame „findByIdOrThrow“-Semantik; keine parallelen Exception-Muster pro Modul.  
5. Value Objects/Enums: `AttributeConverter` und Embeddables ausbauen (Konsistenz mit bestehenden Converters).

#### Konkrete Leitplanken S2

1. Batch-Writing und Hints nur für **identifizierte** Bulk-/Job-Pfade, mit IT/Messung.  
2. L2-Cache **nicht** global aktivieren; nur explizit freigegebene Referenz-Entities, Tenant-Safety prüfen.  
3. Static Weaving beibehalten; Custom-Module über `EntityManagerFactoryCustomizer`.  
4. EclipseLink-JPQL-Eigenheiten (CASE, Unary-Minus, …) dokumentieren und bestehende Workarounds nicht „wegoptimieren“ ohne Test.

#### Non-Goals (explizit)

| Non-Goal | Begründung |
|----------|------------|
| Migration **aller** ReadPlatformServices von JDBC nach JPA | Reports/COB/Partial-SQL sind oft bewusst SQL |
| Provider-Wechsel zu Hibernate | Hohes Risiko, EclipseLink-spezifischer Code und Weaving |
| **EMF pro Tenant** | Memory/Startup; RoutingDataSource reicht für Isolation der DB |
| Globaler Second-Level-Cache | Stale Data + Multi-Tenant |
| JPA als alleinige **dauerhafte** Write-Source-of-Truth | Widerspricht [ADR-020](ADR-020-event-sourcing-writes-pflicht.md); JPA bleibt für Snapshots/Reads/Übergang |
| Ersetzen von Spring Batch / Job-SQL durch JPA-only COB | Andere Last- und Isolation-Profile |

### Alternativen

| Option | Bewertung |
|--------|-----------|
| Alles JDBC (JPA abschaffen) | Verliert Domain-Modell, Auditing, Tx-Integration |
| Alles JPA (JDBC abschaffen) | Bricht schwere Reads/COB; EclipseLink-Risiken |
| Hibernate statt EclipseLink | Rewrite ohne klaren Gewinn; Non-Goal |
| EMF pro Tenant | Starke Isolation, zu teuer als Default |

### Konsequenzen

- **+** Klarer Schreib-/Leseschnitt; Teams wissen, wann JPA vs. JDBC  
- **+** S1/S2 sind reviewbar und messbar, ohne Architektur-Big-Bang  
- **+** Nutzt vorhandene Spring-Data- und EMF-Customizer-SPI  
- **−** Zwei Persistenzstile bleiben (Dokumentation und Code-Review-Disziplin nötig)  
- **−** S2-Tuning ist EclipseLink-spezifisch (kein „portable Default“ ohne Tests)  
- **−** Projection-Migration einzelner Reads braucht API-Paritäts-Tests (JSON flach, Partial Response)

### Umsetzungshinweise

| Artefakt | Rolle |
|----------|--------|
| `JPAConfig` | EMF, Packages, EclipseLink-Adapter |
| `EntityManagerFactoryCustomizer` | Modul-Erweiterungen |
| `ExtendedJpaTransactionManager` | Tx, Read-Only-Mode, EclipseLink-Dialect |
| `*Repository` / `*RepositoryWrapper` | Write- und Lookup-Zugriff |
| `*ReadPlatformServiceImpl` + `JdbcTemplate` | Komplexe Reads (bleiben erlaubt) |

Empfohlene Reihenfolge: **S1 in 1–2 Pilotmodulen** (z. B. Client + ein Loan-Lookup-Pfad) → Metriken/N+1 → **S2 nur an gemessenen Hotspots**.

### Bezug

- [ADR-003](ADR-003-spring-boot-gradle-module-als-kern-beibehalten.md) Spring Boot + Module  
- [ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md) CQRS / Commands  
- [ADR-008](ADR-008-multi-tenancy-mit-getrennten-tenant-datenbanken.md) Multi-Tenancy  
- [ADR-009](ADR-009-postgresql-als-primaere-datenbank-fuer-fineract-osgi.md) PostgreSQL  
- [ADR-020](ADR-020-event-sourcing-writes-pflicht.md) Event Sourcing Writes (Pflicht)  
- Crosscutting Data Access: [06.12](../06_crosscutting_concepts.md) · Quality Maintainability/Perf: [07](../07_quality_attributes.md)

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
