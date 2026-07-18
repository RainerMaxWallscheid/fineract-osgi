# language: de
@arc42-04 @arc42-06 @arc42-08 @runtime-ki-analysis @adr-005 @adr-006 @domain-loan
Feature: Asynchrones KI-Scoring
  Als Institut
  möchte ich Kreditanträge optional per externer KI anreichern
  ohne den Write-Hot-Path zu blockieren oder bei KI-Ausfall zu verlieren.

  # Architektur: docs/arc42/04_runtime_view.md §4.7
  # Crosscutting: docs/arc42/06_crosscutting_concepts.md §6.8
  # ADR-005 Externe KI, ADR-006 Async + Fail-Open

  Hintergrund:
    Angenommen der Tenant "default" ist provisioniert
    Und das OSGi-Bundle "ki-scoring" implementiert "CreditScoreProvider"
    Und ein autorisierter Benutzer kann Kredite anlegen

  @quality-Q-EXT-1
  Szenario: Score wird nach erfolgreicher Anlage asynchron angereichert
    Angenommen die xAI-Grok-API ist erreichbar
    Wenn ein Kredit erfolgreich angelegt wird
    Dann ist die HTTP-Antwort der Anlage sofort erfolgreich
    Und nach Abschluss der asynchronen Verarbeitung ist ein Score am Kredit oder als Note gespeichert
    Und der Command-Status der Anlage ist "PROCESSED" unabhängig vom Score-Zeitpunkt

  @quality-Q-REL-2
  Szenario: KI-API-Ausfall lässt die Kreditanlage erfolgreich
    Angenommen die xAI-Grok-API antwortet mit Timeout oder 5xx
    Und die Policy ist Fail-Open
    Wenn ein Kredit angelegt wird
    Dann ist die HTTP-Antwort der Anlage erfolgreich
    Und der fehlgeschlagene KI-Aufruf ist in Logs oder Metriken sichtbar
    Und es wurde keine stille Buchungsänderung durch die KI vorgenommen

  Szenario: Sync Policy Gate nur wenn konfiguriert
    Angenommen das Produkt erzwingt ein synchrones Score-Gate mit Fail-Closed
    Und die KI-API ist nicht erreichbar
    Wenn eine Freigabe/Anlage über dieses Gate läuft
    Dann wird der Command abgelehnt oder wartet auf Policy-Fehler
    Und die Ablehnung ist auditierbar
