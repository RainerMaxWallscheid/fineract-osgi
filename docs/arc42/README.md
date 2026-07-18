# arc42 Architekturdokumentation

Dieses Verzeichnis enthält die arc42-Dokumentation für **fineract-osgi** – Apache Fineract 1.x mit Fokus auf OSGi-Modularität und KI-Erweiterbarkeit.

## Navigation

| Kap. | Dokument | Inhalt |
|------|----------|--------|
| 01 | [Introduction and Goals](01_introduction.md) | Zweck, Stakeholder, Ziele, Lesepfade |
| 02 | [Context and Scope](02_context_and_scope.md) | Fach-/Technikkontext, Schnittstellen, In/Out of Scope |
| 03 | [Building Block View](03_building_block_view.md) | Statische Zerlegung Level 1–3 |
| 04 | [Runtime View](04_runtime_view.md) | Abläufe: Loan, Commands, OSGi, COB, KI |
| 05 | [Deployment View](05_deployment_view.md) | Compose, K8s, Modes, OSGi-Betrieb |
| 06 | [Crosscutting Concepts](06_crosscutting_concepts.md) | Tenant, Security, CQRS, Events, Observability |
| 07 | [Quality Attributes](07_quality_attributes.md) | NFRs, Scenarios, Trade-offs |
| 08 | [Design Decisions](08_design_decisions.md) | ADRs 001–014 |
| 09 | [Glossary](09_glossary.md) | Begriffe, Abkürzungen, Ports, Env |

## Ergänzende Artefakte

| Pfad | Inhalt |
|------|--------|
| [`osgi.gradle`](osgi.gradle) | Equinox-Abhängigkeiten und Start-Task (Doku-Scaffold) |
| [`osgi/`](osgi/) | Beispiel-Equinox-Layout unter der Doku |
| [`../gherkin/`](../gherkin/README.md) | BDD-/Gherkin-Anforderungen (an arc42 getaggt) |
| [`../../SECURITY.md`](../../SECURITY.md) | Threat Model |
| [`../../osgi/`](../../osgi/) | Laufzeit-Scaffold Equinox im Repo-Root |

## Gherkin-Anbindung

Verhaltensspezifikationen liegen unter [`docs/gherkin/features/`](../gherkin/features/).  
Vollständige Mapping-Tabelle: [`docs/gherkin/README.md`](../gherkin/README.md).

| arc42-Fokus | Gherkin (Einstieg) |
|-------------|-------------------|
| Runtime Loan / Commands | [loan_creation](../gherkin/features/loan/loan_creation.feature), [command_processing](../gherkin/features/crosscutting/command_processing.feature) |
| Multi-Tenant / Security | [multi_tenant_isolation](../gherkin/features/crosscutting/multi_tenant_isolation.feature), [security_authentication](../gherkin/features/crosscutting/security_authentication.feature) |
| OSGi / KI | [optional_bundle_degradation](../gherkin/features/osgi/optional_bundle_degradation.feature), [ki_scoring_async](../gherkin/features/osgi/ki_scoring_async.feature) |
| COB / Modes | [close_of_business](../gherkin/features/cob/close_of_business.feature), [node_modes](../gherkin/features/crosscutting/node_modes.feature) |
| Domain Client/Savings/Accounting | [client_create](../gherkin/features/client/client_create.feature), [savings_account_open](../gherkin/features/savings/savings_account_open.feature), [loan_disbursement_journal](../gherkin/features/accounting/loan_disbursement_journal.feature) |

## Lesepfade (kurz)

- **Neu:** 01 → 02 → 03 → 09  
- **Feature-Dev:** 03 → 04 → 06 → passendes Gherkin-Feature  
- **Ops:** 05 → 07 → 09 → `node_modes` / `close_of_business`  
- **Architektur:** 07 → 08 → Quality-Tags in Gherkin  

## Konventionen

- Sprache: Deutsch mit etablierten englischen Technikbegriffen  
- Diagramme: Mermaid in Markdown  
- Entscheidungen: ADR-light in Kapitel 08  
- Begriffe: bei Erstnennung idealerweise im [Glossar](09_glossary.md) pflegen  
- Verhalten: Gherkin-Scenarios mit `@arc42-NN` / `@adr-NNN` / `@quality-Q-…` taggen  
