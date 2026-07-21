# ADR-014 – arc42 + Gherkin as Documentation Strategy

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Maintainability, Operability |

### Context

Architecture and business behaviour must be discoverable for humans and agents (`docs/`, `AGENTS.md`).

### Decision

- **arc42** under `docs/arc42/` for architecture (context through decisions).  
- **Gherkin** under `docs/gherkin/` for behaviour-oriented requirements (BDD).  
- Cross-references among runtime, deployment, crosscutting, quality, and ADRs.

### Alternatives

| Option | Assessment |
|--------|------------|
| Code as the only documentation | Onboarding cost too high |
| External wiki only | Drift from the repo |
| C4 only | Possible as a complement; arc42 covers quality/ADRs better |

### Consequences

- **+** Uniform navigation structure, PR-reviewable documentation  
- **−** Documentation must be maintained when architecture changes  

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
