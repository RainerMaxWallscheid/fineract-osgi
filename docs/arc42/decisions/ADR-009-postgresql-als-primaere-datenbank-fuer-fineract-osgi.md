# ADR-009 – PostgreSQL as the primary database for fineract-osgi

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Operability, Portability, Compatibility |

### Context

Upstream supports MySQL/MariaDB/PostgreSQL. The arc42 and Compose reference for fineract-osgi prioritizes **PostgreSQL** (Docker defaults, documentation).

### Decision

- **PostgreSQL** is the **primary** documented and tested target DB for fineract-osgi.  
- MySQL/MariaDB remain **compatible** via existing Compose/K8s examples, but are not the strategic focus.  
- K8s examples with MySQL in the repo count as upstream legacy, not as the target vision.

### Alternatives

| Option | Assessment |
|--------|------------|
| MySQL first | Closer to upstream; not the chosen documentation line |
| Managed cloud SQL abstraction only | Fine for target operations; does not replace the engine decision |
| Separate DB engine per module | Unnecessary complexity |

### Consequences

- **+** Clear reference architecture, one ops path  
- **−** Dual-stack tests cost extra if MySQL remains officially supported  
- **−** Migrating existing MySQL customers needs a runbook  

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
