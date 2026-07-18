# language: de
@arc42-05 @arc42-08 @arc42-07 @adr-007 @domain-ops
Feature: Node-Rollen (Read / Write / Batch)
  Als Betreiber
  möchte ich Instanzen über Mode-Flags rollenspezifisch betreiben
  damit API- und COB-Last getrennt skaliert werden können.

  # Deployment: docs/arc42/05_deployment_view.md §5.3
  # ADR-007

  Szenario: Write-Node akzeptiert Commands
    Angenommen FINERACT_MODE_WRITE_ENABLED ist true
    Und FINERACT_MODE_READ_ENABLED ist true
    Wenn ein autorisierter Write-Request eintrifft
    Dann wird der Command-Pfad ausgeführt

  Szenario: Read-only-Node lehnt Writes ab oder bietet sie nicht an
    Angenommen FINERACT_MODE_WRITE_ENABLED ist false
    Und FINERACT_MODE_READ_ENABLED ist true
    Wenn ein Write-Request eintrifft
    Dann wird der Write nicht fachlich ausgeführt
    Und lesende API-Aufrufe bleiben möglich

  Szenario: Batch-Worker ohne Liquibase
    Angenommen der Node ist Batch-Worker
    Und FINERACT_LIQUIBASE_ENABLED ist false
    Wenn der Node startet
    Dann führt er keine Schema-Migration aus
    Und er kann Job-Partitionen verarbeiten sobald der Manager sie verteilt

  Szenario: Genau ein aktiver Batch-Manager
    Angenommen die Topologie sieht einen Batch-Manager vor
    Wenn ein zweiter Node fälschlich als Manager startet
    Dann ist das ein Betriebsfehler gemäß Runbook
    # Architekturforderung: Split-Brain vermeiden – Erkennung/Alerting @manual
    Und Alarme oder Checks sollen die Doppel-Manager-Situation melden
