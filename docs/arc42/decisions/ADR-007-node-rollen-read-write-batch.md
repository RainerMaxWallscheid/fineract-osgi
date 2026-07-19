# ADR-007 – Node-Rollen Read / Write / Batch

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Scalability, Reliability, Deployability |

### Kontext

Ein All-in-One-Prozess reicht für Dev und kleine Institute. Größere Last braucht Trennung von Online-API und COB-Arbeit, ohne separate Codebasen.

### Entscheidung

Rollen über **Mode-Flags** steuern (bereits im Fineract-Kern):

- `fineract.mode.read-enabled`  
- `fineract.mode.write-enabled`  
- `fineract.mode.batch-manager-enabled`  
- `fineract.mode.batch-worker-enabled`  

Dazu `FINERACT_NODE_ID`; Worker typisch ohne Liquibase.

Topologien: All-in-One → API+Batch split → Manager + N Worker ([Kap. 5.3](../05_deployment_view.md)).

### Alternativen

| Option | Warum nicht |
|--------|-------------|
| Getrennte Artefakte pro Rolle | Build-/Release-Vervielfachung |
| Immer nur All-in-One | COB und Reports ersticken Online-Traffic |
| Kubernetes Jobs only ohne Modes | Unzureichend für langlebige Worker und API-Filter |

### Konsequenzen

- **+** Horizontale Skalierung der richtigen Ebene  
- **+** Ein Image, viele Rollen  
- **−** Fehlkonfiguration (zweiter Manager) muss operativ verhindert werden  
- **−** Mehr Deployment-Komplexität und Connection-Budget-Planung  

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
