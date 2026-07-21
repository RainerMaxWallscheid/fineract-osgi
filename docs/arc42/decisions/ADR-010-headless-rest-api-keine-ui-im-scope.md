# ADR-010 – Headless REST API, no UI in scope

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Maintainability, Compatibility |

### Context

Fineract is API-first; UIs (web app, community app, self-service) are separate products ([`SECURITY.md`](../../../SECURITY.md), [Ch. 2](../02_context_and_scope.md)).

### Decision

fineract-osgi delivers **no** first-class UI in the architecture scope. Integration via REST/OpenAPI; optional Compose files for UI side stacks are demo, not core.

### Alternatives

| Option | Why not |
|--------|---------|
| UI in the same deployable | Mixes release cycles and threat model |
| GraphQL as primary API | Extra surface without demand from existing integrators |

### Consequences

- **+** Clear cut, smaller security scope  
- **−** UX responsibility lies with integrators/frontend teams  

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
