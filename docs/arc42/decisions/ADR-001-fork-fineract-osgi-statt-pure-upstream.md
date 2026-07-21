# ADR-001 – Fork fineract-osgi instead of pure upstream

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Extensibility, Maintainability, Compatibility (controlled) |

### Context

Apache Fineract covers core banking for financial inclusion, but is modular only at the build level (monolithic/modular at build time). fineract-osgi aims to advance **OSGi runtime modularity** and **AI extensibility** without being blocked by the upstream release cadence and every community decision.

### Decision

Maintain a **dedicated fork/workstream `fineract-osgi`** that:

- adopts the Fineract 1.x core and domain modules,
- documents and incrementally implements OSGi and AI paths,
- selectively merges upstream fixes.

### Alternatives

| Option | Why not (now) |
|--------|----------------|
| Upstream PRs only | Too slow/uncertain for OSGi experiments; scope conflict |
| Completely new system | Loss of domain capability; years of effort |
| Plugins only without a fork | Upstream lacks a runtime plugin model |

### Consequences

- **+** Own architecture roadmap (arc42, OSGi, AI)  
- **+** Experiments without destabilizing upstream  
- **−** Merge effort and drift risk vs. Apache Fineract  
- **−** Clear governance required (what flows back, what stays fork-specific)

### Related

- [01 Introduction](../01_introduction.md), [02 Context](../02_context_and_scope.md)

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
