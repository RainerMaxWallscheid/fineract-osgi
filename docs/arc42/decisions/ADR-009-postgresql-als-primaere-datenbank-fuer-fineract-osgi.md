# ADR-009 – PostgreSQL als primäre Datenbank für fineract-osgi

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Operability, Portability, Compatibility |

### Kontext

Upstream unterstützt MySQL/MariaDB/PostgreSQL. Die arc42- und Compose-Referenz von fineract-osgi priorisiert **PostgreSQL** (Docker-Defaults, Doku).

### Entscheidung

- **PostgreSQL** ist die **primäre** dokumentierte und getestete Ziel-DB für fineract-osgi.  
- MySQL/MariaDB bleiben über bestehende Compose-/K8s-Beispiele **kompatibel**, sind aber nicht der strategische Fokus.  
- K8s-Beispiele mit MySQL im Repo gelten als Upstream-Erbe, nicht als Zielbild.

### Alternativen

| Option | Bewertung |
|--------|-----------|
| MySQL first | Upstream-Nähe; nicht die gewählte Doku-Linie |
| Nur Managed Cloud-SQL-Abstraktion | Ziel-Betrieb ok, ersetzt nicht die Engine-Entscheidung |
| Separate DB-Engine pro Modul | Unnötige Komplexität |

### Konsequenzen

- **+** Klare Referenzarchitektur, ein Ops-Pfad  
- **−** Dual-Stack-Tests kosten extra, wenn MySQL weiter offiziell supportet wird  
- **−** Migration bestehender MySQL-Kunden braucht Runbook  

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
