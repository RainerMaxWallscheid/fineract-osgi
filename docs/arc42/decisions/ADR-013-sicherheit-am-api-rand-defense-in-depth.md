# ADR-013 – Sicherheit am API-Rand + Defense in Depth

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Security, Operability |

### Kontext

Threat Model: API ist primäre Trust Boundary; kein Direkt-Expose ohne Reverse Proxy/WAF empfohlen.

### Entscheidung

1. **TLS** und idealerweise Reverse Proxy vor Fineract.  
2. **AuthN** austauschbar: Basic (Dev), OIDC/JWT, optional 2FA.  
3. **AuthZ** über Permissions im Security Context.  
4. **Tenant-Context** vor Fachlogik.  
5. **Audit** aller Writes.  
6. Equinox Console und JDWP **nicht** öffentlich.  
7. KI- und DB-Secrets außerhalb des Images.

### Alternativen

| Option | Warum nicht |
|--------|-------------|
| Security nur im Service-Mesh | Mesh ergänzt, ersetzt App-AuthZ nicht |
| API-Keys ohne User-Context für alles | Unzureichend für Maker-Checker und Audit |
| „Security by obscurity“ interner Ports | Unzureichend |

### Konsequenzen

- **+** Mehrschichtig, an Upstream-Modell angelehnt  
- **−** Korrekte Proxy-, CORS- und Header-Konfiguration nötig  
- **−** OIDC pro Tenant erhöht Config-Komplexität  

### Bezug

- [`SECURITY.md`](../../../SECURITY.md), Crosscutting [6.3](../06_crosscutting_concepts.md)

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
