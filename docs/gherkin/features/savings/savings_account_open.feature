# language: de
@arc42-02 @arc42-03 @domain-savings
Feature: Sparkonto eröffnen
  Als Back-Office-Benutzer
  möchte ich ein Sparkonto für einen Kunden eröffnen
  damit Einzahlungen und Zinsprozesse möglich sind.

  # Architektur: docs/arc42/02_context_and_scope.md, docs/arc42/03_building_block_view.md (fineract-savings)

  Hintergrund:
    Angenommen der Tenant "default" ist provisioniert
    Und ein Benutzer mit Permission zum Anlegen von Savings Accounts ist authentifiziert
    Und ein aktiver Client und ein aktives Savings Product existieren

  Szenario: Erfolgreiche Kontoeröffnung
    Wenn ich die API zum Anlegen eines Savings Accounts mit gültigen Daten aufrufe
    Dann ist die HTTP-Antwort 200 oder 201
    Und die Antwort enthält eine Savings-Account-ID
    Und das Konto ist in der Tenant-Datenbank gespeichert
    Und ein Command-Audit-Eintrag existiert mit Status "PROCESSED"

  Szenario: Eröffnung ohne gültigen Client schlägt fehl
    Wenn ich ein Savings Account für eine unbekannte Client-ID anlege
    Dann ist die HTTP-Antwort 400 oder 404
    Und es wurde kein Sparkonto angelegt
