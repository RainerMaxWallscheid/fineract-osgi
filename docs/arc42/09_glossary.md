# 9. Glossary

Begriffsverzeichnis für die arc42-Dokumentation von **fineract-osgi**. Einträge sind alphabetisch (deutsch/englisch gemischt, wie in den Kapiteln verwendet). Fachliche Fineract-Begriffe und Architekturkürzel stehen gleichberechtigt.

**Legende**

| Kürzel | Bedeutung |
|--------|-----------|
| *A* | Architektur / arc42 |
| *B* | Betrieb / Deployment |
| *F* | Fachlichkeit Core Banking |
| *T* | Technik / Framework |

Verweise auf Kapitel: [01](01_introduction.md)–[08](08_design_decisions.md).

---

## 9.1 A–C

| Begriff | Tag | Definition |
|---------|:---:|------------|
| **Actuator** | T | Spring-Boot-Endpunkte für Health, Metrics u. a. (`/fineract-provider/actuator/...`). Genutzt für K8s-Probes. → [05](05_deployment_view.md) |
| **ADR** | A | *Architecture Decision Record* – dokumentierte Designentscheidung (Kapitel 8, ADR-light). → [08](08_design_decisions.md) |
| **All-in-One** | B | Deployment-Topologie, in der Read, Write, Batch-Manager und Worker in **einem** Prozess aktiv sind. → [05](05_deployment_view.md) |
| **AppUser** | F/T | Authentifizierter Back-Office-Benutzer in Fineract; Berechtigungen über Rollen/Permissions. |
| **arc42** | A | Vorlage zur Architekturdokumentation (Kontext, Bausteine, Runtime, Deployment, Qualität, ADRs, …). |
| **Audit / Command Audit** | F/T | Nachvollziehbare Aufzeichnung von Write-Operationen, typisch in `m_portfolio_command_source`. → [06](06_crosscutting_concepts.md) |
| **AuthN / AuthZ** | T | *Authentication* (wer?) bzw. *Authorization* (darf?). → [06](06_crosscutting_concepts.md) |
| **Batch Manager** | B | Node-Rolle, die Jobs (z. B. COB) plant und partitioniert (`batch-manager-enabled`). Genau ein aktiver Manager pro Cluster. → [05](05_deployment_view.md) |
| **Batch Worker** | B | Node-Rolle, die Job-Partitionen ausführt (`batch-worker-enabled`). Horizontal skalierbar. → [05](05_deployment_view.md) |
| **Bundle (OSGi)** | T | Installierbare OSGi-Einheit (JAR) mit Manifest, Lifecycle und optionalen Services. → [04](04_runtime_view.md), [05](05_deployment_view.md) |
| **Business Date** | F | Fachliches Geschäftstag-Datum eines Tenants; steuert u. a. Buchungslogik und COB. Filter: `BusinessDateFilter`. |
| **Business Event** | T | Domänenereignis nach fachlicher Änderung (z. B. Loan created); intern oder als External Event. → [06](06_crosscutting_concepts.md) |
| **Business Step** | F/T | Einzelner Schritt in einer COB-/Job-Pipeline (z. B. Accrual, Penalty). |
| **Circuit Breaker** | T | Resilience-Muster: unterbindet Calls zu einem fehlerhaften Downstream (z. B. KI-API) temporär. |
| **COB** | F | *Close of Business* – periodischer Tagesabschluss (Zinsen, Penalties, Status etc.), oft partitioniert. → [04](04_runtime_view.md) |
| **Command** | T | Schreibanweisung im CQRS-Modell; Legacy als `CommandWrapper`/`JsonCommand`, neu als typsicheres `Command<REQ>`. |
| **Command Dispatcher** | T | Komponente im Modul `fineract-command`, die Commands an Handler routet (sync/async/Disruptor). → [04](04_runtime_view.md) |
| **Command Handler** | T | Führt die fachliche Write-Logik für einen Command-Typ aus (`NewCommandSourceHandler` bzw. `CommandHandler<REQ,RES>`). |
| **Command Hook** | T | Vor-/Nach-/Fehler-Callback um die Command-Ausführung (z. B. Username, Timestamp). |
| **Compatibility** | A | Qualitätsziel: stabile REST-Verträge trotz interner Migration. → [07](07_quality_attributes.md) |
| **Correlation-ID** | B/T | Request-übergreifende Trace-ID (Header z. B. `X-Correlation-ID`) für Logs und Support. → [06](06_crosscutting_concepts.md) |
| **CQRS** | A/T | *Command Query Responsibility Segregation* – Trennung von Schreib- und Lesepfaden. → [06](06_crosscutting_concepts.md), [08](08_design_decisions.md) |

