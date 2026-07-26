# Equinox OSGi runtime scaffold (fineract-osgi)

Minimal layout for running Eclipse Equinox alongside Fineract modularization work.
See also `docs/arc42/` (Runtime / Deployment / OSGi concepts).

**Architecture (target):** domain modules split into **api / impl / test** bundles; inter-bundle access only via the **OSGi Service Registry** (not Karaf Features). Spring may remain inside impl bundles. Decisions: [ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md), [ADR-023](../docs/arc42/decisions/ADR-023-fineract-command-module-naming.md) (command module naming). Playbook: [15 OSGi Bundle Refactoring](../docs/arc42/15_osgi_bundle_refactoring.md).

### Pilot: fineract-command bundles

| Artifact | Bundle-SymbolicName |
|----------|---------------------|
| `fineract-command-api` (`fineract-command/api`) | `org.apache.fineract.command.api` |
| `fineract-command-impl` (`fineract-command/impl`) | `org.apache.fineract.command.impl` |
| `fineract-command-test` (`fineract-command/test`) | `org.apache.fineract.command.test` (`Fragment-Host: org.apache.fineract.command.impl`) |
| `fineract-command-integrationtest` | `org.apache.fineract.command.integrationtest` (shared IT fixtures; not Fragment-Host) |

Build jars: `./gradlew :fineract-command-api:jar :fineract-command-impl:jar :fineract-command-test:jar :fineract-command-integrationtest:jar`  
White-box tests: `./gradlew :fineract-command-test:test`  
Copy into `osgi/bundles/` for Equinox resolve experiments. Plan: [15_osgi_bundle_refactoring_fineract-command.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-command.md).

### Wave 1: fineract-charge bundles (Steps 0–4)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-charge-api` (`fineract-charge/api`) | `org.apache.fineract.charge.api` | Export: `moduleapi`, pure `domain` enums, catalog `exception` |
| `fineract-charge-impl` (`fineract-charge/impl`) | `org.apache.fineract.charge.impl` | Export: `starter` only; Import api packages + `*` |
| `fineract-charge-test` (`fineract-charge/test`) | `org.apache.fineract.charge.test` | `Fragment-Host: org.apache.fineract.charge.impl` |
| `fineract-charge` | *(façade, not OSGi feature)* | Boot compatibility: re-exports api + impl |

Build jars: `./gradlew :fineract-charge-api:jar :fineract-charge-impl:jar :fineract-charge-test:jar`  
White-box tests: `./gradlew :fineract-charge-test:test`  
Plan: [15_osgi_bundle_refactoring_fineract-charge.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).

**Next modules:** ranked Wave 1–4 in [15.6 Suggested rollout order](../docs/arc42/15_osgi_bundle_refactoring.md#suggested-rollout-order-postcommand-pilot) — rates, tax, document/branch, ….

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
