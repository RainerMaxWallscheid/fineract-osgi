# 14. Module API Boundaries

Subprojekte (Gradle Domain-Module) kommunizieren **nur über Module APIs** – DDD Bounded Contexts + Hexagon Ports ([ADR-021](decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md)).

---

## 14.1 Problem

| Heute | Risiko |
|-------|--------|
| `fineract-loan` → `Charge` Entity | enge Kopplung, schwierige ES-Migration |
| `fineract-investor` → `Loan` Entity | Investor kennt Loan-Internals |
| Accounting-Code in Loan-Packages | Context-Leak |
| REST-`api` mit Domain vermischt | Adapter ≠ Port |

---

## 14.2 Zielbild

```mermaid
flowchart LR
  subgraph LoanMod["fineract-loan"]
    LDom[domain]
    LApp[application / service]
    LRest[REST api]
    LModApi[moduleapi]
  end
  subgraph ChargeMod["fineract-charge"]
    CDom[domain]
    CModApi[moduleapi]
    CRest[REST api]
  end
  LApp --> LDom
  LRest --> LApp
  LApp -->|nur Ports/DTOs| CModApi
  CModApi --> CDom
  CRest --> CDom
  LApp -.->|Events| ChargeMod
```

**Composition Root** (`fineract-provider`) verdrahtet Implementierungen; Domain-Module hängen nicht an fremden Impls.

---

## 14.3 Package-Konvention

| Slice | Package | Sichtbarkeit |
|-------|---------|--------------|
| **Module API** | `org.apache.fineract.<area>.moduleapi` | **exportiert** an andere Module |
| Domain | `...domain` | intern |
| Application | `...service`, `...handler` | intern (Interfaces wandern schrittweise nach `moduleapi`) |
| REST | `...api` | Driving Adapter – nicht von fremden Domain-Modulen importieren |
| Data (Übergang) | `...data` | DTO; mittelfristig in `moduleapi` oder Read-Model-Modul |

Beispiele (Scaffolds vorhanden):

- `org.apache.fineract.portfolio.loanaccount.moduleapi`
- `org.apache.fineract.portfolio.savings.moduleapi`
- `org.apache.fineract.portfolio.charge.moduleapi`
- `org.apache.fineract.accounting.moduleapi`
- `org.apache.fineract.portfolio.client.moduleapi` (wenn Client-Modul extrahiert; bis dahin Core-Package)

---

## 14.4 Was darf in `moduleapi` liegen?

| Erlaubt | Nicht erlaubt |
|---------|----------------|
| Port-Interfaces (`ChargeLookupPort`, `ClientStatusGuard`) | JPA-Entities / `@Entity` |
| Commands/Queries als typisierte Interfaces | `*Repository` Spring-Data |
| Stabile DTOs / IDs / Value Objects | REST Resources / Jersey |
| Event-Typen der Published Language (oder Verweis) | Handler-Implementierungen |
| Exceptions der Public Contract Surface | EclipseLink/JPA-Typen |

Implementierungen: `...service.impl` oder Adapter-Packages **im selben Modul**, von Spring/OSGi an Ports gebunden.

---

## 14.5 ArchUnit-Durchsetzung

| Testklasse | Fokus |
|------------|--------|
| [`BoundedContextEntityDependencyRulesTest`](../../fineract-architecture/src/test/java/org/apache/fineract/architecture/BoundedContextEntityDependencyRulesTest.java) | Domain-Entity Cross-Imports |
| [`ModuleApiBoundaryRulesTest`](../../fineract-architecture/src/test/java/org/apache/fineract/architecture/ModuleApiBoundaryRulesTest.java) | Modul-Slice darf fremde **Internals** nicht nutzen |

```bash
./gradlew :fineract-architecture:test
```

Legacy-Verstöße: **Freeze-Store**. Neue Internal-Imports → Build rot. Debt abbauen → Store schrumpft.

---

## 14.6 Migrations-Playbook (pro Hotspot)

1. **Port definieren** in Provider-`moduleapi` (z. B. `ChargeDefinitionPort.findActiveCharge(id)`).  
2. **Adapter** im Provider-Modul implementiert Port mit bestehendem Domain-Code.  
3. **Consumer** (Loan) auf Port umstellen.  
4. ArchUnit-Freeze schrumpft.  
5. Optional: Port-Interface nach eigenem Modul-`moduleapi` verschieben, wenn Ownership klar ist.

---

## 14.7 provider vs. Domain-Module

| Modul-Typ | Regel |
|-----------|--------|
| **Domain-Module** (loan, savings, accounting, …) | nur fremde `moduleapi` (+ Events, Shared Kernel) |
| **fineract-provider** | Composition Root: darf Module verdrahten; neue Fachlogik trotzdem in Domain-Modulen |
| **fineract-core** | Shared Kernel + Infrastruktur – nicht als „Müllhalde“ für Aggregates |

---

## 14.8 Bezug

- [ADR-021](decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md)  
- [ADR-017 Hexagon](decisions/ADR-017-hexagonale-architektur.md)  
- [10 Context Map](10_domain_context_map.md)  
- [13 ArchUnit Entity Rules](13_archunit_bounded_context_rules.md)  

---

*Navigation:* [README](README.md) · [fineract-architecture](../../fineract-architecture/README.md)
