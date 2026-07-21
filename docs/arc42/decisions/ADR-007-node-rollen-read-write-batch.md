# ADR-007 – Node roles Read / Write / Batch

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Scalability, Reliability, Deployability |

### Context

An all-in-one process is enough for development and small institutions. Higher load needs separation of online API and COB work, without separate codebases.

### Decision

Control roles via **mode flags** (already in the Fineract core):

- `fineract.mode.read-enabled`  
- `fineract.mode.write-enabled`  
- `fineract.mode.batch-manager-enabled`  
- `fineract.mode.batch-worker-enabled`  

Plus `FINERACT_NODE_ID`; workers typically without Liquibase.

Topologies: all-in-one → API+batch split → manager + N workers ([Ch. 5.3](../05_deployment_view.md)).

### Alternatives

| Option | Why not |
|--------|---------|
| Separate artifacts per role | Build/release multiplication |
| Always all-in-one only | COB and reports choke online traffic |
| Kubernetes Jobs only without modes | Insufficient for long-lived workers and API filters |

### Consequences

- **+** Horizontal scaling of the right tier  
- **+** One image, many roles  
- **−** Misconfiguration (second manager) must be prevented operationally  
- **−** More deployment complexity and connection-budget planning  

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
