# ADR-003 – Spring Boot + Gradle-Module als Kern beibehalten

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Maintainability, Compatibility, Reliability |

### Kontext

Ein vollständiger Rewrite (neue Sprache, neues Framework) würde Fachlogik (Loans, Savings, Accounting, COB) riskieren. Fineract bringt Spring, Batch, Security und ein großes Testnetz mit.

### Entscheidung

- **Spring Boot** bleibt Application-Container und DI-Grundlage.  
- Bestehende **Gradle-Module** (`fineract-provider`, `fineract-loan`, `fineract-core`, …) bleiben die Build-Struktur.  
- OSGi **ergänzt** den Kern (Bridge), ersetzt ihn nicht in einem Schritt.

### Alternativen

| Option | Warum verworfen |
|--------|-----------------|
| Quarkus / Micronaut Rewrite | Kein ausreichender ROI vs. Migrationsrisiko |
| Reines OSGi-Blueprint ohne Spring | Verlust Ökosystem und Contributor-Wissen |
| Softwarica „Modulith only“ ohne OSGi | Reicht nicht für dynamische Kunden-Features |

### Konsequenzen

- **+** Kontinuität, bestehende Tests und Integrationen nutzbar  
- **+** Schrittweise Modernisierung möglich  
- **−** Zwei Welten (Spring + OSGi) müssen gebridged werden  
- **−** Technische Schulden des Monolithen bleiben zunächst bestehen  

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
