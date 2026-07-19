# ADR-008 – Multi-Tenancy mit getrennten Tenant-Datenbanken

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Security, Isolation, Scalability |

### Kontext

SaaS-/Hosting-Szenarien bedienen viele Institute. Strikte Trennung von Daten und oft Konfiguration (inkl. OIDC pro Tenant) ist Pflicht.

### Entscheidung

- Zentrale **Tenants-Registry-DB** (`fineract_tenants`)  
- **Fachdaten pro Tenant** in eigener DB/Schema  
- Request- und Job-Context über Filter + ThreadLocal  
- Optional Read-only-Connections für Report-Nodes  

### Alternativen

| Option | Bewertung |
|--------|-----------|
| Shared Schema + `tenant_id` Spalte | Einfacher Betrieb, schwächere Isolation, riskantere Queries |
| DB-pro-Tenant auf eigenem Server immer | Maximale Isolation, hohe Kosten; optional für Großkunden |
| Schema-pro-Request dynamisch ohne Pool | Performance-Falle |

### Konsequenzen

- **+** Starke Isolation, Backup/Restore pro Institut möglich  
- **+** Passt zu Security-Szenarien Q-SEC-1  
- **−** Connection-Pools multiplizieren sich  
- **−** Ops muss Tenant-Lifecycle (Provisionierung) beherrschen  

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
