# Architecture Decision Records (ADRs)

Einzelne Architekturentscheidungen für **fineract-osgi**. Übersicht und Format: [../08_design_decisions.md](../08_design_decisions.md).

| ADR | Datei |
|-----|-------|
| ADR-001 | [ADR-001-fork-fineract-osgi-statt-pure-upstream.md](ADR-001-fork-fineract-osgi-statt-pure-upstream.md) |
| ADR-002 | [ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md](ADR-002-osgi-equinox-fuer-laufzeitmodularitaet.md) |
| ADR-003 | [ADR-003-spring-boot-gradle-module-als-kern-beibehalten.md](ADR-003-spring-boot-gradle-module-als-kern-beibehalten.md) |
| ADR-004 | [ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md) |
| ADR-005 | [ADR-005-externe-ki-xai-grok-statt-embedded-ml.md](ADR-005-externe-ki-xai-grok-statt-embedded-ml.md) |
| ADR-006 | [ADR-006-ki-default-asynchron-fail-open.md](ADR-006-ki-default-asynchron-fail-open.md) |
| ADR-007 | [ADR-007-node-rollen-read-write-batch.md](ADR-007-node-rollen-read-write-batch.md) |
| ADR-008 | [ADR-008-multi-tenancy-mit-getrennten-tenant-datenbanken.md](ADR-008-multi-tenancy-mit-getrennten-tenant-datenbanken.md) |
| ADR-009 | [ADR-009-postgresql-als-primaere-datenbank-fuer-fineract-osgi.md](ADR-009-postgresql-als-primaere-datenbank-fuer-fineract-osgi.md) |
| ADR-010 | [ADR-010-headless-rest-api-keine-ui-im-scope.md](ADR-010-headless-rest-api-keine-ui-im-scope.md) |
| ADR-011 | [ADR-011-container-first-deployment-compose-kubernetes.md](ADR-011-container-first-deployment-compose-kubernetes.md) |
| ADR-012 | [ADR-012-messaging-fuer-verteilte-jobs-kafka-jms-optional.md](ADR-012-messaging-fuer-verteilte-jobs-kafka-jms-optional.md) |
| ADR-013 | [ADR-013-sicherheit-am-api-rand-defense-in-depth.md](ADR-013-sicherheit-am-api-rand-defense-in-depth.md) |
| ADR-014 | [ADR-014-arc42-gherkin-als-doku-strategie.md](ADR-014-arc42-gherkin-als-doku-strategie.md) |
| ADR-015 | [ADR-015-api-dtos-composition-statt-vererbung.md](ADR-015-api-dtos-composition-statt-vererbung.md) |
| ADR-016 | [ADR-016-jpa-ausbau-read-write-persistenz.md](ADR-016-jpa-ausbau-read-write-persistenz.md) |
| ADR-017 | [ADR-017-hexagonale-architektur.md](ADR-017-hexagonale-architektur.md) |
| ADR-018 | [ADR-018-clean-code.md](ADR-018-clean-code.md) |
| ADR-019 | [ADR-019-domain-driven-design.md](ADR-019-domain-driven-design.md) |
| ADR-020 | [ADR-020-event-sourcing-writes-pflicht.md](ADR-020-event-sourcing-writes-pflicht.md) |
| ADR-021 | [ADR-021-modul-kommunikation-nur-ueber-module-api.md](ADR-021-modul-kommunikation-nur-ueber-module-api.md) |

## Neues ADR anlegen

1. Datei `ADR-NNN-kurzslug.md` in diesem Ordner (nächste freie Nummer).
2. Format wie bestehende ADRs (Status, Kontext, Entscheidung, Alternativen, Konsequenzen, Bezug).
3. Eintrag in [../08_design_decisions.md](../08_design_decisions.md) (Übersichtstabelle, Matrix, ggf. Mermaid).
4. Querverweise aus Runtime/Crosscutting/Quality setzen.
