# Equinox OSGi runtime scaffold (fineract-osgi)

Minimal layout for running Eclipse Equinox alongside Fineract modularization work.
See also `docs/arc42/` (Runtime / Deployment / OSGi concepts).

**Architecture (target):** domain modules split into **api / impl / test** bundles; inter-bundle access only via the **OSGi Service Registry** (not Karaf Features). Spring may remain inside impl bundles. Decisions: [ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md), [ADR-023](../docs/arc42/decisions/ADR-023-fineract-command-module-naming.md) (command module naming). Playbook: [15 OSGi Bundle Refactoring](../docs/arc42/15_osgi_bundle_refactoring.md).

**Catalog status:** complete for every Gradle `api` / `impl` / `test` split (waves 1–4, core slices, leftover peels 1–30). Each impl registers ports via `*OsgiServiceRegistrar`. Each `*-test` is `Fragment-Host` → the matching impl unless noted. Domain consumers depend on **api only**; `fineract-provider` / `fineract-war` compose **api + impl**.

Convention: Bundle-SymbolicName is `org.apache.fineract.<stem>.{api,impl,test}` where `<stem>` is the module name with hyphens removed (`loan-origination` → `loanorigination`). Impl `Export-Package` is the registrar package only (`*.impl.osgi`). Copy jars into `osgi/bundles/` with `./gradlew osgiStageBundles`.

### Catalog (all splits)

| Gradle module | BSN stem | Registrar |
|---------------|----------|-----------|
| `fineract-command` | `command` | `CommandOsgiServiceRegistrar` (+ `fineract-command-integrationtest`, not a fragment) |
| `fineract-charge` | `charge` | `ChargeOsgiServiceRegistrar` |
| `fineract-rates` | `rates` | `RatesOsgiServiceRegistrar` |
| `fineract-tax` | `tax` | `TaxOsgiServiceRegistrar` |
| `fineract-document` | `document` | `DocumentOsgiServiceRegistrar` |
| `fineract-branch` | `branch` | `BranchOsgiServiceRegistrar` |
| `fineract-loan-origination` | `loanorigination` | `LoanOriginationOsgiServiceRegistrar` |
| `fineract-mix` | `mix` | `MixOsgiServiceRegistrar` |
| `fineract-investor` | `investor` | `InvestorOsgiServiceRegistrar` |
| `fineract-accounting` | `accounting` | `AccountingOsgiServiceRegistrar` |
| `fineract-savings` | `savings` | `SavingsOsgiServiceRegistrar` |
| `fineract-loan` | `loan` | `LoanOsgiServiceRegistrar` |
| `fineract-progressive-loan` | `progressiveloan` | `ProgressiveLoanOsgiServiceRegistrar` |
| `fineract-working-capital-loan` | `workingcapitalloan` | `WorkingCapitalLoanOsgiServiceRegistrar` |
| `fineract-cob` | `cob` | `CobOsgiServiceRegistrar` |
| `fineract-security` | `security` | `SecurityOsgiServiceRegistrar` |
| `fineract-businessdate` | `businessdate` | `BusinessDateOsgiServiceRegistrar` |
| `fineract-codes` | `codes` | `CodesOsgiServiceRegistrar` |
| `fineract-organisation` | `organisation` | `OrganisationOsgiServiceRegistrar` |
| `fineract-monetary` | `monetary` | `MonetaryOsgiServiceRegistrar` |
| `fineract-useradministration` | `useradministration` | `UserAdministrationOsgiServiceRegistrar` |
| `fineract-adhocquery` | `adhocquery` | `AdhocQueryOsgiServiceRegistrar` |
| `fineract-template` | `template` | `TemplateOsgiServiceRegistrar` |
| `fineract-notification` | `notification` | `NotificationOsgiServiceRegistrar` |
| `fineract-spm` | `spm` | `SpmOsgiServiceRegistrar` |
| `fineract-fund` | `fund` | `FundOsgiServiceRegistrar` |
| `fineract-paymenttype` | `paymenttype` | `PaymentTypeOsgiServiceRegistrar` |
| `fineract-search` | `search` | `SearchOsgiServiceRegistrar` |
| `fineract-collectionsheet` | `collectionsheet` | `CollectionSheetOsgiServiceRegistrar` |
| `fineract-accounttransfer` | `accounttransfer` | `AccountTransferOsgiServiceRegistrar` |
| `fineract-shares` | `shares` | `SharesOsgiServiceRegistrar` |
| `fineract-group` | `group` | `GroupOsgiServiceRegistrar` |
| `fineract-clients` | `clients` | `ClientsOsgiServiceRegistrar` |
| `fineract-postdatedchecks` | `postdatedchecks` | `PostDatedChecksOsgiServiceRegistrar` |
| `fineract-transfer` | `transfer` | `TransferOsgiServiceRegistrar` |
| `fineract-products` | `products` | `ProductsOsgiServiceRegistrar` |
| `fineract-paymentdetail` | `paymentdetail` | `PaymentDetailOsgiServiceRegistrar` |
| `fineract-cache` | `cache` | `CacheOsgiServiceRegistrar` |
| `fineract-accountnumberformat` | `accountnumberformat` | `AccountNumberFormatOsgiServiceRegistrar` |
| `fineract-survey` | `survey` | `SurveyOsgiServiceRegistrar` |
| `fineract-entityaccess` | `entityaccess` | `EntityAccessOsgiServiceRegistrar` |
| `fineract-calendar` | `calendar` | `CalendarOsgiServiceRegistrar` |
| `fineract-meeting` | `meeting` | `MeetingOsgiServiceRegistrar` |
| `fineract-address` | `address` | `AddressOsgiServiceRegistrar` |
| `fineract-creditbureau` | `creditbureau` | `CreditBureauOsgiServiceRegistrar` |
| `fineract-collateral` | `collateral` | `CollateralOsgiServiceRegistrar` |
| `fineract-collateralmanagement` | `collateralmanagement` | `CollateralManagementOsgiServiceRegistrar` |
| `fineract-note` | `note` | `NoteOsgiServiceRegistrar` |
| `fineract-hooks` | `hooks` | `HooksOsgiServiceRegistrar` |
| `fineract-sms` | `sms` | `SmsOsgiServiceRegistrar` |
| `fineract-reportmailingjob` | `reportmailingjob` | `ReportMailingJobOsgiServiceRegistrar` |
| `fineract-campaigns` | `campaigns` | `CampaignsOsgiServiceRegistrar` |
| `fineract-gcm` | `gcm` | `GcmOsgiServiceRegistrar` |
| `fineract-dataqueries` | `dataqueries` | `DataqueriesOsgiServiceRegistrar` |
| `fineract-configuration` | `configuration` | `ConfigurationOsgiServiceRegistrar` |
| `fineract-bulkimport` | `bulkimport` | `BulkImportOsgiServiceRegistrar` |
| `fineract-instancemode` | `instancemode` | `InstanceModeOsgiServiceRegistrar` (no ports) |
| `fineract-jobs` | `jobs` | `JobsOsgiServiceRegistrar` |
| `fineract-s3` | `s3` | `S3OsgiServiceRegistrar` |
| `fineract-openapi` | `openapi` | `OpenApiOsgiServiceRegistrar` (no ports) |
| `fineract-springbatch` | `springbatch` | `SpringBatchOsgiServiceRegistrar` |
| `fineract-event` | `event` | `EventOsgiServiceRegistrar` |
| `fineract-interoperation` | `interoperation` | `InteroperationOsgiServiceRegistrar` |

