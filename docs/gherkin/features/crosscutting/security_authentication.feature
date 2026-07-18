# language: de
@arc42-06 @arc42-07 @arc42-08 @adr-013 @quality-Q-SEC-2
Feature: Authentifizierung an der API
  Als Security-Verantwortlicher
  möchte ich unauthentifizierte und unauthorisierte Zugriffe abweisen
  damit die API-Trust-Boundary gehalten wird.

  # Crosscutting: docs/arc42/06_crosscutting_concepts.md §6.3
  # ADR-013, Quality Q-SEC-2, SECURITY.md

  Szenario: Geschützte Resource ohne Credentials
    Wenn ich "GET /clients" ohne Authentifizierung sende
    Dann ist die HTTP-Antwort 401
    Und es werden keine Kundendaten zurückgegeben

  Szenario: Geschützte Resource mit ungültigem Token
    Wenn ich "GET /clients" mit ungültigem Bearer-Token sende
    Dann ist die HTTP-Antwort 401
    Und die Fehlermeldung enthält keine internen Stacktraces

  Szenario: Authentifiziert aber ohne Permission
    Angenommen ich bin gültig authentifiziert ohne Leserecht auf Clients
    Wenn ich "GET /clients" sende
    Dann ist die HTTP-Antwort 403

  @manual
  Szenario: OIDC-Login pro Tenant nutzt Tenant-IdP-Konfiguration
    Angenommen Tenant "alpha" hat einen eigenen OIDC-IdP konfiguriert
    Wenn ein Benutzer von Tenant "alpha" den OIDC-Flow durchläuft
    Dann wird die Tenant-spezifische IdP-Konfiguration verwendet
    Und bei Erfolg existiert ein Fineract-Security-Context für Tenant "alpha"