---

## 9.2 D–F

| Begriff | Tag | Definition |
|---------|:---:|------------|
| **DataSource Routing** | T | Auswahl der JDBC-Connection anhand des aktuellen Tenant-Contexts. |
| **Defense in Depth** | A | Mehrschichtige Sicherheit (TLS/Proxy, AuthN/Z, Tenant, Audit). → [08](08_design_decisions.md) |
| **Degradation** | A | Kontrolliertes Weiterlaufen ohne optionales Feature (z. B. KI-Bundle fehlt). → [04](04_runtime_view.md) |
| **Deployable** | B | Laufzeit-Artefakt (Container-Image, JAR, Bundle), das auf Infrastruktur ausgerollt wird. → [05](05_deployment_view.md) |
| **Disruptor** | T | LMAX Disruptor – optionale hochperformante, non-blocking Command-Dispatcher-Variante. |
| **Docker Compose** | B | Orchestrierung lokaler Multi-Container-Setups; Referenzdateien `docker-compose*.yml`. → [05](05_deployment_view.md) |
| **DTO** | T | *Data Transfer Object* – typisierte Nutzlast zwischen API, Command und Domain (Ziel des neuen Command-Stacks). |
| **Equinox** | T | Eclipse OSGi-Framework, in fineract-osgi als OSGi-Runtime vorgesehen. → [05](05_deployment_view.md), [08](08_design_decisions.md) |
| **External Event** | T | Für Systeme außerhalb des Prozesses publiziertes Ereignis (Kafka/JMS). |
| **Fail-Closed** | A | Bei Fehler/Timeout des Downstream (z. B. KI) wird die Operation **abgelehnt**. → [06](06_crosscutting_concepts.md) |
| **Fail-Open** | A | Bei Fehler/Timeout läuft die Kernoperation **weiter** (Default für async KI). → [08](08_design_decisions.md) |
| **Feature Bundle** | T | OSGi-Bundle mit optionaler Fach-/Integrationsfunktion (KI, Produktregeln, …). |
| **fineract-command** | T | Modul für den modernen, typsicheren Command-Stack parallel zur Legacy-Pipeline. |
| **fineract-osgi** | A | Dieser Arbeitsstrang/Fork: Fineract-Kern + OSGi-Modularität + KI-Erweiterbarkeit. → [01](01_introduction.md) |
| **fineract-provider** | T | Haupt-Application-Modul (Boot, REST, Verdrahtung der Domain-Module). |
| **fineract_tenants** | T | Registry-Datenbank/-schema mit Tenant-Metadaten und Connection-Infos. → [05](05_deployment_view.md) |

---

## 9.3 G–L

| Begriff | Tag | Definition |
|---------|:---:|------------|
| **Gherkin** | A | BDD-Notation (Given/When/Then); Anforderungsartefakte unter [`docs/gherkin/`](../gherkin/README.md), getaggt mit `@arc42-*` / `@adr-*` / `@quality-Q-*`. → [08](08_design_decisions.md) |
| **HikariCP** | T | JDBC-Connection-Pool von Fineract; Konfiguration über `FINERACT_HIKARI_*`. |
| **Hook** | T | Konfigurierbare Integration/Webhook auf Business Events; auch Command Hooks im neuen Stack. |
| **Hot-Deploy** | B | Nachladen/Aktualisieren von OSGi-Bundles ohne vollständigen App-Rebuild. |
| **Hot-Path** | A | Latenzkritischer Request-Pfad (typisch synchrone Writes) – KI default **nicht** sync darauf. → [07](07_quality_attributes.md) |
| **Idempotency Key** | T | Client-seitiger Schlüssel, der Wiederholungen desselben Writes entdoppelt. → [06](06_crosscutting_concepts.md) |
| **IdP** | T | *Identity Provider* – externe Authentisierungsquelle (OIDC). |
| **Jakarta Validation** | T | Bean-Validation-Annotationsmodell für DTO-Constraints im neuen Command-Stack. |
| **Job Partition** | B/T | Teilmenge der COB-/Batch-Arbeit, die ein Worker übernimmt. |
| **JsonCommand** | T | Legacy-Command-Nutzlast als geparstes JSON mit String-Keys. |
| **JWT** | T | *JSON Web Token* – oft Träger der OIDC-/OAuth2-Identität. |
| **Kubernetes (K8s)** | B | Container-Orchestrierung; Beispielmanifeste unter `kubernetes/`. → [05](05_deployment_view.md) |
| **Legacy Command Pipeline** | T | Bisheriger Write-Pfad über `PortfolioCommandSourceWritePlatformService` / `SynchronousCommandProcessingService`. |
| **Liquibase** | T | Schema-Migrations-Tool; typisch nur auf führendem/Manager-Node aktiv, Worker oft deaktiviert. |
| **Loan Application** | F | Kreditantrag/-konto im Portfolio-Modul; zentrales Runtime-Beispiel. → [04](04_runtime_view.md) |
| **Liveness / Readiness** | B | Health-Proben: Prozess lebt bzw. darf Traffic erhalten. |

