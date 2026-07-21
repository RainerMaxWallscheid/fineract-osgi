# ADR-008 – Multi-tenancy with separate tenant databases

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Security, Isolation, Scalability |

### Context

SaaS/hosting scenarios serve many institutions. Strict separation of data and often configuration (including OIDC per tenant) is mandatory.

### Decision

- Central **tenants registry DB** (`fineract_tenants`)  
- **Business data per tenant** in its own DB/schema  
- Request and job context via filter + ThreadLocal  
- Optional read-only connections for report nodes  

### Alternatives

| Option | Assessment |
|--------|------------|
| Shared schema + `tenant_id` column | Simpler ops, weaker isolation, riskier queries |
| DB-per-tenant always on its own server | Maximum isolation, high cost; optional for large customers |
| Dynamic schema-per-request without pool | Performance trap |

### Consequences

- **+** Strong isolation; backup/restore per institution possible  
- **+** Fits security scenarios Q-SEC-1  
- **−** Connection pools multiply  
- **−** Ops must master the tenant lifecycle (provisioning)  

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
