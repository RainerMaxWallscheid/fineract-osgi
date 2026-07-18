# language: de
@arc42-04 @arc42-06 @arc42-08 @runtime-command-processing @adr-004
Feature: Command Processing (CQRS Write-Pfad)
  Als Entwickler und Integrator
  möchte ich, dass schreibende API-Aufrufe über die Command-Pipeline laufen
  damit Audit, Validierung und (künftig) der neue Stack konsistent greifen.

  # Runtime: docs/arc42/04_runtime_view.md §4.3
  # Crosscutting: docs/arc42/06_crosscutting_concepts.md §6.4
  # ADR-004

  Hintergrund:
    Angenommen der Tenant "default" ist provisioniert
    Und ein autorisierter Benutzer ist authentifiziert

  Szenario: Write erzeugt Command-Audit
    Wenn ich einen erfolgreichen Write-Command über die REST-API ausführe
    Dann existiert ein Eintrag im Command-Audit
    Und der Status ist "PROCESSED"
    Und Benutzer und Zeitstempel sind nachvollziehbar

  @quality-Q-CORR-2
  Szenario: Domain-Fehler führt zu Rollback und ERROR-Audit
    Wenn ein Write-Command nach Validierung in der Domain fehlschlägt
    Dann ist die HTTP-Antwort ein fachlicher Fehler
    Und fachliche Side-Effects der Transaktion sind zurückgerollt
    Und der Command-Status ist "ERROR" oder äquivalent auditiert

  Szenario: Maker-Checker hält Command auf Freigabe
    Angenommen Maker-Checker ist für die Aktion aktiv
    Wenn ein Maker den Command einreicht
    Dann ist der Command noch nicht final fachlich angewendet
    Und der Status wartet auf Checker-Freigabe
    Wenn ein Checker freigibt
    Dann wird die Domain-Änderung angewendet
    Und der Command-Status ist "PROCESSED"

  @wip
  Szenario: Migriertes Modul nutzt fineract-command Dispatcher
    Angenommen das Modul ist auf den neuen Command-Stack migriert
    Wenn ein Write über die stabile REST-API erfolgt
    Dann wird der Command über CommandDispatcher verarbeitet
    Und der externe REST-Vertrag bleibt unverändert
