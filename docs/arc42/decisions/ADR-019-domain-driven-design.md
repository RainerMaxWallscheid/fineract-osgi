# ADR-019 – Domain-Driven Design (DDD)

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Maintainability, Correctness, Extensibility, Compatibility |

### Kontext

fineract-osgi bildet **Core Banking** ab: Loans, Savings/Deposits, Accounting, Clients, COB, Multi-Tenancy. Die Fachsprache und die Modulgrenzen (Gradle: `fineract-loan`, `fineract-savings`, `fineract-accounting`, …) entsprechen bereits grob **Bounded Contexts**, ohne dass DDD bisher explizit als Leitbild dokumentiert war.

Gleichzeitig gelten:

- **CQRS** und Command-Pipelines ([ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md)),
- **hexagonales** Leitbild ([ADR-017](ADR-017-hexagonale-architektur.md)),
- **JPA-Writes / JDBC-Reads** ([ADR-016](ADR-016-jpa-ausbau-read-write-persistenz.md)),
- **Clean Code** ([ADR-018](ADR-018-clean-code.md)).

Ohne DDD-Vokabular bleiben Aggregatgrenzen, Ubiquitous Language und Context-Maps implizit – Reviews und Migrationen werden uneinheitlich.

### Entscheidung

**Domain-Driven Design** (taktisch + strategisch, pragmatisch) ist Leitbild für die **fachliche Modellierung** in fineract-osgi. Es ergänzt Hexagon (Struktur der Abhängigkeiten) und CQRS (Schreib-/Lesepfade) – **kein** Big-Bang-Event-Sourcing und kein erzwungenes „reines“ DDD-Package-Layout.

#### Strategisches DDD

| Konzept | fineract-osgi |
|---------|----------------|
| **Bounded Context** | Gradle-/Domain-Module und klare API-Oberflächen: Loan, Savings/Deposit, Accounting, Client/Organisation, COB, Security/Tenant, Command |
| **Ubiquitous Language** | Fachbegriffe in Code, Commands, Gherkin, arc42 (Loan Application, Disbursement, Journal Entry, Maturity, Tenant, …) |
| **Context Map** | Integration über Commands, Domain/Business Events, Hooks, GL-Mappings, Account Associations – nicht über freies Entity-Sharing über Modulgrenzen |
| **Anti-Corruption Layer** | Adapter zu externer KI, Payment/Interop, Import/Bulk, Legacy-JSON (`JsonCommand`) → typsichere Commands/DTOs |
| **Shared Kernel (eng)** | `fineract-core` Infrastruktur + wenige echte Shared-Konzepte (Money/Currency, Office, Permissions) – bewusst klein halten |

```mermaid
flowchart LR
    subgraph Contexts
      L[Loan BC]
      S[Savings / Deposit BC]
      A[Accounting BC]
      C[Client / Org BC]
    end
    L -->|journal / charges| A
    S -->|journal| A
    C -->|owns accounts| L
    C --> S
    L -.->|events / associations| S
    KI[KI Adapter ACL] -.-> L
```

#### Taktisches DDD

| Baustein | Bedeutung in fineract-osgi | Beispiele |
|----------|----------------------------|-----------|
| **Entity** | Identität über Lebenszyklus | `Loan`, `SavingsAccount`, `Client`, `GLAccount` |
| **Value Object** | Gleichheit über Werte; oft immutable | Money/Currency, Enums mit Converter, Datumsperioden |
| **Aggregate** | Konsistenzgrenze; Write über Root | Loan (+ transactions/charges im Use Case), SavingsAccount, Client |
| **Repository** | Persistenz-Port des Aggregates | Spring Data `*Repository` / Wrapper ([ADR-016](ADR-016-jpa-ausbau-read-write-persistenz.md)) |
| **Domain Service** | Fachlogik über mehrere Entities ohne natürliche Root-Heimat | Zinsberechnung, Accounting-Processor, Transfer-Domain |
| **Application Service** | Use-Case-Orchestrierung, TX-Grenze | Command Handler, WritePlatformService |
| **Domain / Business Event** | Tatsache nach erfolgreicher Änderung | Loan created, Account activated; Hooks / External Events |
| **Factory** | Komplexes Erzeugen von Aggregates | Application-Submit, Product-Instanziierung |