---

## 9.4 M–O

| Begriff | Tag | Definition |
|---------|:---:|------------|
| **Maker-Checker** | F | Vier-Augen-Prinzip: Command wartet auf Freigabe, bevor die Fachpersistenz final wird. → [06](06_crosscutting_concepts.md) |
| **MDC** | T | *Mapped Diagnostic Context* – kontextuelle Log-Felder (Tenant, Correlation-ID, …). |
| **Mode Flags** | B | Schalter `fineract.mode.read/write/batch-*-enabled` zur Rollensteuerung eines Nodes. → [05](05_deployment_view.md) |
| **Multi-Tenancy** | A/F | Ein Deployment bedient viele Institute (Tenants) mit isolierten Daten/Kontexten. → [06](06_crosscutting_concepts.md) |
| **Node ID** | B | `FINERACT_NODE_ID` – eindeutige Kennung einer Instanz im Cluster. |
| **Observability** | B | Fähigkeit, Zustand über Logs, Metrics und Traces zu erkennen. → [06](06_crosscutting_concepts.md), [07](07_quality_attributes.md) |
| **OIDC** | T | *OpenID Connect* – Authentisierungsprotokoll auf OAuth2; in Fineract tenant-fähig konfigurierbar. |
| **OpenAPI** | T | Spezifikation der REST-API; Basis für `fineract-client` und Vertragstests. |
| **Operability** | A | Qualitätsziel: Betreibbarkeit, Diagnose, Deploy. → [07](07_quality_attributes.md) |
| **OSGi** | T | *Open Services Gateway initiative* – Modularitäts- und Service-Framework-Standard. → [08](08_design_decisions.md) |
| **OSGi Service Registry** | T | Laufzeitverzeichnis, in dem Bundles Services publizieren und konsumieren. |
| **OTLP** | T | *OpenTelemetry Protocol* – Export von Traces/Metrics (z. B. nach Tempo). |
| **Outbox Pattern** | T | Zuverlässiges Publizieren von Events über eine DB-Tabelle + Dispatcher (offener Punkt). → [06](06_crosscutting_concepts.md) |

---

## 9.5 P–S

| Begriff | Tag | Definition |
|---------|:---:|------------|
| **Permission** | F | Feingranulares Recht, das Rollen zugewiesen und vor Commands geprüft wird. |
| **Platform Security Context** | T | Laufzeitkontext des aktuellen Benutzers und seiner Rechte. |
| **Policy Gate** | A | Synchrone Entscheidungsstelle (z. B. KI-Score) vor Fortsetzung eines Commands. → [04](04_runtime_view.md) |
| **PostgreSQL** | B | Primäre Zieldatenbank in der fineract-osgi-Referenzarchitektur. → [08](08_design_decisions.md) |
| **Quality Scenario** | A | Messbares Qualitätsszenario (Stimulus, Umgebung, Response, Maß). → [07](07_quality_attributes.md) |
| **Read Node** | B | Instanz mit `read-enabled` (und typisch ohne Write/Batch), für Queries/Reports. |
| **Remote Job Message Handler** | T | Mechanismus zur Verteilung von Job-Arbeit (Spring Events, JMS oder Kafka). |
| **Reverse Proxy / WAF** | B | Empfohlene Schicht vor der API (TLS-Terminierung, DDoS, Routing). → [`SECURITY.md`](../../SECURITY.md) |
| **RPO / RTO** | B | *Recovery Point/Time Objective* – maximal tolerierter Datenverlust bzw. Wiederanlaufzeit. → [07](07_quality_attributes.md) |
| **Runtime View** | A | arc42-Sicht auf dynamische Abläufe und Szenarien. → [04](04_runtime_view.md) |
| **SACCO** | F | *Savings and Credit Cooperative* – typische Nutzergruppe im Microfinance-Kontext. → [02](02_context_and_scope.md) |
| **Service Tracker** | T | OSGi-Hilfe zum Verfolgen von Service-Verfügbarkeit (bind/unbind). |
| **SLO** | B | *Service Level Objective* – angestrebte Betriebszielgröße (Latenz, Verfügbarkeit). → [07](07_quality_attributes.md) |
| **Spring Boot** | T | Application-Framework des Fineract-Kerns; bleibt laut ADR-003 erhalten. → [08](08_design_decisions.md) |
| **Spring Events** | T | In-Process-Events; Default für lokale Job-Verteilung ohne Broker. |
| **SynchronousCommandProcessingService** | T | Zentrale Legacy-Komponente zur synchronen Command-Ausführung. |
| **Tenant** | F | Logisches Institut/Mandant mit eigener Fachdatenbank und Konfiguration. |

