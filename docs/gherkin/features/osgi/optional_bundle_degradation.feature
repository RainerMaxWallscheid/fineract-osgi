# language: de
@arc42-04 @arc42-08 @arc42-06 @runtime-osgi-lifecycle @adr-002 @quality-Q-EXT-2
Feature: Optionale OSGi-Bundles – Degradation
  Als Betreiber
  möchte ich, dass der Core ohne optionale Feature-Bundles weiterläuft
  damit Hot-Deploy und fehlende Extensions keinen Totalausfall erzeugen.

  # Architektur: docs/arc42/04_runtime_view.md §4.4
  # ADR: docs/arc42/08_design_decisions.md ADR-002
  # Qualität: Q-EXT-2

  Hintergrund:
    Angenommen die Anwendung läuft mit Equinox-OSGi-Runtime
    Und der Core-Banking-Pfad ist aktiv (Write enabled)

  Szenario: Kreditanlage ohne optionales Extension-Bundle
    Angenommen das Bundle "dynamic-product-config" ist nicht installiert
    Wenn ein autorisierter Benutzer einen gültigen Kredit anlegt
    Dann ist die Anlage erfolgreich
    Und es werden nur die Core-Validierungsregeln angewendet

  Szenario: Bundle-Stop zur Laufzeit unbindet den Service
    Angenommen das Bundle "dynamic-product-config" ist aktiv und bound
    Wenn das Bundle gestoppt wird
    Dann ist der zugehörige OSGi-Service nicht mehr in der Registry
    Und nachfolgende Core-Requests nutzen den Default-Pfad ohne Hard-Fail

  @quality-Q-SEC-3 @manual
  Szenario: Untrusted Bundle-Install ist in Produktion unterbunden
    Angenommen die Produktions-Policy erlaubt nur signierte Bundles
    Wenn versucht wird, ein unsigniertes Bundle zu installieren
    Dann wird die Installation abgelehnt oder verhindert
    Und der Core-Zustand bleibt unverändert
