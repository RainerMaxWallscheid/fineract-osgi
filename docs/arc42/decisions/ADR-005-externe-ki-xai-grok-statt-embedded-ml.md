# ADR-005 – Externe KI (xAI Grok) statt embedded ML

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Extensibility, Maintainability, Performance, Security |

### Kontext

Kredit-Scoring, Hinweise, Textanalyse sollen möglich sein. Ein trainiertes ML-Modell *im* Banking-Monolithen würde Release-, GPU-, Compliance- und Team-Kompetenz-Probleme schaffen.

### Entscheidung

KI als **externe Inferenz** anbinden (Referenz: **xAI Grok API**), gekapselt in einem **OSGi-Feature-Bundle** (z. B. `CreditScoreProvider`).

- Core Banking bleibt frei von Modellgewichten und Training-Pipelines.  
- Austausch des Providers (anderer Vendor/Modell) über Bundle-Impl.  
- Datenminimierung und Secret-Handling Pflicht ([Kap. 6.8](../06_crosscutting_concepts.md)).

### Alternativen

| Option | Warum nicht |
|--------|-------------|
| Embedded TensorFlow/ONNX im Core | Aufblähung, Ops, Haftungs-/Lizenzfragen |
| Batch-only Offline-Scoring ohne API | Zu träge für Officer-Workflows; ergänzend ok |
| KI direkt in Command-Handlern hardcoden | Kopplung, nicht multi-vendor, nicht OSGi-konform |
| Anderer Cloud-LLM only | Möglich; Architektur bleibt vendor-neutral über Interface |

### Konsequenzen

- **+** Schlanker Core, schnelle Innovation am Rand  
- **+** Passt zu OSGi-Extension-Modell  
- **−** Abhängigkeit von Netz, Vendor, Kosten  
- **−** Datenschutz/PII-Governance für Payloads nötig  
- **−** Latenz- und Ausfallbehandlung explizit designen ([ADR-006](ADR-006-ki-default-asynchron-fail-open.md))

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