---

## 9.6 T–Z

| Begriff | Tag | Definition |
|---------|:---:|------------|
| **Tenant Context** | T | Thread-/Request-gebundene Mandanteninformation (ID, DS, Timezone, User, Business Date). |
| **ThreadLocalContext** | T | Halter des Tenant-/Request-Contexts; muss nach Request/Job geleert werden. → [06](06_crosscutting_concepts.md) |
| **Trust Boundary** | A | Grenze zwischen vertrauenswürdig und nicht vertrauenswürdig (primär HTTPS-API). → [`SECURITY.md`](../../SECURITY.md) |
| **Two-Factor (2FA)** | T | Zweite Authentisierungsstufe (OTP etc.) zusätzlich zu Passwort/OIDC. |
| **Write Node** | B | Instanz mit `write-enabled` für CQRS-Commands. |
| **xAI Grok API** | T | Externe KI-Inferenz-API; Referenz-Integration für Scoring/Analyse-Bundles. → [06](06_crosscutting_concepts.md), [08](08_design_decisions.md) |

---

## 9.7 Module & Artefakte (Repo-Orientierung)

| Name | Kurzbeschreibung |
|------|------------------|
| `fineract-provider` | Bootable Server, REST, Verdrahtung |
| `fineract-core` | Infrastruktur, Legacy Commands, gemeinsame Kernteile |
| `fineract-command` | Neuer Command-Stack |
| `fineract-command-async` / `-disruptor` / `-jdbc` / `-audit` | Optionale Command-Implementierungsvarianten |
| `fineract-loan` / `fineract-savings` / `fineract-accounting` / … | Domänenmodule |
| `fineract-security` | AuthN/Z, Tenant-Filter, OIDC, 2FA |
| `fineract-validation` | Validierungsunterstützung |
| `fineract-cob` | COB-nahe Komponenten (wo ausgelagert) |
| `fineract-client` / `fineract-client-feign` | Generierte/API-Clients |
| `docs/arc42/` | Diese Architekturdokumentation |
| `docs/gherkin/` | BDD-Features inkl. Mapping zu arc42 ([README](../gherkin/README.md)) |
| `osgi/` | Equinox-Start, `config.ini`, Bundles, Logs |
| `config/docker/` | Compose-Bausteine, Env-Dateien, Observability |
| `kubernetes/` | Beispiel-Manifeste und Startskripte |
| `SECURITY.md` | Threat Model (Upstream-Basis) |

---

## 9.8 Konfigurations- und Umgebungsvariablen (Auswahl)

