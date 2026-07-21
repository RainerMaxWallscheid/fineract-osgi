# ADR-005 – External AI (xAI Grok) instead of embedded ML

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Extensibility, Maintainability, Performance, Security |

### Context

Credit scoring, guidance, and text analysis should be possible. A trained ML model *inside* the banking monolith would create release, GPU, compliance, and team-skill problems.

### Decision

Connect AI as **external inference** (reference: **xAI Grok API**), encapsulated in an **OSGi feature bundle** (e.g. `CreditScoreProvider`).

- Core banking stays free of model weights and training pipelines.  
- Provider swap (other vendor/model) via bundle implementation.  
- Data minimization and secret handling are mandatory ([Ch. 6.8](../06_crosscutting_concepts.md)).

### Alternatives

| Option | Why not |
|--------|---------|
| Embedded TensorFlow/ONNX in the core | Bloat, ops, liability/license issues |
| Batch-only offline scoring without API | Too slow for officer workflows; OK as a complement |
| Hardcoding AI directly in command handlers | Coupling, not multi-vendor, not OSGi-conformant |
| Another cloud LLM only | Possible; architecture stays vendor-neutral via interface |

### Consequences

- **+** Lean core, fast innovation at the edge  
- **+** Fits the OSGi extension model  
- **−** Dependency on network, vendor, cost  
- **−** Privacy/PII governance for payloads required  
- **−** Latency and failure handling must be designed explicitly ([ADR-006](ADR-006-ki-default-asynchron-fail-open.md))

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