#### Mapping Hexagon ↔ DDD

| Hexagon | DDD |
|---------|-----|
| Domain Ring | Entities, VOs, Aggregates, Domain Services, Domain Events |
| Application Ring | Application Services, Command Handlers, Use Cases |
| Ports | Repository-Interfaces, Event-Publisher, externe Policy-Ports |
| Driving Adapters | REST, COB/Batch, OSGi-Eingänge |
| Driven Adapters | JPA, JDBC-Reads, Kafka/JMS, KI-HTTP, Document Store |

#### Regeln für neuen / angefassten Code

1. **Aggregatgrenze respektieren** – Writes ändern ein Aggregat pro Transaktion wo möglich; Querschnitte über Domain Services + klare Reihenfolge (z. B. Loan dann Accounting).  
2. **Sprache angleichen** – Klassennamen, Commands, Gherkin und API-Doku dieselbe Fachsprache.  
3. **Kein Anemic-Zwang** – Verhalten an Aggregates/Domain Services, nicht nur Setter-Entities + God-Service (Evolution, Boy Scout).  
4. **Context-Grenzen** – kein wildes Importieren von Loan-Entities in fremde Module; Integration über IDs, Events, Application-APIs.  
5. **Read-Modelle** – Queries dürfen den Write-Aggregate nicht aufblasen (CQRS); ReadPlatform / Projections sind eigene Modelle.  
6. **Legacy** – `JsonCommand` und anämische Stellen: bei Berührung verbessern, nicht Big-Bang-remodeln.

#### Evolutionsstufen

| Stufe | Inhalt |
|-------|--------|
| **D1** | Vokabular + dieses ADR; Context-Map in Doku |
| **D2** | Neue Features mit klarem Aggregate/Command/Event |
| **D3** | Aggregatgrenzen und Domain Services an Hotspots schärfen (Loan, Savings, Accounting) |
| **D4** | Context-Map + ACL für Interop/KI/Import standardisieren |

### Alternativen

| Option | Bewertung |
|--------|-----------|
| Nur technische Schichten ohne DDD | Fachliche Grenzen bleiben implizit |
| Event Sourcing als Default | Abgelehnt/deferred; Double-Entry bleibt relational |
| Microservices pro Bounded Context sofort | Zu teuer; Hexagon/Module reichen zuerst |
| Striktes DDD-Framework (z. B. erzwungene Base-Klassen) | Overhead; Fineract-Patterns reichen |

### Konsequenzen

- **+** Gemeinsame Fach- und Modellsprache für Teams und Agenten  
- **+** Passt zu CQRS, Hexagon, JPA-Write/JDBC-Read, Clean Code  
- **+** Bessere Review-Fragen: „Welches Aggregat? Welcher Context?“  
- **−** Bestand oft anämisch / service-lastig – Migration inkrementell  
- **−** Risiko übermodellierter Aggregates – Pragmatismus und Performance (COB) beachten  

### Non-Goals

- Event Sourcing oder CQRS-pur mit separatem Event Store als Pflicht  
- Umbenennen aller Packages nach `domain`/`application` in einem Schritt  
- Ein Aggregat für „das ganze Portfolio“  
- Ersetzen von Accounting-Double-Entry durch „reine“ Domain-Events ohne Journal  

### Bezug

- [ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md) CQRS  
- [ADR-016](ADR-016-jpa-ausbau-read-write-persistenz.md) Persistenz  
- [ADR-017](ADR-017-hexagonale-architektur.md) Hexagon  
- [ADR-018](ADR-018-clean-code.md) Clean Code / Ubiquitous Language  
- Building Blocks [03](../03_building_block_view.md) · Runtime [04](../04_runtime_view.md) · Crosscutting [06](../06_crosscutting_concepts.md)

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
