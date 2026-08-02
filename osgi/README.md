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

No `:fineract-command` façade — core/mix/document use **api only**; provider uses **api + impl**.  

Build jars: `./gradlew :fineract-command-api:jar :fineract-command-impl:jar :fineract-command-test:jar :fineract-command-integrationtest:jar`  
White-box tests: `./gradlew :fineract-command-test:test`  
Copy into `osgi/bundles/` for Equinox resolve experiments. Plan: [15_osgi_bundle_refactoring_fineract-command.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-command.md).

### Wave 1: fineract-charge bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-charge-api` (`fineract-charge/api`) | `org.apache.fineract.charge.api` | Export: `moduleapi` (ports, pure enums, read service), catalog `exception` |
| `fineract-charge-impl` (`fineract-charge/impl`) | `org.apache.fineract.charge.impl` | Export: `starter` only; `ChargeOsgiServiceRegistrar` → `ChargeDefinitionPort` |
| `fineract-charge-test` (`fineract-charge/test`) | `org.apache.fineract.charge.test` | `Fragment-Host: org.apache.fineract.charge.impl` (16 unit tests) |

**Consumers:** accounting / progressive / loan / savings / WC → `-api` only; investor → no charge dep; product/account charges use chargeId; **provider / war / ITs** → `-api` + `-impl`. ArchUnit allows pure catalog enums / `ChargeReadPlatformService`; forbids `Charge` entity / write internals.

Build jars: `./gradlew :fineract-charge-api:jar :fineract-charge-impl:jar :fineract-charge-test:jar`  
White-box tests: `./gradlew :fineract-charge-test:test`  
Plan: [15_osgi_bundle_refactoring_fineract-charge.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).

### Wave 1: fineract-rates bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-rates-api` | `org.apache.fineract.rates.api` | `FloatingRatePort`, DTOs, service interfaces |
| `fineract-rates-impl` | `org.apache.fineract.rates.impl` | JPA + REST + `RatesOsgiServiceRegistrar` |
| `fineract-rates-test` | `org.apache.fineract.rates.test` | Fragment-Host → rates.impl |

Loan uses **rates-api only** (`floatingRateId` + port).

### Wave 1: fineract-tax bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-tax-api` | `org.apache.fineract.tax.api` | `TaxCatalogPort`, `ChargeTaxApplicationService`, exceptions |
| `fineract-tax-impl` | `org.apache.fineract.tax.impl` | JPA + REST + `TaxOsgiServiceRegistrar` |
| `fineract-tax-test` | `org.apache.fineract.tax.test` | Fragment-Host → tax.impl |

Charge/loan/savings use **tax-api only** (`taxGroupId` / `taxComponentId` + ports). Plan: [15_osgi_bundle_refactoring_fineract-tax.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-tax.md).

### Wave 2: fineract-document bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-document-api` | `org.apache.fineract.document.api` | `ContentStoreService`, `ContentStreamPort`, document/image ports |
| `fineract-document-impl` | `org.apache.fineract.document.impl` | FS/S3 + REST + `DocumentOsgiServiceRegistrar` |
| `fineract-document-test` | `org.apache.fineract.document.test` | Fragment-Host → document.impl |

Provider bulk-import uses **`ContentStreamPort`**; composition root still api+impl. Plan: [15_osgi_bundle_refactoring_fineract-document.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-document.md).

### Wave 2: fineract-branch bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-branch-api` | `org.apache.fineract.branch.api` | Teller service interfaces, DTOs, exceptions, pure enums, `CashierTxnValidationPort` |
| `fineract-branch-impl` | `org.apache.fineract.branch.impl` | JPA + REST + service impls + starter; `BranchOsgiServiceRegistrar` |
| `fineract-branch-test` | `org.apache.fineract.branch.test` | Fragment-Host → branch.impl |

Loan cash path uses **`CashierTxnValidationPort`**; residual closed. Plan: [15_osgi_bundle_refactoring_fineract-branch.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-branch.md).

### Wave 2: fineract-loan-origination bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-loan-origination-api` | `org.apache.fineract.loanorigination.api` | Originator service ports, DTOs (`LoanOriginatorData`), exceptions |
| `fineract-loan-origination-impl` | `org.apache.fineract.loanorigination.impl` | JPA + REST + Avro enrichers + `LoanOriginationOsgiServiceRegistrar` |
| `fineract-loan-origination-test` | `org.apache.fineract.loanorigination.test` | Fragment-Host → loanorigination.impl |

Loan / WC use **api only**; provider composition root api+impl. Plan: [15_osgi_bundle_refactoring_fineract-loan-origination.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-loan-origination.md).

### Wave 2: fineract-mix bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-mix-api` | `org.apache.fineract.mix.api` | Taxonomy / mapping / XBRL service interfaces + DTOs |
| `fineract-mix-impl` | `org.apache.fineract.mix.impl` | JPA + REST + XBRL builder + `MixOsgiServiceRegistrar` |
| `fineract-mix-test` | `org.apache.fineract.mix.test` | Fragment-Host → mix.impl |

Provider/war composition root only. Plan: [15_osgi_bundle_refactoring_fineract-mix.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-mix.md).

### Wave 3: fineract-investor bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-investor-api` | `org.apache.fineract.investor.api` | Pure ports, DTOs/status enums, exceptions |
| `fineract-investor-impl` | `org.apache.fineract.investor.impl` | JPA + REST + COB + enrichers + `InvestorOsgiServiceRegistrar` |
| `fineract-investor-test` | `org.apache.fineract.investor.test` | Fragment-Host → investor.impl |

Provider journal residual uses entities/`AccountingService` from impl. Plan: [15_osgi_bundle_refactoring_fineract-investor.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-investor.md).

### Wave 3: fineract-accounting bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-accounting-api` | `org.apache.fineract.accounting.api` | Ports, DTOs, exceptions, pure constants |
| `fineract-accounting-impl` | `org.apache.fineract.accounting.impl` | JPA + REST + helpers + `AccountingOsgiServiceRegistrar` |
| `fineract-accounting-test` | `org.apache.fineract.accounting.test` | Fragment-Host → accounting.impl |

investor-api uses **api only**; loan/savings/provider use api+impl residual. Plan: [15_osgi_bundle_refactoring_fineract-accounting.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-accounting.md).

### Wave 3: fineract-savings bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-savings-api` | `org.apache.fineract.savings.api` | Pure product/application ports, DTOs, exceptions |
| `fineract-savings-impl` | `org.apache.fineract.savings.impl` | Domain + entity-typed services + COB + `SavingsOsgiServiceRegistrar` |
| `fineract-savings-test` | `org.apache.fineract.savings.test` | Fragment-Host → savings.impl |

Provider composition root uses api+impl. Plan: [15_osgi_bundle_refactoring_fineract-savings.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-savings.md).

### Wave 4: fineract-loan bundles (complete — entity residual)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-loan-api` | `org.apache.fineract.loan.api` | Pure ports, DTOs, exceptions, selected pure enums |
| `fineract-loan-impl` | `org.apache.fineract.loan.impl` | Domain + entity residual + COB + `LoanOsgiServiceRegistrar` |
| `fineract-loan-test` | `org.apache.fineract.loan.test` | Fragment-Host → loan.impl |

Progressive / WC / provider / custom use **api + impl**. Plan: [15_osgi_bundle_refactoring_fineract-loan.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-loan.md).

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
