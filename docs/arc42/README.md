# arc42 Architecture Documentation

This directory contains the arc42 documentation for **fineract-osgi** – Apache Fineract 1.x with a focus on OSGi modularity and AI extensibility.

## Navigation

| Ch. | Document | Content |
|-----|----------|---------|
| 01 | [Introduction and Goals](01_introduction.md) | Purpose, stakeholders, goals, reading paths |
| 02 | [Context and Scope](02_context_and_scope.md) | Business/technical context, interfaces, in/out of scope |
| 03 | [Building Block View](03_building_block_view.md) | Static decomposition levels 1–3 |
| 04 | [Runtime View](04_runtime_view.md) | Flows: Loan, Commands, OSGi, COB, AI |
| 05 | [Deployment View](05_deployment_view.md) | Compose, K8s, modes, OSGi operations |
| 06 | [Crosscutting Concepts](06_crosscutting_concepts.md) | Tenant, Security, CQRS, Events, Observability |
| 07 | [Quality Attributes](07_quality_attributes.md) | NFRs, scenarios, trade-offs |
| 08 | [Design Decisions](08_design_decisions.md) | ADRs 001–023 in [`decisions/`](decisions/) |
| 09 | [Glossary](09_glossary.md) | Terms, abbreviations, ports, env |
| 10 | [Domain Context Map](10_domain_context_map.md) | Bounded contexts, subdomains, U/D map, migration order (DDD D1) |
| 11 | [Aggregate Canvas](11_aggregate_canvas.md) | Loan, SavingsAccount, Client: invariants, commands, events, conflicts (tactical DDD) |
| 12 | [Event Catalog](12_event_catalog.md) | All business event TYPEs → ES target names, gaps, Avro, LoanEvent |
| 13 | [ArchUnit BC Rules](13_archunit_bounded_context_rules.md) | ArchUnit rules against cross-context entity imports (freeze baseline) |
| 14 | [Module API Boundaries](14_module_api_boundaries.md) | Subprojects only via `moduleapi` (ADR-021) |
| 15 | [OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md) | api/impl/test split, Service Registry, Fragment-Host, stages B0–B6, **post-command rollout waves** (ADR-022) |
| 15a | [fineract-command pilot plan](15_osgi_bundle_refactoring_fineract-command.md) | Step-by-step OSGi split for the command stack (as-built) |
| 15b | [fineract-charge split plan](15_osgi_bundle_refactoring_fineract-charge.md) | Wave‑1 charge catalog api/impl/test plan (**complete**) |
| 15c | [fineract-document split plan](15_osgi_bundle_refactoring_fineract-document.md) | Wave‑2 document/content-store api/impl/test plan (**complete**) |
| 15d | [fineract-branch split plan](15_osgi_bundle_refactoring_fineract-branch.md) | Wave‑2 branch/teller api/impl/test plan (**complete**) |
| 15e | [fineract-loan-origination split plan](15_osgi_bundle_refactoring_fineract-loan-origination.md) | Wave‑2 loan-originator api/impl/test plan (**complete**) |
| 15f | [fineract-mix split plan](15_osgi_bundle_refactoring_fineract-mix.md) | Wave‑2 MIX/XBRL api/impl/test plan (**complete**) |
| 15g | [fineract-investor split plan](15_osgi_bundle_refactoring_fineract-investor.md) | Wave‑3 investor/external asset-owner api/impl/test plan (**complete**; journal residual) |
| 15h | [fineract-accounting split plan](15_osgi_bundle_refactoring_fineract-accounting.md) | Wave‑3 accounting GL/journal api/impl/test plan (**complete**; entity residual) |
| 15i | [fineract-savings split plan](15_osgi_bundle_refactoring_fineract-savings.md) | Wave‑3 savings/deposits api/impl/test plan (**complete**; entity residual) |
| 15j | [fineract-loan split plan](15_osgi_bundle_refactoring_fineract-loan.md) | Wave‑4 loan api/impl/test plan (**complete**; entity residual for progressive/WC/provider) |
| 15k | [fineract-progressive-loan split plan](15_osgi_bundle_refactoring_fineract-progressive-loan.md) | Wave‑4 progressive loan api/impl/test plan (**complete**) |
| 15l | [fineract-working-capital-loan split plan](15_osgi_bundle_refactoring_fineract-working-capital-loan.md) | Wave‑4 working-capital loan api/impl/test plan (**complete**) |
| 15m | [fineract-cob split plan](15_osgi_bundle_refactoring_fineract-cob.md) | Wave‑4 COB api/impl/test plan (**complete**) |
| 15n | [fineract-security split plan](15_osgi_bundle_refactoring_fineract-security.md) | Wave‑4 security api/impl/test plan (**complete**) |
| 15o | [fineract-core slices plan](15_osgi_bundle_refactoring_fineract-core-slices.md) | Optional slices + leftover close-ins 1–30 **complete**; remaining core **is** the shared kernel (rank 31). Do not full core split. |

