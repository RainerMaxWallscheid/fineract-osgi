# ADR-021 – Modul-Kommunikation nur über Module API

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Maintainability, Extensibility, Testability, Compatibility |
| **Bezieht sich auf** | [ADR-017](ADR-017-hexagonale-architektur.md), [ADR-019](ADR-019-domain-driven-design.md), [ADR-002](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md) |

### Kontext

fineract-osgi ist ein **modularer Monolith** (Gradle-Module ≈ Bounded Contexts). Heute greifen Module oft **direkt** auf fremde Internals zu:

- JPA-Entities (`Loan`, `Charge`, `GLAccount`, …)
- WritePlatformService-Implementierungen
- Handler, Repositories, Starter-Konfiguration

Das widerspricht Hexagon (Ports an Modulgrenzen) und DDD (keine freigeteilten Aggregates über Context-Grenzen). OSGi-Feature-Bundles brauchen dieselben **stabilen Ports**.

Gleichzeitig sind `..api..`-Packages historisch oft **REST-Driving-Adapters** (`*ApiResource`) – **nicht** die Modul-Public-API. Deshalb neuer, expliziter Name.

### Entscheidung

**Subprojekte (Domain-Module) kommunizieren untereinander nur über eine veröffentlichte Module API** – nicht über Domain-Entities, Service-Implementierungen oder REST-Resource-Klassen.

#### Namenskonvention

| Begriff | Package-Muster | Rolle |
|---------|----------------|--------|
| **Module API** | `..moduleapi..` | **Einzige** erlaubte fachliche Schnittstelle für *andere* Module (Ports, Commands/Queries als Interfaces, stabile DTOs/IDs) |
| **REST API** | `..api..` (historisch) | Driving Adapter HTTP – **nicht** für Modul-zu-Modul |
| **Intern** | `..domain..`, `..service..`, `..handler..`, `..starter..`, Repositories, Mapper-Impls | Nur modul-intern |
| **Shared Kernel** | bewusst eng in `fineract-core` | Money, Tenant, ExternalId, Permissions, Command-Metamodell – kein Business-Aggregate |

```text
┌─────────────────┐         moduleapi / Events          ┌─────────────────┐
│  fineract-loan  │ ──────────────────────────────────► │ fineract-charge │
│  domain/service │         (Ports, DTOs, IDs)          │  moduleapi      │
│  REST api       │                                     │  domain (hidden)│
└─────────────────┘                                     └─────────────────┘
```

#### Erlaubte Integrationsmittel zwischen Modulen

1. **Module API** (`..moduleapi..`) – Ports + stabile Transferobjekte  
2. **Domain / Business Events** (Published Language, siehe Event Catalog)  
3. **Shared Kernel** (eng)  
4. **Avro / External Event Schemas** für asynchrone Downstream-Integrationen  

#### Verboten (Ziel; Legacy per ArchUnit eingefroren)

- Import fremder `..domain..`-Entities  
- Aufruf fremder `*WritePlatformService`-/Repository-**Implementierungen**  
- Abhängigkeit von fremden REST-`..api..`-Resources oder `*JsonInputParams` aus REST-Paketen  
- „Utility“-Zugriff auf fremde `handler`/`starter`

#### Hexagon-Mapping

| Hexagon | Modul-Intern | Über Modulgrenze |
|---------|--------------|------------------|
| Domain | Aggregates, Invarianten | **nie** direkt exportiert |
| Application | Handlers, Use Cases | optional Ports in `moduleapi` |
| Ports | Interfaces in `moduleapi` | **ja** – das ist die Module API |
| Adapters | REST, JPA, Kafka, OSGi | REST nicht von fremden Modulen importieren |

#### Evolutionsstufen

| Stufe | Inhalt |
|-------|--------|
| **M1** | Dieses ADR + ArchUnit-Regeln mit Freeze-Baseline |
| **M2** | Pro Domain-Modul `moduleapi`-Package + `package-info`; neue Cross-Module-Features **nur** über Module API |
| **M3** | Hotspot-Ports extrahieren (z. B. Charge-Lookup, GL-Mapping, Client-Guard) und Freeze-Store schrumpfen |
| **M4** | Gradle `java-library` / getrennte `-api`-Artefakte oder OSGi Export-Packages = `moduleapi` only |

### Alternativen

| Option | Bewertung |
|--------|-----------|
| REST `..api..` als Modul-API missbrauchen | Verwechslung Driving Adapter ↔ Port; abgelehnt |
| Microservices pro Modul sofort | zu teuer; Module API skaliert im Monolith und zu OSGi |
| Alles in `fineract-core` teilen | Shared Kernel explodiert; abgelehnt |
| Nur Code-Review ohne ArchUnit | Regressionen unkontrolliert |

### Konsequenzen

- **+** Klare Context-Grenzen, bessere Testbarkeit, OSGi-ready Ports  
- **+** Passt zu Context Map, Event Catalog, Entity-ArchUnit-Regeln  
- **−** Bestand verletzt Regeln massiv → **FreezingArchRule** bis Strangler greift  
- **−** Teams müssen bei Cross-Module-Features zuerst Port in `moduleapi` definieren  

### Non-Goals

- Sofortiges Umbenennen aller REST-`api`-Packages  
- Big-Bang-Extraktion aller Service-Interfaces  
- Provider-Shell darf Module verdrahten (Composition Root) – sie ist kein Domain-Modul im Sinne der Regel  

### Durchsetzung

- ArchUnit: [`ModuleApiBoundaryRulesTest`](../../../fineract-architecture/src/test/java/org/apache/fineract/architecture/ModuleApiBoundaryRulesTest.java)  
- Doku: [13 ArchUnit](../13_archunit_bounded_context_rules.md), [14 Module API](../14_module_api_boundaries.md)  
- Freeze-Store: `fineract-architecture/src/test/resources/archunit_store/`

### Bezug

- [ADR-017 Hexagon](ADR-017-hexagonale-architektur.md) – Ports an Grenzen  
- [ADR-019 DDD](ADR-019-domain-driven-design.md) – Context Map ohne Entity-Sharing  
- [ADR-002 OSGi](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md) – exportierbare Contracts  
- [10 Context Map](../10_domain_context_map.md)

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