| Variable / Property | Bedeutung |
|---------------------|-----------|
| `FINERACT_NODE_ID` | Eindeutige Node-Kennung |
| `FINERACT_MODE_READ_ENABLED` | Read-API aktiv |
| `FINERACT_MODE_WRITE_ENABLED` | Write-/Command-API aktiv |
| `FINERACT_MODE_BATCH_MANAGER_ENABLED` | Batch-Orchestrierung aktiv |
| `FINERACT_MODE_BATCH_WORKER_ENABLED` | Batch-Ausführung aktiv |
| `FINERACT_HIKARI_*` | JDBC-Pool und Datasource |
| `FINERACT_DEFAULT_TENANTDB_*` | Default-Tenant-DB-Parameter |
| `FINERACT_LIQUIBASE_ENABLED` | Schema-Migration an/aus (Worker oft `false`) |
| `LOAN_COB_CHUNK_SIZE` / `PARTITION_SIZE` / `POLL_INTERVAL` | COB-Durchsatz-Tuning |
| `FINERACT_REMOTE_JOB_MESSAGE_HANDLER_*` | Spring Events / JMS / Kafka für Jobs |
| `FINERACT_EXTERNAL_EVENTS_*` | External-Event-Publisher |
| `FINERACT_LOGGING_HTTP_CORRELATION_ID_*` / `fineract.correlation.*` | Correlation-ID |
| `FINERACT_MANAGEMENT_PROMETHEUS_ENABLED` | Prometheus-Metrics |
| `FINERACT_MANAGEMENT_OLTP_*` | OTLP-Export |
| `FINERACT_SERVER_SSL_ENABLED` | HTTPS im Server |

Vollständige Listen: `fineract-provider/.../application.properties`, `config/docker/env/`.

---

## 9.9 Ports (Referenz)

| Port | Nutzung |
|-----:|---------|
| **8443** | HTTPS REST + Actuator |
| **5432** | PostgreSQL |
| **3306** | MySQL/MariaDB (alternative/Beispiele) |
| **9092** | Kafka |
| **61616** | ActiveMQ (JMS) |
| **2501** | Equinox Console (nur Admin-Netz) |
| **5000** | JDWP Debug (nur Dev) |
| **4318** | OTLP HTTP (Tempo o. ä.) |

→ Details: [05 Deployment View](05_deployment_view.md)

---

## 9.10 Abkürzungsverzeichnis (Schnellreferenz)

| Abk. | Langform |
|------|----------|
| ADR | Architecture Decision Record |
| API | Application Programming Interface |
| BDD | Behavior-Driven Development |
| COB | Close of Business |
| CQRS | Command Query Responsibility Segregation |
| DB | Database |
| DTO | Data Transfer Object |
| HA | High Availability |
| JMS | Java Message Service |
| JWT | JSON Web Token |
| K8s | Kubernetes |
| KI | Künstliche Intelligenz |
| LB | Load Balancer |
| MDC | Mapped Diagnostic Context |
| ML | Machine Learning |
| MTTD / MTTR | Mean Time To Detect / Recover |
| NFR | Non-Functional Requirement |
| OIDC | OpenID Connect |
| OSGi | Open Services Gateway initiative |
| OTLP | OpenTelemetry Protocol |
| PII | Personally Identifiable Information |
| RPO / RTO | Recovery Point / Time Objective |
| SLA / SLO | Service Level Agreement / Objective |
| TLS | Transport Layer Security |
| UI | User Interface |
| WAF | Web Application Firewall |
| 2FA | Two-Factor Authentication |

---

## 9.11 Begriffliche Abgrenzungen

| Nicht verwechseln | Unterschied |
|-------------------|-------------|
| **Command** vs. **Business Event** | Command = absichtliche Write-Anweisung; Event = Tatsache nach Änderung |
| **Bundle** vs. **Gradle-Modul** | Modul = Build-Zeit; Bundle = OSGi-Laufzeitartefakt |
| **Tenant-DB** vs. **fineract_tenants** | Fachdaten vs. Registry/Metadaten |
| **Batch Manager** vs. **Worker** | Orchestrierung vs. Ausführung |
| **Hook (Fineract)** vs. **Command Hook** | Externe/Business-Integration vs. Pipeline-Interceptor im neuen Stack |
| **Fail-Open** vs. **Degradation** | Fehlerpolitik bei Downstream vs. fehlende optionale Komponente |
| **Read Node** vs. **Read-only Tenant-DB** | App-Rolle vs. DB-Connection-Typ |
| **Sync KI Policy Gate** vs. **Async Enrichment** | blockiert Command vs. reichert nachträglich an |

---

## 9.12 Pflege des Glossars

- Neue ADR- oder Runtime-Begriffe hier in der passenden Alphabetgruppe ergänzen.  
- Abkürzungen in 9.10 und ausführliche Definition in 9.1–9.6 konsistent halten.  
- Bei Umbenennungen im Code (Klassen/Env) beide Schreibweisen kurz erwähnen.  
- Englische Upstream-Begriffe nicht unnötig übersetzen, wenn der Code englisch ist.

---

*Zurück*: [08 Design Decisions](08_design_decisions.md) · *Übersicht*: [README](README.md)
