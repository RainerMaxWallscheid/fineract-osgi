# ADR-014 – arc42 + Gherkin als Doku-Strategie

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Maintainability, Operability |

### Kontext

Architektur- und Fachverhalten müssen für Menschen und Agenten auffindbar sein (`docs/`, `AGENTS.md`).

### Entscheidung

- **arc42** unter `docs/arc42/` für Architektur (Kontext bis Entscheidungen).  
- **Gherkin** unter `docs/gherkin/` für verhaltensnahe Anforderungen (BDD).  
- Querverweise zwischen Runtime, Deployment, Crosscutting, Quality und ADRs.

### Alternativen

| Option | Bewertung |
|--------|-----------|
| Nur Code als Doku | Zu hohe Onboarding-Kosten |
| Nur Wiki extern | Drift zum Repo |
| C4 only | Ergänzend möglich; arc42 deckt Qualität/ADRs besser ab |

### Konsequenzen

- **+** Einheitliche Navigationsstruktur, PR-reviewbare Doku  
- **−** Doku muss bei Architekturänderungen mitgepflegt werden  

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
