# language: de
@arc42-04 @arc42-06 @arc42-07 @arc42-08 @runtime-multi-tenant @adr-008 @quality-Q-SEC-1
Feature: Multi-Tenant-Isolation
  Als Plattformbetreiber
  möchte ich, dass Mandantendaten strikt getrennt sind
  damit kein Cross-Tenant-Zugriff auf Fachdaten möglich ist.

  # Architektur: docs/arc42/04_runtime_view.md §4.5
  # Crosscutting: docs/arc42/06_crosscutting_concepts.md §6.2
  # ADR-008, Quality Q-SEC-1

  Hintergrund:
    Angenommen Tenant "alpha" und Tenant "beta" sind provisioniert
    Und in Tenant "alpha" existiert Client "C-Alpha"
    Und in Tenant "beta" existiert Client "C-Beta"

  Szenario: Request arbeitet nur im aufgelösten Tenant
    Angenommen ich bin als Benutzer von Tenant "alpha" authentifiziert
    Wenn ich die Client-Ressource von "C-Alpha" lese
    Dann ist die HTTP-Antwort erfolgreich
    Und die Daten gehören zu Tenant "alpha"

  Szenario: Cross-Tenant-Read wird verweigert
    Angenommen ich bin als Benutzer von Tenant "alpha" authentifiziert
    Wenn ich versuche, Client "C-Beta" von Tenant "beta" zu lesen
    Dann ist die HTTP-Antwort 403 oder 404
    Und es werden keine Fachdaten von Tenant "beta" zurückgegeben

  Szenario: Context wird nach Request geleert
    Angenommen ein Request für Tenant "alpha" wurde verarbeitet
    Wenn derselbe Worker-Thread einen Request für Tenant "beta" verarbeitet
    Dann ist kein Restkontext von Tenant "alpha" aktiv
    Und DataSource-Routing zeigt auf Tenant "beta"
