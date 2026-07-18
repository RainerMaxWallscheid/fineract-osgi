# language: de
@arc42-06 @arc42-07 @domain-loan @quality-Q-CORR-1 @adr-004
Feature: Idempotente Kredit-Commands
  Als Integrator
  möchte ich bei Netz-Retries denselben Write nicht doppelt ausführen
  damit Salden und Anträge integer bleiben.

  # Architektur: docs/arc42/06_crosscutting_concepts.md §6.4
  # Qualität: docs/arc42/07_quality_attributes.md Q-CORR-1

  Hintergrund:
    Angenommen der Tenant "default" ist provisioniert
    Und ein Benutzer mit Permission "CREATE_LOAN" ist authentifiziert
    Und ein aktives Loan Product und ein aktiver Client existieren

  Szenario: Doppelter Submit mit gleichem Idempotency-Key
    Angenommen ich sende "POST /loans" mit Idempotency-Key "loan-create-42" erfolgreich
    Wenn ich denselben "POST /loans" mit Idempotency-Key "loan-create-42" erneut sende
    Dann erhalte ich dasselbe fachliche Ergebnis wie beim ersten Aufruf
    Und es existiert genau ein Kredit zu diesem Antrag
    Und kein zweiter erfolgreicher Create-Command wurde persistiert

  Szenario: Gleicher Payload mit anderem Idempotency-Key erzeugt getrennte Attempts
    Angenommen ich sende "POST /loans" mit Idempotency-Key "key-A" erfolgreich
    Wenn ich denselben Payload mit Idempotency-Key "key-B" sende
    Dann wird die Anfrage als neuer Command behandelt
    # Fachliche Eindeutigkeitsregeln des Produkts können den zweiten Create trotzdem ablehnen
