# ADR-010 – Headless REST-API, keine UI im Scope

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Maintainability, Compatibility |

### Kontext

Fineract ist API-first; UIs (Web App, Community App, Self-Service) sind separate Produkte ([`SECURITY.md`](../../../SECURITY.md), [Kap. 2](../02_context_and_scope.md)).

### Entscheidung

fineract-osgi liefert **keine** First-Class-UI im Architektur-Scope. Integration über REST/OpenAPI; optionale Compose-Dateien für UI-Nebenstacks sind Demo, nicht Kern.

### Alternativen

| Option | Warum nicht |
|--------|-------------|
| UI in denselben Deployable | Vermischt Release-Zyklen und Threat Model |
| GraphQL als Primär-API | Zusätzliche Oberfläche ohne Bedarf der bestehenden Integratoren |

### Konsequenzen

- **+** Klarer Schnitt, kleineres Security-Scope  
- **−** UX-Verantwortung liegt bei Integratoren/Frontend-Teams  

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