## Complementary Artifacts

| Path | Content |
|------|---------|
| [`osgi.gradle`](osgi.gradle) | Equinox dependencies and start task (doc scaffold) |
| [`osgi/`](osgi/) | Example Equinox layout under the documentation |
| [`../gherkin/`](../gherkin/README.md) | BDD/Gherkin requirements (tagged to arc42) |
| [`../../SECURITY.md`](../../SECURITY.md) | Threat model |
| [`../../osgi/`](../../osgi/) | Runtime Equinox scaffold at the repository root |

## Gherkin Integration

Behavior specifications live under [`docs/gherkin/features/`](../gherkin/features/).  
Full mapping table: [`docs/gherkin/README.md`](../gherkin/README.md).

| arc42 Focus | Gherkin (Entry Points) |
|-------------|------------------------|
| Runtime Loan / Commands | [loan_creation](../gherkin/features/loan/loan_creation.feature), [command_processing](../gherkin/features/crosscutting/command_processing.feature) |
| Multi-Tenant / Security | [multi_tenant_isolation](../gherkin/features/crosscutting/multi_tenant_isolation.feature), [security_authentication](../gherkin/features/crosscutting/security_authentication.feature) |
| OSGi / AI | [optional_bundle_degradation](../gherkin/features/osgi/optional_bundle_degradation.feature), [ki_scoring_async](../gherkin/features/osgi/ki_scoring_async.feature) |
| COB / Modes | [close_of_business](../gherkin/features/cob/close_of_business.feature), [node_modes](../gherkin/features/crosscutting/node_modes.feature) |
| Domain Client/Savings/Accounting | [client_create](../gherkin/features/client/client_create.feature), [savings_account_open](../gherkin/features/savings/savings_account_open.feature), [loan_disbursement_journal](../gherkin/features/accounting/loan_disbursement_journal.feature) |

## Reading Paths (Short)

- **Newcomers:** 01 → 02 → 03 → 09  
- **Feature development:** 03 → 04 → 06 → matching Gherkin feature  
- **Domain / DDD:** 10 → 11 → 12 → 13 → ADR-019 → ADR-020 → 03 (modules)  
- **Ops:** 05 → 07 → 09 → `node_modes` / `close_of_business`  
- **Architecture:** 07 → 08 → 10 → quality tags in Gherkin  
- **OSGi modularity refactor:** ADR-002 → ADR-021 → [ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md) → [15](15_osgi_bundle_refactoring.md) → 06.7 → 04.4  

## Conventions

- Language: English with established technical terms  
- Diagrams: Mermaid in Markdown  
- Decisions: ADR-light in chapter 08  
- Terms: on first use, ideally maintain them in the [Glossary](09_glossary.md)  
- Behavior: tag Gherkin scenarios with `@arc42-NN` / `@adr-NNN` / `@quality-Q-…`  
