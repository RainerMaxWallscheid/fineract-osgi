# Equinox OSGi runtime scaffold (fineract-osgi)

Minimal layout for running Eclipse Equinox alongside Fineract modularization work.
See also `docs/arc42/` (Runtime / Deployment / OSGi concepts).

**Architecture (target):** domain modules split into **api / impl / test** bundles; inter-bundle access only via the **OSGi Service Registry** (not Karaf Features). Spring may remain inside impl bundles. Full decision and stages: [ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md), playbook [15 OSGi Bundle Refactoring](../docs/arc42/15_osgi_bundle_refactoring.md).

### Pilot: fineract-command bundles

| Artifact | Bundle-SymbolicName |
|----------|---------------------|
| `fineract-command-api` | `org.apache.fineract.command.api` |
| `fineract-command-impl` | `org.apache.fineract.command.impl` |
| `fineract-command-test` | `org.apache.fineract.command.test` (`Fragment-Host: org.apache.fineract.command.impl`) |

Build jars: `./gradlew :fineract-command-api:jar :fineract-command-impl:jar :fineract-command-test:jar`  
Copy into `osgi/bundles/` for Equinox resolve experiments. Plan: [15_osgi_bundle_refactoring_fineract-command.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-command.md).

## Layout

| Path | Purpose |
|------|---------|
| `start-equinox.sh` | Start Equinox console on port **2501** |
| `equinox/config.ini` | Framework + Fineract mode defaults |
| `equinox/org.eclipse.osgi-*.jar` | Framework JAR (**not** in git; download locally) |
| `bundles/` | Feature bundles to install |
| `config/` | OSGi configuration area |
| `logs/` | Framework log (`equinox.log`; ignored if generated) |

## Download Equinox (once)

```bash
mkdir -p osgi/equinox
curl -L -o osgi/equinox/org.eclipse.osgi-3.20.0.jar \
  https://repo1.maven.org/maven2/org/eclipse/platform/org.eclipse.osgi/3.20.0/org.eclipse.osgi-3.20.0.jar
```

## Start

```bash
./osgi/start-equinox.sh
```

Defaults in `config.ini` enable read/write/batch-manager modes for local experiments.
Do not expose the Equinox console publicly in production.
