# language: de
@arc42-03 @arc42-07 @domain-accounting @domain-loan
Feature: Journalbuchungen bei Kreditauszahlung
  Als Accounting-Verantwortlicher
  möchte ich, dass eine Auszahlung korrekte Journal Entries erzeugt
  damit die Hauptbuch-Integrität gewahrt bleibt.

  # Architektur: docs/arc42/03_building_block_view.md (fineract-accounting, fineract-loan)
  # Qualität: docs/arc42/07_quality_attributes.md – Korrektheit & Integrität

  Hintergrund:
    Angenommen der Tenant "default" ist provisioniert
    Und Accounting ist für das Loan Product konfiguriert
    Und ein genehmigter Kredit wartet auf Auszahlung
    Und ein Benutzer mit Auszahlungs-Permission ist authentifiziert

  Szenario: Auszahlung erzeugt ausgewogene Journal Entries
    Wenn ich den Kredit erfolgreich auszahle
    Dann ist die HTTP-Antwort erfolgreich
    Und es existieren Journal Entries zur Auszahlung
    Und die Summe Soll entspricht der Summe Haben
    Und der Kreditstatus ist "Active" bzw. ausgezahlt

  @quality-Q-CORR-2
  Szenario: Fehlgeschlagene Auszahlung erzeugt keine halben Buchungen
    Angenommen die Auszahlung wird durch einen fachlichen Fehler abgebrochen
    Dann bleibt der Kredit im vorherigen Status
    Und es wurden keine unvollständigen Journal Entries committed
