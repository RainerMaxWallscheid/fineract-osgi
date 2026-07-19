# ADR-012 – Messaging für verteilte Jobs (Kafka/JMS optional)

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Scalability, Reliability |

### Kontext

COB und Remote Jobs brauchen bei mehreren Workern eine Verteilung. Für Single-Node reichen In-Process-Events.

### Entscheidung

- **Default lokal**: Spring Events (`fineract.remote-job-message-handler.spring-events`).  
- **Verteilt**: Kafka **oder** JMS/ActiveMQ per Konfiguration.  
- External Events analog optional über denselben Broker-Stack.  
- Kein Zwang zu einem Broker in der Minimalinstallation.

### Alternativen

| Option | Bewertung |
|--------|-----------|
| Immer Kafka erzwingen | Hürde für kleine Deployments |
| Nur DB-Polling für Work-Queues | Einfach, aber Last und Locking auf der Banking-DB |
| Cloud-proprietary Queues only | Lock-in; Adapter später möglich |

### Konsequenzen

- **+** Skalierbare Worker-Plane  
- **+** Entkopplung Online vs. Batch  
- **−** At-least-once → idempotente Consumer/Steps  
- **−** Ops-Kompetenz für Broker-HA in Prod  

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
