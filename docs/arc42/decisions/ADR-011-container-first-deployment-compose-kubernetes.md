# ADR-011 – Container-first Deployment (Compose + Kubernetes)

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Deployability, Operability, Scalability |

### Kontext

Betreiber erwarten reproduzierbare Umgebungen von Laptop bis Cluster.

### Entscheidung

- **Docker Compose** für Dev/Test und dokumentierte Topologien (Single, Manager/Worker, Kafka/ActiveMQ).  
- **Kubernetes**-Manifeste als Cluster-Blaupause.  
- App-Nodes weitgehend **stateless**; Zustand in DB/Messaging.  
- Compose/K8s-Beispiele sind **nicht** automatisch production-hardened.

### Alternativen

| Option | Bewertung |
|--------|-----------|
| Nur Bare-Metal JAR | Möglich, schlechtere Reproduzierbarkeit |
| Nur Helm von Tag 1 | Ziel; Manifeste zuerst, Chart folgt (offener Punkt Kap. 5) |
| Serverless Functions für Commands | Unpassend für lange COB-Transaktionen und State |

### Konsequenzen

- **+** Gleiches Image, Modes per Env  
- **+** Passt zu Health-Probes und horizontalen Workern  
- **−** Secrets-, TLS- und Network-Härtung bleiben Betreiberpflicht  

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
