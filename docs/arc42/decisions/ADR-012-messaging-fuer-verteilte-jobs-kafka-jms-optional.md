# ADR-012 – Messaging for Distributed Jobs (Kafka/JMS optional)

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Scalability, Reliability |

### Context

COB and remote jobs need distribution when multiple workers are present. For single-node, in-process events suffice.

### Decision

- **Local default**: Spring Events (`fineract.remote-job-message-handler.spring-events`).  
- **Distributed**: Kafka **or** JMS/ActiveMQ via configuration.  
- External events optionally use the same broker stack.  
- No forced broker in a minimal installation.

### Alternatives

| Option | Assessment |
|--------|------------|
| Always force Kafka | Barrier for small deployments |
| DB polling only for work queues | Simple, but load and locking on the banking DB |
| Cloud-proprietary queues only | Lock-in; adapters possible later |

### Consequences

- **+** Scalable worker plane  
- **+** Decoupling online vs. batch  
- **−** At-least-once → idempotent consumers/steps  
- **−** Ops competence for broker HA in production  

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
