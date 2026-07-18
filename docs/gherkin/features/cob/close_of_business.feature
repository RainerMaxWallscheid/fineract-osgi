# language: de
@arc42-04 @arc42-05 @arc42-07 @runtime-cob @adr-007 @adr-012 @domain-loan
Feature: Close of Business (COB)
  Als Betreiber
  möchte ich den Loan-COB partitioniert und wiederanlaufbar ausführen
  damit der Tagesabschluss im Zeitfenster und ohne Doppelbuchungen endet.

  # Architektur: docs/arc42/04_runtime_view.md §4.6
  # Deployment: docs/arc42/05_deployment_view.md §5.3, §5.5
  # ADR-007 Node Modes, ADR-012 Messaging

  Hintergrund:
    Angenommen mindestens ein Tenant mit aktiven Krediten existiert
    Und Loan-COB ist aktiviert

  Szenario: COB auf All-in-One-Node
    Angenommen Read, Write, Batch-Manager und Batch-Worker sind auf einem Node aktiv
    Wenn der Loan-COB-Job gestartet wird
    Dann werden die konfigurierten Business Steps für fällige Kredite ausgeführt
    Und der Job endet mit Status erfolgreich oder mit klarer Fehlerliste
    Und COB-Metadaten zum Lauf sind aktualisiert

  @quality-Q-REL-1
  Szenario: Worker-Ausfall bei verteiltem COB
    Angenommen ein Batch-Manager und mindestens zwei Worker sind aktiv
    Und Job-Partitionen werden über Messaging verteilt
    Wenn ein Worker während einer Partition ausfällt
    Dann wird die Partition erneut zugestellt oder retryed
    Und andere Partitionen laufen weiter
    Und nach Recovery sind keine doppelten Zinsbuchungen für dieselbe Step-Ausführung vorhanden

  Szenario: Online-Write während COB auf betroffenem Kredit
    Angenommen ein Kredit befindet sich gerade in einer COB-Partition
    Wenn ein konkurrierender Write auf diesen Kredit eintrifft
    Dann greifen COB-API-Filter gemäß Konfiguration
    Und die Datenkonsistenz des Kredits bleibt gewahrt
