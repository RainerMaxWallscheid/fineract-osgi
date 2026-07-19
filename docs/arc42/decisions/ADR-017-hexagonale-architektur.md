# ADR-017 – Hexagonale Architektur (Ports & Adapters)

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Maintainability, Extensibility, Testability, Compatibility |

### Kontext

fineract-osgi ist ein **modularer Monolith** (Spring Boot + Gradle-Module, optional OSGi-Bundles) mit **CQRS** (Command-Pipeline, ReadPlatformServices) und klaren Integrationsrändern (REST, JDBC/JPA, Events, KI, Messaging).

Historisch dominiert eine **Schichten-/Modulstruktur** (Resource → Command → WritePlatformService → Repository/JDBC), nicht ein reines Hexagon mit expliziten Port-Interfaces in jedem Package. Gleichzeitig wachsen Anforderungen an:

- austauschbare **Driven**-Technik (EclipseLink/JPA vs. JDBC, Kafka vs. Spring Events, externe KI),
- **Driving**-Eingänge (REST, Batch/COB, künftig OSGi-Commands),
- testbare Domain ohne Tomcat/DB,
- OSGi-Feature-Bundles ohne Core-Fork ([ADR-002](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md)).

Ohne gemeinsames Vokabular drohen ad-hoc-Schichten und „alles darf alles importieren“.

### Entscheidung

**Hexagonale Architektur (Ports & Adapters) als Leitbild und Evolutionsrichtung** für fineract-osgi – **pragmatisch auf den bestehenden Stack gemappt**, kein Big-Bang-Rewrite in Package-Struktur „hexagon/“.

#### Kernprinzipien

1. **Domain im Zentrum** – Invarianten, Aggregates, fachliche Services; keine JAX-RS-, Servlet- oder Broker-APIs in der Domain.  
2. **Application / Use-Case-Ring** – Orchestrierung eines Use Cases (Command Handler, Application Services); kennt Ports, nicht konkrete Adapter.  
3. **Driving Adapters (inbound)** – stoßen Use Cases an: REST Resources, COB/Job-Steps, OSGi-Kommandos, (künftig) Message-Consumer.  
4. **Driven Adapters (outbound)** – implementieren Technik: JPA/JDBC, Hooks, Kafka/JMS, Dateispeicher, KI-HTTP-Client.  
5. **Ports** – fachlich benannte Schnittstellen (Java-Interfaces oder stabile Module-APIs); Adapter sind austauschbar.

```mermaid
flowchart TB
    subgraph Driving["Driving Adapters"]
      REST[REST / JAX-RS]
      JOB[COB / Spring Batch]
      OSGiIn[OSGi Command / Extension]
    end

    subgraph App["Application"]
      CMD[Command Pipeline<br/>Legacy + fineract-command]
      UC[Use Cases / Handlers]
    end

    subgraph Domain["Domain"]
      AGG[Aggregates / Domain Services]
      INV[Invarianten]
    end

    subgraph Driven["Driven Adapters"]
      JPA[Spring Data JPA / EclipseLink]
      JDBC[JdbcTemplate Reads / Bulk]
      EVT[Events / Hooks]
      KI[KI HTTP Client]
      MQ[Kafka / JMS]
    end

    REST --> CMD
    JOB --> UC
    OSGiIn --> UC
    CMD --> UC
    UC --> AGG
    AGG --> INV
    UC --> JPA
    UC --> JDBC
    UC --> EVT
    UC --> KI
    UC --> MQ
```

#### Mapping auf fineract-osgi (Ist → Hexagon)

| Hexagon | fineract-osgi (heute / Ziel) |
|---------|------------------------------|
| **Driving: REST** | `*ApiResource`, Spring MVC/JAX-RS in `fineract-provider` und Domain-Modulen |
| **Driving: Batch** | Spring Batch COB Manager/Worker, Job-Tasklets |
| **Application** | `NewCommandSourceHandler` / `CommandHandler`, WritePlatformServices, Prefill/Validation |
| **Domain** | Entities, Domain Services, Business Rules in `fineract-loan`, `fineract-savings`, … |
| **Driven: Persistenz Write** | Spring Data JPA + EclipseLink ([ADR-016](ADR-016-jpa-ausbau-read-write-persistenz.md)) |
| **Driven: Persistenz Read** | JdbcTemplate ReadPlatformServices; künftig Projection an Ports |
| **Driven: Integration** | Hooks, External Events, Kafka/JMS, Document Store |
| **Driven: KI** | OSGi-/Modul-Adapter auf xAI Grok ([ADR-005](ADR-005-externe-ki-xai-grok-statt-embedded-ml.md)/[006](ADR-006-ki-default-asynchron-fail-open.md)) |
| **Port-Beispiele** | Repository-Interfaces, `CommandDispatcher`, `BusinessEventNotifier`, `FineractGsonTypeAdapterRegistrar`, `EntityManagerFactoryCustomizer`, Content-Store-APIs |

