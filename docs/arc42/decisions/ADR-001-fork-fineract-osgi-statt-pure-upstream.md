# ADR-001 – Fork fineract-osgi statt pure Upstream

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Extensibility, Maintainability, Compatibility (kontrolliert) |

### Kontext

Apache Fineract deckt Core Banking für Inklusion ab, ist aber monolithisch/modular nur auf Build-Ebene. fineract-osgi will **OSGi-Laufzeitmodularität** und **KI-Erweiterbarkeit** vorantreiben, ohne den Upstream-Release-Takt und jede Community-Entscheidung zu blockieren.

### Entscheidung

Einen **dedizierten Fork/Arbeitsstrang `fineract-osgi`** führen, der:

- den Fineract-1.x-Kern und Domain-Module übernimmt,
- OSGi- und KI-Pfade dokumentiert und schrittweise implementiert,
- Upstream-Fixes selektiv übernimmt.

### Alternativen

| Option | Warum nicht (jetzt) |
|--------|---------------------|
| Nur Upstream-PRs | Zu langsam/unsicher für OSGi-Experimente; Scope-Konflikt |
| Komplett neues System | Fachlicher Verlust, Jahre Aufwand |
| Nur Plugins ohne Fork | Laufzeit-Plugin-Modell fehlt im Upstream |

### Konsequenzen

- **+** Eigene Architektur-Roadmap (arc42, OSGi, KI)  
- **+** Experimente ohne Upstream zu destabilisieren  
- **−** Merge-Aufwand und Drift-Risiko zu Apache Fineract  
- **−** Klare Governance nötig (was zurückfließt, was fork-spezifisch bleibt)

### Bezug

- [01 Introduction](../01_introduction.md), [02 Context](../02_context_and_scope.md)

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
