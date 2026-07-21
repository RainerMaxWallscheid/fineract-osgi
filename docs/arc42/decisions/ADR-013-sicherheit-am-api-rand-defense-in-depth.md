# ADR-013 – Security at the API Edge + Defense in Depth

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Security, Operability |

### Context

Threat model: the API is the primary trust boundary; direct exposure without reverse proxy/WAF is not recommended.

### Decision

1. **TLS** and ideally a reverse proxy in front of Fineract.  
2. **AuthN** swappable: Basic (dev), OIDC/JWT, optional 2FA.  
3. **AuthZ** via permissions in the security context.  
4. **Tenant context** before business logic.  
5. **Audit** of all writes.  
6. Equinox console and JDWP **not** public.  
7. AI and DB secrets outside the image.

### Alternatives

| Option | Why not |
|--------|---------|
| Security only in the service mesh | Mesh complements, does not replace app AuthZ |
| API keys without user context for everything | Insufficient for maker-checker and audit |
| “Security by obscurity” for internal ports | Insufficient |

### Consequences

- **+** Multi-layered, aligned with the upstream model  
- **−** Correct proxy, CORS, and header configuration required  
- **−** OIDC per tenant increases config complexity  

### Related

- [`SECURITY.md`](../../../SECURITY.md), crosscutting [6.3](../06_crosscutting_concepts.md)

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
