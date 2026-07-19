# ADR-006 – KI default asynchron & Fail-Open

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Performance, Reliability; Trade-off vs. strikte Auto-Decision |

### Kontext

Externe Inference kann 100 ms–mehrere Sekunden dauern und ausfallen. Sync im Default-Write-Pfad gefährdet p95 und Verfügbarkeit ([Q-PERF-1](../07_quality_attributes.md), [Q-REL-2](../07_quality_attributes.md)).

### Entscheidung

| Aspekt | Default | Ausnahme |
|--------|---------|----------|
| Aufrufzeitpunkt | **Async** nach Domain-Event / nach Commit | Sync nur als konfiguriertes **Policy Gate** |
| Bei Timeout/5xx | **Fail-Open** (Write bleibt erfolgreich) | **Fail-Closed** nur produkt-/regulatorisch erzwungen |
| Buchungen | KI ändert **nie still** Salden | Nur Enrichment oder explizite Business-Rule |

### Alternativen

| Option | Bewertung |
|--------|-----------|
| Immer sync vor Persistenz | Hohe Korrektheit der „KI-Entscheidung“, schlechte Latenz/Verfügbarkeit |
| Immer Fail-Closed | Sicher für Auto-Reject-Produkte, riskant für Ops |
| Fire-and-forget ohne Persistenz des Scores | Zu wenig Auditierbarkeit |

### Konsequenzen

- **+** Write-SLO und COB entkoppelt von Vendor-Latenz  
- **+** Klare Policy-Matrix pro Produkt möglich  
- **−** Score ggf. erst verzögert sichtbar (Eventual Enrichment)  
- **−** Produkt-Teams müssen Fail-Closed bewusst einschalten  

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
