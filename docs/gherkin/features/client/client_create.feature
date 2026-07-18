# language: de
@arc42-02 @arc42-03 @domain-client
Feature: Kunde anlegen
  Als Back-Office-Benutzer
  möchte ich einen Kunden (Client) anlegen
  damit Kredite und Spareinlagen einem Party-Stamm zugeordnet werden können.

  # Architektur: docs/arc42/02_context_and_scope.md, docs/arc42/03_building_block_view.md

  Hintergrund:
    Angenommen der Tenant "default" ist provisioniert
    Und ein Benutzer mit Permission "CREATE_CLIENT" ist authentifiziert

  Szenario: Erfolgreiche Kundenanlage
    Wenn ich "POST /clients" mit gültigen Stammdaten sende
    Dann ist die HTTP-Antwort 200 oder 201
    Und die Antwort enthält eine Client-Resource-ID
    Und der Kunde ist im Status aktiv oder pending gemäß Produktkonfiguration
    Und ein Command-Audit-Eintrag existiert

  Szenario: Pflichtfeld fehlt
    Wenn ich "POST /clients" ohne erforderlichen Anzeigenamen sende
    Dann ist die HTTP-Antwort 400
    Und es wurde kein neuer Kunde angelegt
