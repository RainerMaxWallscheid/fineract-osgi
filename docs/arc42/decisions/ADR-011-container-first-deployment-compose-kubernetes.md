# ADR-011 – Container-first Deployment (Compose + Kubernetes)

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Deployability, Operability, Scalability |

### Context

Operators expect reproducible environments from laptop to cluster.

### Decision

- **Docker Compose** for dev/test and documented topologies (single, manager/worker, Kafka/ActiveMQ).  
- **Kubernetes** manifests as the cluster blueprint.  
- App nodes largely **stateless**; state lives in DB/messaging.  
- Compose/K8s examples are **not** automatically production-hardened.

### Alternatives

| Option | Assessment |
|--------|------------|
| Bare-metal JAR only | Possible, worse reproducibility |
| Helm only from day 1 | Target; manifests first, chart follows (open point ch. 5) |
| Serverless functions for commands | Unsuitable for long-running COB transactions and state |

### Consequences

- **+** Same image, modes via env  
- **+** Fits health probes and horizontal workers  
- **−** Secrets, TLS, and network hardening remain operator responsibilities  

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
