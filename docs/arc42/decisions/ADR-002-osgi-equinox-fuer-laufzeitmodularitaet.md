# ADR-002 – OSGi (Equinox) für Laufzeitmodularität

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Extensibility, Maintainability, Deployability |

### Kontext

Gradle-Module strukturieren den Build, erlauben aber kein **dynamisches** Aktivieren/Ersetzen von Features (KI, instituts-spezifische Regeln) zur Laufzeit. Kunden sollen Erweiterungen laden können, ohne den Core neu zu bauen.

### Entscheidung

**OSGi** als Modularitätsmodell einführen; als Framework **Eclipse Equinox** (siehe `osgi/`, `docs/arc42/osgi.gradle`).

Prinzipien:

1. Feature-Implementierungen als **Bundles**  
2. Verträge als exportierte **Service-Interfaces**  
3. Core nutzt Services **optional** (Service Registry / Tracker)  
4. Fehlt ein Bundle → **Degradation**, kein Totalausfall  

### Alternativen

| Option | Bewertung |
|--------|-----------|
| **Apache Felix** | Valide; Equinox wegen Tooling/Console/Enterprise-Nähe bevorzugt |
| **Apache Karaf** | Mehr Ops-Komfort, aber schwergewichtigere Plattform; später optional als Distribution |
| **PF4J / Spring Plugin** | Leichter, aber schwächere Isolation/Versionierung als OSGi |
| **Microservices pro Feature** | Maximale Isolation, aber Ops- und Transaktionskomplexität für Core Banking zu hoch |
| **Nur Gradle-Module** | Unzureichend für Hot-Deploy und kunden-spezifische Binaries |

### Konsequenzen

- **+** Hot-Deploy, klare API/Impl-Trennung, kunden-spezifische Bundles  
- **+** Unterstützt Qualitätsziel Erweiterbarkeit ([Q-EXT-*](../07_quality_attributes.md))  
- **−** Bundle-Lifecycle, Package-Exports, Versionsdisziplin  
- **−** Lernkurve; Equinox Console muss gehärtet werden (Port 2501)  
- **−** Cluster: gleiche Bundle-Versionen auf allen Nodes  

### Bezug

- Runtime [4.4](../04_runtime_view.md), Deployment [5.7](../05_deployment_view.md), Crosscutting [6.7](../06_crosscutting_concepts.md)

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
