# language: de
@arc42-04 @arc42-03 @domain-loan @runtime-loan-creation
Feature: Kredit anlegen (Loan Creation)
  Als Loan Officer oder Integrator
  möchte ich über die REST-API einen Kreditantrag anlegen
  damit der Write-Pfad (CQRS) den Antrag validiert, persistiert und auditiert.

  # Architektur: docs/arc42/04_runtime_view.md §4.2
  # Bausteine: docs/arc42/03_building_block_view.md (Loan, Command, Security)

  Hintergrund:
    Angenommen der Tenant "default" ist provisioniert
    Und ein Benutzer mit Permission "CREATE_LOAN" ist authentifiziert
    Und ein aktives Loan Product und ein aktiver Client existieren

  @quality-Q-PERF-1 @manual
  Szenario: Erfolgreiche Kreditanlage über POST /loans
    Wenn ich "POST /loans" mit gültigem Antrags-JSON sende
    Dann ist die HTTP-Antwort 200 oder 201
    Und die Antwort enthält eine Loan-Resource-ID
    Und ein Command-Audit-Eintrag existiert mit Status "PROCESSED"
    Und der Kredit ist in der Tenant-Datenbank gespeichert

  Szenario: Validierungsfehler verhindert Persistenz
    Wenn ich "POST /loans" mit ungültigem Betrag sende
    Dann ist die HTTP-Antwort 400
    Und es wurde kein neuer Kredit angelegt
    Und der Fehler ist als API-Validierungsfehler formuliert

  Szenario: Fehlende Permission wird abgelehnt
    Angenommen ich bin authentifiziert ohne Permission "CREATE_LOAN"
    Wenn ich "POST /loans" mit gültigem Antrags-JSON sende
    Dann ist die HTTP-Antwort 403
    Und es wurde kein neuer Kredit angelegt

  @adr-006
  Szenario: Optionale KI blockiert die Anlage nicht
    Angenommen das KI-Scoring-Bundle ist nicht installiert
    Wenn ich "POST /loans" mit gültigem Antrags-JSON sende
    Dann ist die HTTP-Antwort 200 oder 201
    Und der Kredit wurde ohne Score-Enrichment angelegt
