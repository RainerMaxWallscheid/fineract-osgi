# ADR-018 – Clean Code als Entwicklungsleitbild

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Maintainability, Reliability, Testability, Compatibility |

### Kontext

fineract-osgi erbt einen **großen, historisch gewachsenen** Codebestand (Apache Fineract 1.x): lange Methoden, Magic Strings in `JsonCommand`, tiefe DTO-Vererbung, gemischte Persistenz (JPA/JDBC), parallele Command-Stacks. Gleichzeitig steigen die Anforderungen an:

- modulweise Modernisierung ([ADR-003](ADR-003-spring-boot-gradle-module-als-kern-beibehalten.md), [ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md)),
- lesbare API- und Domain-Grenzen ([ADR-015](ADR-015-api-dtos-composition-statt-vererbung.md), [ADR-017](ADR-017-hexagonale-architektur.md)),
- sichere Änderungen unter hoher Testlast (Unit, Integration, E2E),
- Onboarding und AI-gestützte Entwicklung (`AGENTS.md`, arc42).

Ohne ein gemeinsames **Clean-Code-Leitbild** drohen inkonsistente Styles, „Quick Fixes“ neben migrierten Pfaden und Refactors ohne fachlichen Nutzen.

### Entscheidung

**Clean Code** (nach Robert C. Martin und etablierten Praktiken) gilt als **verbindliches Qualitätsleitbild** für neuen und angefassten Code in fineract-osgi – **pragmatisch**, mit Boy Scout Rule, ohne Big-Bang-Rewrite des Legacy.

#### Kernprinzipien (verbindlich für neuen / angefassten Code)

| Prinzip | In fineract-osgi |
|---------|------------------|
| **Aussagekräftige Namen** | Fachsprache (Loan, Deposit, Tenant); keine Abkürzungsfriedhöfe; API-/Command-Namen spiegeln Use Cases |
| **Kleine, fokussierte Einheiten** | Methoden/Klassen eine Verantwortung; Handler dünn, Domain-Logik in Domain Services |
| **Funktionen ohne Seiteneffekte wo möglich** | Klare Command-Grenzen; keine versteckten Writes in Read-Pfaden |
| **DRY mit Augenmaß** | Shared nur bei echter Wiederholung; keine vorzeitigen Framework-Abstraktionen |
| **Composition over inheritance** | DTOs und Erweiterungen: [ADR-015](ADR-015-api-dtos-composition-statt-vererbung.md); Domain: klare Aggregates statt tiefer Hierarchien |
| **Fehler explizit** | Platform-/Domain-Exceptions; keine geschluckten Exceptions; Validierung vor Side Effects |
| **Kommentare sparsam** | Code erklärt *was*; Kommentare für *warum* (EclipseLink-Workarounds, Tenant-Invariants, Idempotenz) |
| **Tests als Spezifikation** | Unit für Domain/Handler; IT für Adapter; Composition-/Contract-Tests an API-Nähten |
| **Boy Scout Rule** | Hinterlasse angefassten Code etwas sauberer – im Diff-Scope, nicht als Mega-Refactor |
| **Dependency Rule** | Domain ohne REST/JPA-Vendor-APIs ([ADR-017](ADR-017-hexagonale-architektur.md)) |

#### SOLID (als Orientierung, nicht Dogma)

| Buchstabe | Anwendung |
|-----------|-----------|
| **S** | Ein Handler / ein Use Case; Resource ≠ Domain |
| **O** | Erweiterung über Ports, OSGi-Bundles, Events – nicht durch Core-Fork |
| **L** | Subtypen nur wo Is-A gilt (kein CPR für reine GET-DTOs) |
| **I** | Schmale Repository-/Port-Interfaces; keine „God“-Service-APIs neu einführen |
| **D** | Application hängt an Ports (Repos, Event-Notifier, KI), nicht an konkreten Adaptern |

#### Tooling & Durchsetzung

| Mittel | Rolle |
|--------|--------|
| **Spotless / Format** | einheitliche Formatierung (Projekt-Gradle) |
| **Checkstyle / SpotBugs** (wo aktiv) | mechanische Hygiene |
| **CI Tests** | Unit + Integration + ausgewählte E2E |
| **Code Review** | Clean-Code- und Hexagon-Regeln; Scope-Disziplin |
| **arc42 + Gherkin** | Architektur- und Verhaltens-Klarheit |
| **AGENTS.md / SECURITY.md** | Agenten und Scans an Leitplanken binden |

#### Boy Scout vs. Legacy

| Situation | Erwartung |
|-----------|-----------|
| **Neuer Pfad** (`fineract-command`, neues Modul, neuer Adapter) | Clean-Code-Regeln vollständig |
| **Angefasstes Legacy** | Fix + lokale Verbesserung (Namen, Extraktion, Test); kein unaufgefordertes Modul-Rewrite |
| **Großrefactor** | Eigenes Ticket/ADR-Bezug; grüne CI; API-Kompatibilität |

### Alternativen

| Option | Bewertung |
|--------|-----------|
| Kein formales Clean-Code-Leitbild | Inkonsistenz, schlechtes Onboarding |
| Strikte „Clean Architecture only“-Packages | Zu teuer parallel zu Hexagon/CQRS-Migration |
| Nur automatische Formatter | Unzureichend für Namen, Grenzen, Tests |
| Big-Bang Clean-Rewrite | Inkompatibel mit ADR-003/004 |

### Konsequenzen

- **+** Gemeinsame Review-Sprache; bessere Lesbarkeit und Testbarkeit  
- **+** Verstärkt Hexagon, DTO-Composition, Command-Migration  
- **+** AI-/Agenten-Arbeit bleibt an nachvollziehbaren Regeln  
- **−** Bestandscode weicht ab – Erwartung ist Evolution, nicht Perfektion  
- **−** Reviews brauchen Disziplin gegen Scope-Creep („solange ich hier bin…“)  

### Non-Goals

- Umformatierung des gesamten Repos in einem PR  
- Erzwingen von maximal kurzen Methoden um den Preis unlesbarer Fragmentierung  
- Ablösung fachlich nötiger Komplexität (Zins, COB, Multi-Tenant) durch „einfachen“ Code  
- Ersatz für Architektur-ADRs (Hexagon, JPA, CQRS bleiben führend für Struktur)

### Bezug

- [ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md) Commands  
- [ADR-014](ADR-014-arc42-gherkin-als-doku-strategie.md) Doku  
- [ADR-015](ADR-015-api-dtos-composition-statt-vererbung.md) Composition  
- [ADR-016](ADR-016-jpa-ausbau-read-write-persistenz.md) Persistenz-Klarheit  
- [ADR-017](ADR-017-hexagonale-architektur.md) Dependency Rule  
- Quality Maintainability: [07.8](../07_quality_attributes.md) · Crosscutting: [06](../06_crosscutting_concepts.md)

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
