# 13. ArchUnit – Bounded Context Entity Rules

Automatisierte Dependency-Regeln gegen **Cross-Context-Entity-Imports** auf Domain-Ebene. Implementierung: Modul [`fineract-architecture`](../../fineract-architecture/).

Bezug: [10 Context Map](10_domain_context_map.md) · [11 Aggregate Canvas](11_aggregate_canvas.md) · [ADR-017](decisions/ADR-017-hexagonale-architektur.md) · [ADR-019](decisions/ADR-019-domain-driven-design.md).

---

## 13.1 Ziel

| Regelklasse | Soll |
|-------------|------|
| **Entity-Sharing** | Domain-Package eines BC importiert **keine** JPA-Entities fremder BCs (`Client`, `Group`, `Loan`, `SavingsAccount`, `JournalEntry`, …) |
| **Integration** | Nur IDs, Application-Ports, Domain/Business Events, Published Language |
| **Hexagon** | `..domain..` hängt nicht von `..api..` (Driving Adapters) ab |

---

## 13.2 Modul und Ausführung

```bash
./gradlew :fineract-architecture:test
```

| Artefakt | Pfad |
|----------|------|
| Entity-Grenzen | `…/BoundedContextEntityDependencyRulesTest.java` |
| **Module API-Grenzen** | `…/ModuleApiBoundaryRulesTest.java` ([ADR-021](decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md), [14](14_module_api_boundaries.md)) |
| Package-Konstanten | `ArchitecturePackages.java` |
| ArchUnit Config | `src/test/resources/archunit.properties` |
| Freeze-Baseline | `src/test/resources/archunit_store/` |
| README | [`fineract-architecture/README.md`](../../fineract-architecture/README.md) |

Dependency: `com.tngtech.archunit:archunit-junit5` (Version in `buildSrc/.../org.apache.fineract.dependencies.gradle`).

---

## 13.3 Regeln (Inventar)

Alle Regeln nutzen **`FreezingArchRule`**: bestehende Legacy-Verstöße sind baselined; **neue** Verstöße brechen den Build.

### Cross-Context Domain Entities

| Rule-ID (Testfeld) | From (domain) | Must not depend on | Begründung |
|--------------------|---------------|--------------------|------------|
| `loan_account_domain_must_not_depend_on_client_domain` | `..loanaccount.domain..` | `..client.domain..` | Client nur als `ClientId` |
| `loan_account_domain_must_not_depend_on_group_domain` | `..loanaccount.domain..` | `..group.domain..` | Group nur als `GroupId` |
| `loan_account_domain_must_not_depend_on_savings_domain` | `..loanaccount.domain..` | `..savings.domain..` | Transfer = Process Context |
| `loan_account_domain_must_not_depend_on_journal_entry_domain` | `..loanaccount.domain..` | `..journalentry.domain..` | Journal = Projection |
| `savings_domain_must_not_depend_on_loan_account_domain` | `..savings.domain..` | `..loanaccount.domain..` | getrennte BCs |
| `savings_domain_must_not_depend_on_client_domain` | `..savings.domain..` | `..client.domain..` | ClientId |
| `savings_domain_must_not_depend_on_group_domain` | `..savings.domain..` | `..group.domain..` | GroupId |
| `savings_domain_must_not_depend_on_journal_entry_domain` | `..savings.domain..` | `..journalentry.domain..` | Journal = Projection |
| `accounting_domain_must_not_depend_on_loan_account_domain` | `..accounting..domain..` | `..loanaccount.domain..` | Events/DTOs, keine Loan-Entity |
| `accounting_domain_must_not_depend_on_savings_domain` | `..accounting..domain..` | `..savings.domain..` | analog |
| `accounting_domain_must_not_depend_on_client_domain` | `..accounting..domain..` | `..client.domain..` | analog |
| `loan_product_domain_must_not_depend_on_client_domain` | `..loanproduct.domain..` | `..client.domain..` | Product Catalog |
| `loan_origination_domain_must_not_depend_on_savings_domain` | `..loanorigination.domain..` | `..savings.domain..` | Handoff → Loan |
| `working_capital_domain_must_not_depend_on_client_domain` | `..workingcapitalloan.domain..` | `..client.domain..` | ClientId |