CQRS ([ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md)) **sitzt im Application-Ring**: Commands = Write-Use-Cases; Queries = Read-Use-Cases mit eigenen Driven-Adaptern (oft JDBC).

#### Regeln für neue / migrierte Codepfade

| Regel | Bedeutung |
|-------|-----------|
| **Dependency Rule** | Domain hängt nicht von REST, Jersey, Kafka, EclipseLink-API ab |
| **Adapter dünn** | Resources mappen HTTP ↔ Command/DTO; keine Fachlogik in Resources |
| **Ports an Modulgrenzen** | Öffentliche Interfaces in stabilen Packages; Impl in Adapter-/Infra-Paketen |
| **OSGi = steckbare Adapter** | Feature-Bundles liefern Driven- oder optionale Driving-Adapter über Service Registry |
| **Tests** | Domain/Application mit Fake-Ports; Adapter mit IT (DB, Broker) |
| **Keine Pseudo-Ports** | Interfaces nur wo echte Austauschbarkeit/Testnaht nötig ist |

#### Evolutionsstufen (kein Big-Bang)

| Stufe | Inhalt |
|-------|--------|
| **E1 – Vokabular & Doku** | Dieses ADR; Mapping in Building Block / Crosscutting |
| **E2 – Neue Features** | Neue Module/Commands hexagon-konform (Resource → Handler → Domain → Port) |
| **E3 – Gezielte Extraktion** | Ports für Persistenz/Events/KI an Hotspots; Legacy schrittweise entkoppeln |
| **E4 – OSGi** | Bundles als Adapter-Deployables hinter denselben Ports |

### Alternativen

| Option | Bewertung |
|--------|-----------|
| Reines Layered Model beibehalten (ohne Hexagon-Vokabular) | Unzureichend für OSGi/KI/Testnähte |
| Clean Architecture streng (Use-Case-pro-Klasse, komplette Package-Umstellung) | Zu teuer; parallel zu Command-Migration |
| Microservices pro Domain | Abgelehnt/deferred ([08](../08_design_decisions.md) Großoptionen); Hexagon skaliert im Monolith |
| Nur Framework-„Hexagon“-Bibliothek erzwingen | Overhead; Fineract-Patterns reichen |

### Konsequenzen

- **+** Gemeinsame Sprache für Reviews, OSGi und KI-Ränder  
- **+** Passt zu CQRS, Command-Modernisierung und Persistenz-Hybrid (ADR-016)  
- **+** Testbarkeit: Domain ohne HTTP/DB-Adapter  
- **−** Bestandscode ist nicht überall hexagon-rein; Migration inkrementell  
- **−** Risiko „Interface-Theater“ – Ports nur mit klarem Nutzen  
- **−** Teams müssen Dependency-Richtung in Reviews durchsetzen  

### Non-Goals

- Sofortiges Umbenennen aller Packages nach `domain` / `application` / `adapter`  
- Ersetzen der Legacy-Command-Pipeline in einem Schritt  
- Pflicht zu Hexagon-Frameworks oder DI-Containern jenseits Spring/OSGi  

### Bezug

- [ADR-002](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md) OSGi  
- [ADR-003](ADR-003-spring-boot-gradle-module-als-kern-beibehalten.md) Spring Boot Kern  
- [ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md) CQRS  
- [ADR-005](ADR-005-externe-ki-xai-grok-statt-embedded-ml.md) / [ADR-006](ADR-006-ki-default-asynchron-fail-open.md) KI als Driven Adapter  
- [ADR-016](ADR-016-jpa-ausbau-read-write-persistenz.md) Persistenz-Ports (JPA vs. JDBC)  
- Building Blocks [03](../03_building_block_view.md) · Runtime [04](../04_runtime_view.md) · Crosscutting [06](../06_crosscutting_concepts.md)

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
