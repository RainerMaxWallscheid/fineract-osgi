# Gherkin / BDD Requirements – fineract-osgi

Behavior-Driven Requirements als **Gherkin-Features**. Sie beschreiben das *erwartete Verhalten* und sind an die [arc42-Architekturdokumentation](../arc42/README.md) angebunden.

## Zweck

| Artefakt | Frage |
|----------|--------|
| **arc42** | Wie ist das System gebaut? (Struktur, Runtime, Deployment, ADRs) |
| **Gherkin** | Welches Verhalten muss gelten? (Given/When/Then, abnahmerelevant) |

Features sind **Anforderungs- und Abnahmespezifikation**. Automatisierte Step-Defs können später an E2E-Tests (`fineract-e2e-tests-*`) andocken; die Features selbst sind auch ohne Runner gültige Doku.

## Verzeichnisstruktur

```text
docs/gherkin/
├── README.md                 ← diese Datei
└── features/
    ├── loan/                 ← Kredit-Lifecycle
    ├── savings/              ← Spareinlagen
    ├── client/               ← Kunden
    ├── accounting/           ← Buchhaltung
    ├── osgi/                 ← OSGi-Modularität & KI
    ├── cob/                  ← Close of Business
    └── crosscutting/         ← Tenant, Security, Commands, Qualität
```

## Tag-Konventionen

| Tag-Muster | Bedeutung | Beispiel |
|------------|-----------|----------|
| `@arc42-NN` | Bezug zu arc42-Kapitel NN | `@arc42-04` |
| `@runtime-<name>` | Runtime-Szenario aus Kap. 4 | `@runtime-loan-creation` |
| `@adr-NNN` | Design Decision | `@adr-006` |
| `@quality-Q-…` | Quality Scenario aus Kap. 7 | `@quality-Q-CORR-1` |
| `@domain-<area>` | Fachdomäne | `@domain-loan` |
| `@wip` | noch nicht implementierungsreif | |
| `@manual` | vorerst manuelle Abnahme | |

Mehrere Tags pro Scenario sind erwünscht.

## Mapping: Feature → Architektur

| Feature-Datei | Primäres arc42 | Runtime / ADR / Quality |
|---------------|----------------|-------------------------|
| [loan/loan_creation.feature](features/loan/loan_creation.feature) | [04](../arc42/04_runtime_view.md), [03](../arc42/03_building_block_view.md) | Runtime 4.2 |
| [loan/loan_command_idempotency.feature](features/loan/loan_command_idempotency.feature) | [06](../arc42/06_crosscutting_concepts.md), [07](../arc42/07_quality_attributes.md) | Q-CORR-1, ADR-004 |
| [client/client_create.feature](features/client/client_create.feature) | [02](../arc42/02_context_and_scope.md), [03](../arc42/03_building_block_view.md) | Domain Client |
| [savings/savings_account_open.feature](features/savings/savings_account_open.feature) | [02](../arc42/02_context_and_scope.md), [03](../arc42/03_building_block_view.md) | Domain Savings |
| [accounting/loan_disbursement_journal.feature](features/accounting/loan_disbursement_journal.feature) | [03](../arc42/03_building_block_view.md), [07](../arc42/07_quality_attributes.md) | Korrektheit Buchungen |
| [osgi/optional_bundle_degradation.feature](features/osgi/optional_bundle_degradation.feature) | [04](../arc42/04_runtime_view.md), [08](../arc42/08_design_decisions.md) | Runtime 4.4, ADR-002, Q-EXT-2 |
| [osgi/ki_scoring_async.feature](features/osgi/ki_scoring_async.feature) | [04](../arc42/04_runtime_view.md), [06](../arc42/06_crosscutting_concepts.md) | Runtime 4.7, ADR-005/006, Q-REL-2 |
| [cob/close_of_business.feature](features/cob/close_of_business.feature) | [04](../arc42/04_runtime_view.md), [05](../arc42/05_deployment_view.md) | Runtime 4.6, ADR-007/012 |
| [crosscutting/multi_tenant_isolation.feature](features/crosscutting/multi_tenant_isolation.feature) | [06](../arc42/06_crosscutting_concepts.md), [07](../arc42/07_quality_attributes.md) | Runtime 4.5, Q-SEC-1, ADR-008 |
| [crosscutting/security_authentication.feature](features/crosscutting/security_authentication.feature) | [06](../arc42/06_crosscutting_concepts.md), [07](../arc42/07_quality_attributes.md) | Q-SEC-2, ADR-013 |
| [crosscutting/command_processing.feature](features/crosscutting/command_processing.feature) | [04](../arc42/04_runtime_view.md), [06](../arc42/06_crosscutting_concepts.md) | Runtime 4.3, ADR-004 |
| [crosscutting/node_modes.feature](features/crosscutting/node_modes.feature) | [05](../arc42/05_deployment_view.md), [08](../arc42/08_design_decisions.md) | ADR-007, Q-SCALE-* |

### Mapping: Quality Scenario → Feature

| Quality-ID ([Kap. 7](../arc42/07_quality_attributes.md)) | Feature / Scenario-Tag |
|----------------------------------------------------------|------------------------|
| Q-CORR-1 | `@quality-Q-CORR-1` in loan_command_idempotency |
| Q-CORR-2 | `@quality-Q-CORR-2` in command_processing |
| Q-SEC-1 | `@quality-Q-SEC-1` in multi_tenant_isolation |
| Q-SEC-2 | `@quality-Q-SEC-2` in security_authentication |
| Q-REL-1 | `@quality-Q-REL-1` in close_of_business |
| Q-REL-2 | `@quality-Q-REL-2` in ki_scoring_async |
| Q-EXT-1 / Q-EXT-2 | osgi/* features |
| Q-PERF-1 | `@quality-Q-PERF-1` in loan_creation (manuell/messbar) |

## Schreibregeln

1. **Ein Feature = ein zusammenhängendes Verhalten**, kein ganzes Modul.
2. Scenarios sind **testbar** formuliert (API-/Ops-Sicht), ohne UI-Details (headless, [ADR-010](../arc42/08_design_decisions.md)).
3. Jedes Scenario hat mindestens **ein** `@arc42-*` Tag.
4. Bei Architekturänderung: Feature **und** arc42-Querverweis aktualisieren.
5. Sprache: Deutsch (wie arc42); technische Identifier auf Englisch (`POST /loans`, Statuscodes).

## Ausführung (später)

```text
# Beispiel – sobald Step-Defs existieren:
# ./gradlew :fineract-e2e-tests-runner:cucumber \
#   -Dcucumber.features=docs/gherkin/features
```

Aktuell: **spezifizierend**, nicht zwingend an CI gebunden (`@manual` / `@wip` wo nötig).

## Pflege

| Wer | Tut was |
|-----|---------|
| Feature-Dev | Scenario ergänzen + Tag auf Runtime/ADR |
| Architektur | Mapping-Tabelle in diesem README pflegen |
| Ops | node_modes / cob Features bei Topologie-Änderungen |

---

*Architektur*: [../arc42/README.md](../arc42/README.md) · *Glossar*: [../arc42/09_glossary.md](../arc42/09_glossary.md)