### Hexagon (Domain → REST resource packages)

| Rule-ID | From | Must not depend on |
|---------|------|--------------------|
| `loan_account_domain_must_not_depend_on_rest_api` | loanaccount.domain | REST resource packages* |
| `savings_domain_must_not_depend_on_rest_api` | savings.domain | REST resource packages* |
| `client_domain_must_not_depend_on_rest_api` | client.domain | REST resource packages* |
| `accounting_domain_must_not_depend_on_rest_api` | accounting..domain | REST resource packages* |

\*See `ArchitecturePackages.REST_RESOURCE_PACKAGES` — e.g. `..portfolio..api..`, `..accounting..api..`.  
**Excluded:** `infrastructure.core.api` (`JsonCommand`) — application infrastructure, not HTTP adapters.

---

## 13.4 Freeze-Baseline (Legacy Debt)

Beim ersten Lauf wurden Verstöße in `archunit_store` geschrieben. Leere Freeze-Dateien = Regel bereits **grün** (0 Verstöße). Nicht-leere Dateien = dokumentierte Altlast.

**Baseline nach erstem Lauf (Domain-Module-Classpath):**

| Regel-Gruppe | Status |
|--------------|--------|
| Loan/Savings ↔ Journal | oft **grün** (0 frozen) |
| Loan ↔ Savings | oft **grün** |
| Accounting → Loan/Savings/Client Entities | oft **grün** |
| Loan → Client / Group | **frozen** (`Loan.client` / `Loan.group`) |
| Savings → Client / Group | **frozen** |
| WC → Client | **frozen** |
| Accounting domain → `accounting..api..` (z. B. `*JsonInputParams`) | **frozen** (Hexagon) |

Exakte Counts: Dateien unter `archunit_store/` (nicht-leere Dateien = Debt).

**Arbeitsweise beim Schuldenabbau**

1. Entity-Ref durch ID/Snapshot ersetzen (Canvas [11](11_aggregate_canvas.md)).
2. `./gradlew :fineract-architecture:test` – Freeze-Store darf **schrumpfen** (`allowStoreUpdate=true`).
3. PR: Store-Diff mitcommitten (Beweis, dass Debt reduziert wurde).
4. Store **wachsen** lassen nur mit bewusster Ausnahme (Review + ADR-Notiz).

---

## 13.5 Scope / Non-Goals

| Im Scope | Nicht im Scope (noch) |
|----------|------------------------|
| Domain-Packages der geladenen Module (core, loan, savings, accounting, progressive, WC, origination, …) | Gesamter `fineract-provider` Service-Layer (bewusst nicht auf dem Architecture-Classpath, um den Modul-Scope schlank zu halten) |
| Entity-/Package-Abhängigkeiten | Laufzeit-OSGi-Service-Graf |
| Freeze gegen Regression | Sofortiges Zero-Violation-Ziel |

**Erweiterung:** Provider-Packages später per `testImplementation project(':fineract-provider')` ergänzen und zusätzliche Service-Layer-Regeln frezen.

---

## 13.6 CI-Empfehlung

- Job/Stage: `./gradlew :fineract-architecture:test` (schnell, ~Domain-Module-Classpath).
- Optional: bei main-Branch `allowStoreUpdate=false` via Property, damit Freeze nur lokal/PR schrumpfen darf (strenger CI-Modus – Team-Entscheidung).

---

## 13.7 Bezug

| Dokument | Rolle |
|----------|--------|
| [10 Context Map](10_domain_context_map.md) | U/D und Entity-Sharing-Verbot |
| [11 Aggregate Canvas](11_aggregate_canvas.md) | Loan/Savings/Client Roots |
| [12 Event Catalog](12_event_catalog.md) | Integration über Events |
| [06.15 DDD](06_crosscutting_concepts.md) | Querschnitt |
| [ADR-017](decisions/ADR-017-hexagonale-architektur.md) / [ADR-019](decisions/ADR-019-domain-driven-design.md) | Leitbilder |

---

*Navigation:* [README](README.md) · [10 Context Map](10_domain_context_map.md) · [fineract-architecture](../../fineract-architecture/README.md)