### Not split (do not invent api/impl/test)

| Module | Role |
|--------|------|
| `fineract-core` | Shared kernel ([core slices standing rule](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md#standing-rule-fineract-core-is-the-shared-kernel)) |
| `fineract-validation` | Bean Validation library |
| `fineract-report` | Reporting SPI |
| `fineract-avro-schemas` | Generated published-language schemas |
| `fineract-architecture` | ArchUnit rules only |
| `fineract-command-jdbc` / `-async` / `-disruptor` / `-audit` | Command satellites (already modular; no BSN) |
| `fineract-provider` | Composition root — never the next pilot |
| `fineract-war` | Optional WAR packaging |

Wave-by-wave notes below are historical detail for the first splits. Later peels follow the same recipe; use the catalog table for BSN / registrar.

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
| `fineract-charge-impl` (`fineract-charge/impl`) | `org.apache.fineract.charge.impl` | Export: registrar package only; `ChargeOsgiServiceRegistrar` → `ChargeDefinitionPort` |
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

### Wave 4: fineract-progressive-loan bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-progressive-loan-api` | `org.apache.fineract.progressiveloan.api` | Pure ports & calc DTOs |
| `fineract-progressive-loan-impl` | `org.apache.fineract.progressiveloan.impl` | Schedule engine residual + `ProgressiveLoanOsgiServiceRegistrar` |
| `fineract-progressive-loan-test` | `org.apache.fineract.progressiveloan.test` | Fragment-Host → progressiveloan.impl |

### Wave 4: fineract-working-capital-loan bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-working-capital-loan-api` | `org.apache.fineract.workingcapitalloan.api` | Pure ports, DTOs, exceptions, pure enums |
| `fineract-working-capital-loan-impl` | `org.apache.fineract.workingcapitalloan.impl` | Domain + COB residual + `WorkingCapitalLoanOsgiServiceRegistrar` |
| `fineract-working-capital-loan-test` | `org.apache.fineract.workingcapitalloan.test` | Fragment-Host → workingcapitalloan.impl |

### Wave 4: fineract-cob bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-cob-api` | `org.apache.fineract.cob.api` | Pure ports, DTOs, exceptions |
| `fineract-cob-impl` | `org.apache.fineract.cob.impl` | Batch residual + `CobOsgiServiceRegistrar` |
| `fineract-cob-test` | `org.apache.fineract.cob.test` | Fragment-Host → cob.impl |

### Wave 4: fineract-security bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-security-api` | `org.apache.fineract.security.api` | Pure ports, DTOs, exceptions, constants |
| `fineract-security-impl` | `org.apache.fineract.security.impl` | Filters/OIDC residual + `SecurityOsgiServiceRegistrar` |
| `fineract-security-test` | `org.apache.fineract.security.test` | Fragment-Host → security.impl |

### Core slice: fineract-businessdate (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-businessdate-api` | `org.apache.fineract.businessdate.api` | Ports, DTOs, exceptions |
| `fineract-businessdate-impl` | `org.apache.fineract.businessdate.impl` | JPA/REST + `BusinessDateOsgiServiceRegistrar` |
| `fineract-businessdate-test` | `org.apache.fineract.businessdate.test` | Fragment-Host → businessdate.impl |

Kernel enum `BusinessDateType` remains in **fineract-core**. Plan: [15_osgi_bundle_refactoring_fineract-core-slices.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).

### Core slice: fineract-codes (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-codes-api` | `org.apache.fineract.codes.api` | Pure DTOs + read ports + swagger models |
| `fineract-codes-impl` | `org.apache.fineract.codes.impl` | REST/handlers + `CodesOsgiServiceRegistrar` |
| `fineract-codes-test` | `org.apache.fineract.codes.test` | Fragment-Host → codes.impl |

Entities/exceptions residual in **fineract-core**.

### Core slice: fineract-organisation (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-organisation-api` | `org.apache.fineract.organisation.api` | Office / staff / holiday / working-days / provisioning ports |
| `fineract-organisation-impl` | `org.apache.fineract.organisation.impl` | REST/handlers + `OrganisationOsgiServiceRegistrar` |
| `fineract-organisation-test` | `org.apache.fineract.organisation.test` | Fragment-Host → organisation.impl |

Office / Staff / Holiday / WorkingDays entities residual in **fineract-core**. Plan: [core slices](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).

### Core slice: fineract-monetary (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-monetary-api` | `org.apache.fineract.monetary.api` | Currency read/write ports, admin DTOs |
| `fineract-monetary-impl` | `org.apache.fineract.monetary.impl` | REST/handlers + `MonetaryOsgiServiceRegistrar` |
| `fineract-monetary-test` | `org.apache.fineract.monetary.test` | Fragment-Host → monetary.impl |

`Money` / `CurrencyData` residual in **fineract-core**.

## Manifest check

```bash
python3 osgi/check-manifests.py
# or
./gradlew checkOsgiManifests
```

Fails on duplicate BSN, BSN/stem mismatch, missing `Fragment-Host`, impl `Export-Package` that is not exactly one `*.impl.osgi` package, and impl-involved or new api-api split packages. There are no remaining allow-listed api-api type splits. `jobs.exception` is jobs-api only after `LoanIdsHardLockedException` moved to `portfolio.loanaccount.exception`. `charge.exception` is charge-api only after the three savings-account charge exceptions moved to `portfolio.savings.exception`. Progressive buy-down / capitalized-income / schedule-plan types live under `portfolio.loanaccount.progressiveloan.*`.

## Layout

| Path | Purpose |
|------|---------|
| `start-equinox.sh` | Start Equinox console on port **2501** (`-configuration` = `config/` directory) |
| `check-manifests.py` | Static BSN / Fragment-Host / Export-Package guard |
| `equinox/config.ini` | Framework + Fineract mode **template** |
| `equinox/org.eclipse.osgi-*.jar` | Framework JAR (**not** in git; download locally) |
| `bundles/` | Staged api / impl / core JARs (`:osgiStageBundles`) |
| `config/` | Equinox configuration area (`config.ini` generated by stage) |
| `logs/` | Framework log (`equinox.log`; ignored if generated) |

## Download Equinox (once)

```bash
mkdir -p osgi/equinox
curl -L -o osgi/equinox/org.eclipse.osgi-3.20.0.jar \
  https://repo1.maven.org/maven2/org/eclipse/platform/org.eclipse.osgi/3.20.0/org.eclipse.osgi-3.20.0.jar
```

## Stage bundles (optional)

```bash
./gradlew osgiStageBundles
```

Copies every `fineract-*-api`, `fineract-*-impl`, and `fineract-core` jar into `osgi/bundles/` and writes `osgi/config/config.ini` (template + `osgi.bundles`). Start levels: core `@2`, api `@3`, impl `@4`. This does **not** yet prove a full Equinox resolve: `fineract-core` has no OSGi export list.

## Start

```bash
./osgi/start-equinox.sh
# or
./gradlew equinoxStart
```

Equinox `-configuration` is the **directory** `osgi/config`, not the template ini file. The script seeds that directory from `osgi/equinox/config.ini` when nothing has been staged yet.

Defaults in `config.ini` enable read/write/batch-manager modes for local experiments.
Do not expose the Equinox console publicly in production.
