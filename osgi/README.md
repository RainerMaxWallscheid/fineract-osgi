# Equinox OSGi runtime scaffold (fineract-osgi)

Minimal layout for running Eclipse Equinox alongside Fineract modularization work.
See also `docs/arc42/` (Runtime / Deployment / OSGi concepts).

**Architecture (target):** domain modules split into **api / impl / test** bundles; inter-bundle access only via the **OSGi Service Registry** (not Karaf Features). Spring may remain inside impl bundles. Decisions: [ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md), [ADR-023](../docs/arc42/decisions/ADR-023-fineract-command-module-naming.md) (command module naming). Playbook: [15 OSGi Bundle Refactoring](../docs/arc42/15_osgi_bundle_refactoring.md).

**Catalog status:** complete for every Gradle `api` / `impl` / `test` split (waves 1–4, core slices, leftover peels 1–30). Each impl registers ports via `*OsgiServiceRegistrar`. Each `*-test` is `Fragment-Host` → the matching impl unless noted. Domain consumers depend on **api only**; `fineract-provider` / `fineract-war` compose **api + impl**.

Convention: Bundle-SymbolicName is `org.apache.fineract.<stem>.{api,impl,test}` where `<stem>` is the module name with hyphens removed (`loan-origination` → `loanorigination`). Impl `Export-Package` is the registrar package only (`*.impl.osgi`). Shared kernel BSN is `org.apache.fineract.core` (no api/impl suffix). Copy jars into `osgi/bundles/` with `./gradlew osgiStageBundles`.

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
| `fineract-core` | Shared kernel; BSN `org.apache.fineract.core`; unique-kernel `Export-Package` only ([core slices standing rule](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md#standing-rule-fineract-core-is-the-shared-kernel)) |
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
| `fineract-rates-impl` | `org.apache.fineract.rates.impl` | JPA + REST + `RatesOsgiServiceRegistrar` / `RatesOsgiBundleActivator` |
| `fineract-rates-test` | `org.apache.fineract.rates.test` | Fragment-Host → rates.impl |

Loan uses **rates-api only** (`floatingRateId` + port).

### Wave 1: fineract-tax bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-tax-api` | `org.apache.fineract.tax.api` | `TaxCatalogPort`, `ChargeTaxApplicationService`, exceptions |
| `fineract-tax-impl` | `org.apache.fineract.tax.impl` | JPA + REST + `TaxOsgiServiceRegistrar` / `TaxOsgiBundleActivator` |
| `fineract-tax-test` | `org.apache.fineract.tax.test` | Fragment-Host → tax.impl |

Charge/loan/savings use **tax-api only** (`taxGroupId` / `taxComponentId` + ports). Plan: [15_osgi_bundle_refactoring_fineract-tax.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-tax.md).

### Wave 2: fineract-document bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-document-api` | `org.apache.fineract.document.api` | `ContentStoreService`, `ContentStreamPort`, document/image ports |
| `fineract-document-impl` | `org.apache.fineract.document.impl` | FS/S3 + REST + `DocumentOsgiServiceRegistrar` / `DocumentOsgiBundleActivator` |
| `fineract-document-test` | `org.apache.fineract.document.test` | Fragment-Host → document.impl |

Provider bulk-import uses **`ContentStreamPort`**; composition root still api+impl. Plan: [15_osgi_bundle_refactoring_fineract-document.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-document.md).

### Wave 2: fineract-branch bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-branch-api` | `org.apache.fineract.branch.api` | Teller service interfaces, DTOs, exceptions, pure enums, `CashierTxnValidationPort` |
| `fineract-branch-impl` | `org.apache.fineract.branch.impl` | JPA + REST + `BranchOsgiServiceRegistrar` / `BranchOsgiBundleActivator` |
| `fineract-branch-test` | `org.apache.fineract.branch.test` | Fragment-Host → branch.impl |

Loan cash path uses **`CashierTxnValidationPort`**; residual closed. Plan: [15_osgi_bundle_refactoring_fineract-branch.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-branch.md).

### Wave 2: fineract-loan-origination bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-loan-origination-api` | `org.apache.fineract.loanorigination.api` | Originator service ports, DTOs (`LoanOriginatorData`), exceptions |
| `fineract-loan-origination-impl` | `org.apache.fineract.loanorigination.impl` | JPA + REST + `LoanOriginationOsgiServiceRegistrar` / `LoanOriginationOsgiBundleActivator` |
| `fineract-loan-origination-test` | `org.apache.fineract.loanorigination.test` | Fragment-Host → loanorigination.impl |

Loan / WC use **api only**; provider composition root api+impl. Plan: [15_osgi_bundle_refactoring_fineract-loan-origination.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-loan-origination.md).

### Wave 2: fineract-mix bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-mix-api` | `org.apache.fineract.mix.api` | Taxonomy / mapping / XBRL service interfaces + DTOs |
| `fineract-mix-impl` | `org.apache.fineract.mix.impl` | JPA + REST + `MixOsgiServiceRegistrar` / `MixOsgiBundleActivator` |
| `fineract-mix-test` | `org.apache.fineract.mix.test` | Fragment-Host → mix.impl |

Provider/war composition root only. Plan: [15_osgi_bundle_refactoring_fineract-mix.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-mix.md).

### Wave 3: fineract-investor bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-investor-api` | `org.apache.fineract.investor.api` | Pure ports, DTOs/status enums, exceptions |
| `fineract-investor-impl` | `org.apache.fineract.investor.impl` | JPA + REST + `InvestorOsgiServiceRegistrar` / `InvestorOsgiBundleActivator` |
| `fineract-investor-test` | `org.apache.fineract.investor.test` | Fragment-Host → investor.impl |

Provider journal residual uses entities/`AccountingService` from impl. Plan: [15_osgi_bundle_refactoring_fineract-investor.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-investor.md).

### Wave 3: fineract-accounting bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-accounting-api` | `org.apache.fineract.accounting.api` | Ports, DTOs, exceptions, pure constants |
| `fineract-accounting-impl` | `org.apache.fineract.accounting.impl` | JPA + REST + `AccountingOsgiServiceRegistrar` / `AccountingOsgiBundleActivator` |
| `fineract-accounting-test` | `org.apache.fineract.accounting.test` | Fragment-Host → accounting.impl |

investor-api uses **api only**; loan/savings/provider use api+impl residual. Plan: [15_osgi_bundle_refactoring_fineract-accounting.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-accounting.md).

### Wave 3: fineract-savings bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-savings-api` | `org.apache.fineract.savings.api` | Pure product/application ports, DTOs, exceptions |
| `fineract-savings-impl` | `org.apache.fineract.savings.impl` | Domain + COB + `SavingsOsgiServiceRegistrar` / `SavingsOsgiBundleActivator` |
| `fineract-savings-test` | `org.apache.fineract.savings.test` | Fragment-Host → savings.impl |

Provider composition root uses api+impl. Plan: [15_osgi_bundle_refactoring_fineract-savings.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-savings.md).

### Wave 4: fineract-loan bundles (complete — entity residual)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-loan-api` | `org.apache.fineract.loan.api` | Pure ports, DTOs, exceptions, selected pure enums |
| `fineract-loan-impl` | `org.apache.fineract.loan.impl` | Domain + COB + `LoanOsgiServiceRegistrar` / `LoanOsgiBundleActivator` |
| `fineract-loan-test` | `org.apache.fineract.loan.test` | Fragment-Host → loan.impl |

Progressive / WC / provider / custom use **api + impl**. Plan: [15_osgi_bundle_refactoring_fineract-loan.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-loan.md).

### Wave 4: fineract-progressive-loan bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-progressive-loan-api` | `org.apache.fineract.progressiveloan.api` | Pure ports & calc DTOs |
| `fineract-progressive-loan-impl` | `org.apache.fineract.progressiveloan.impl` | Schedule engine residual + `ProgressiveLoanOsgiServiceRegistrar` / `ProgressiveLoanOsgiBundleActivator` |
| `fineract-progressive-loan-test` | `org.apache.fineract.progressiveloan.test` | Fragment-Host → progressiveloan.impl |

### Wave 4: fineract-working-capital-loan bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-working-capital-loan-api` | `org.apache.fineract.workingcapitalloan.api` | Pure ports, DTOs, exceptions, pure enums |
| `fineract-working-capital-loan-impl` | `org.apache.fineract.workingcapitalloan.impl` | Domain + COB residual + `WorkingCapitalLoanOsgiServiceRegistrar` / `WorkingCapitalLoanOsgiBundleActivator` |
| `fineract-working-capital-loan-test` | `org.apache.fineract.workingcapitalloan.test` | Fragment-Host → workingcapitalloan.impl |

### Wave 4: fineract-cob bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-cob-api` | `org.apache.fineract.cob.api` | Pure ports, DTOs, exceptions |
| `fineract-cob-impl` | `org.apache.fineract.cob.impl` | Batch residual + `CobOsgiServiceRegistrar` / `CobOsgiBundleActivator` |
| `fineract-cob-test` | `org.apache.fineract.cob.test` | Fragment-Host → cob.impl |

### Wave 4: fineract-security bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-security-api` | `org.apache.fineract.security.api` | Pure ports, DTOs, exceptions, constants |
| `fineract-security-impl` | `org.apache.fineract.security.impl` | Filters/OIDC residual + `SecurityOsgiServiceRegistrar` / `SecurityOsgiBundleActivator` |
| `fineract-security-test` | `org.apache.fineract.security.test` | Fragment-Host → security.impl |

### Core slice: fineract-businessdate (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-businessdate-api` | `org.apache.fineract.businessdate.api` | Ports, DTOs, exceptions |
| `fineract-businessdate-impl` | `org.apache.fineract.businessdate.impl` | JPA/REST + `BusinessDateOsgiServiceRegistrar` / `BusinessDateOsgiBundleActivator` |
| `fineract-businessdate-test` | `org.apache.fineract.businessdate.test` | Fragment-Host → businessdate.impl |

Kernel enum `BusinessDateType` remains in **fineract-core**. Plan: [15_osgi_bundle_refactoring_fineract-core-slices.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).

### Core slice: fineract-codes (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-codes-api` | `org.apache.fineract.codes.api` | Pure DTOs + read ports + swagger models |
| `fineract-codes-impl` | `org.apache.fineract.codes.impl` | REST/handlers + `CodesOsgiServiceRegistrar` / `CodesOsgiBundleActivator` |
| `fineract-codes-test` | `org.apache.fineract.codes.test` | Fragment-Host → codes.impl |

Entities/exceptions residual in **fineract-core**.

### Core slice: fineract-organisation (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-organisation-api` | `org.apache.fineract.organisation.api` | Office / staff / holiday / working-days / provisioning ports |
| `fineract-organisation-impl` | `org.apache.fineract.organisation.impl` | REST/handlers + `OrganisationOsgiServiceRegistrar` / `OrganisationOsgiBundleActivator` |
| `fineract-organisation-test` | `org.apache.fineract.organisation.test` | Fragment-Host → organisation.impl |

Office / Staff / Holiday / WorkingDays entities residual in **fineract-core**. Plan: [core slices](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).

### Core slice: fineract-monetary (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-monetary-api` | `org.apache.fineract.monetary.api` | Currency read/write ports, admin DTOs |
| `fineract-monetary-impl` | `org.apache.fineract.monetary.impl` | REST/handlers + `MonetaryOsgiServiceRegistrar` / `MonetaryOsgiBundleActivator` |
| `fineract-monetary-test` | `org.apache.fineract.monetary.test` | Fragment-Host → monetary.impl |

`Money` / `CurrencyData` residual in **fineract-core**.

### Provider peel: fineract-useradministration (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-useradministration-api` | `org.apache.fineract.useradministration.api` | Read/write ports + password policy DTO |
| `fineract-useradministration-impl` | `org.apache.fineract.useradministration.impl` | REST/handlers + `UserAdministrationOsgiServiceRegistrar` / `UserAdministrationOsgiBundleActivator` |
| `fineract-useradministration-test` | `org.apache.fineract.useradministration.test` | Fragment-Host → useradministration.impl |

`AppUser` / `Role` / `Permission` and shared DTOs residual in **fineract-core**.

### Provider peel: fineract-adhocquery (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-adhocquery-api` | `org.apache.fineract.adhocquery.api` | Ports, DTOs, `ReportRunFrequency`, exceptions |
| `fineract-adhocquery-impl` | `org.apache.fineract.adhocquery.impl` | REST/entity/handlers + `AdhocQueryOsgiServiceRegistrar` / `AdhocQueryOsgiBundleActivator` |
| `fineract-adhocquery-test` | `org.apache.fineract.adhocquery.test` | Fragment-Host → adhocquery.impl |

### Provider peel: fineract-template (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-template-api` | `org.apache.fineract.template.api` | Ports, DTOs, enums, commands, exceptions |
| `fineract-template-impl` | `org.apache.fineract.template.impl` | REST/entity/merge + `TemplateOsgiServiceRegistrar` / `TemplateOsgiBundleActivator` |
| `fineract-template-test` | `org.apache.fineract.template.test` | Fragment-Host → template.impl |

### Provider peel: fineract-notification (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-notification-api` | `org.apache.fineract.notification.api` | Read/write ports, event publisher port, DTOs |
| `fineract-notification-impl` | `org.apache.fineract.notification.impl` | REST/JPA/JMS + `NotificationOsgiServiceRegistrar` / `NotificationOsgiBundleActivator` |
| `fineract-notification-test` | `org.apache.fineract.notification.test` | Fragment-Host → notification.impl |

### Provider peel: fineract-spm (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-spm-api` | `org.apache.fineract.spm.api` | DTOs, exceptions, `ScorecardReadPlatformService`, constants |
| `fineract-spm-impl` | `org.apache.fineract.spm.impl` | REST/JPA + `SpmOsgiServiceRegistrar` / `SpmOsgiBundleActivator` |
| `fineract-spm-test` | `org.apache.fineract.spm.test` | Fragment-Host → spm.impl |

### Provider peel: fineract-fund (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-fund-api` | `org.apache.fineract.fund.api` | `FundData`/`FundRequest`, read/write ports |
| `fineract-fund-impl` | `org.apache.fineract.fund.impl` | REST/handlers + `FundOsgiServiceRegistrar` / `FundOsgiBundleActivator` |
| `fineract-fund-test` | `org.apache.fineract.fund.test` | Fragment-Host → fund.impl |

`Fund` entity residual in **fineract-core**.

### Provider peel: fineract-accountnumberformat (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-accountnumberformat-api` | `org.apache.fineract.accountnumberformat.api` | `AccountNumberFormatData`, read/write ports |
| `fineract-accountnumberformat-impl` | `org.apache.fineract.accountnumberformat.impl` | REST/handlers + `AccountNumberFormatOsgiServiceRegistrar` / `AccountNumberFormatOsgiBundleActivator` |
| `fineract-accountnumberformat-test` | `org.apache.fineract.accountnumberformat.test` | Fragment-Host → accountnumberformat.impl |

Entity / generator residual in **fineract-core**.

### Provider peel: fineract-survey (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-survey-api` | `org.apache.fineract.survey.api` | PPI/likelihood/poverty-line DTOs and ports |
| `fineract-survey-impl` | `org.apache.fineract.survey.impl` | REST/JPA + `SurveyOsgiServiceRegistrar` / `SurveyOsgiBundleActivator` |
| `fineract-survey-test` | `org.apache.fineract.survey.test` | Fragment-Host → survey.impl |

Datatable ports come from **fineract-core**. Equinox registers `ReadLikelihoodService` only (`retrieveAll` → empty, `retrieve` → null). Did not register `ReadSurveyService` (one thin port; `GenericResultsetData` is already imported from dataqueries-api).

### Provider peel: fineract-transfer (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-transfer-api` | `org.apache.fineract.transfer.api` | Write port, event type, constants, exceptions |
| `fineract-transfer-impl` | `org.apache.fineract.transfer.impl` | Handlers/validator + `TransferOsgiServiceRegistrar` / `TransferOsgiBundleActivator` |
| `fineract-transfer-test` | `org.apache.fineract.transfer.test` | Fragment-Host → transfer.impl |

Write impl residual in **fineract-progressive-loan-impl**. Equinox registers `TransferWritePlatformService` only (`CommandProcessingResult.empty()`).

### Provider peel: fineract-paymenttype (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-paymenttype-api` | `org.apache.fineract.paymenttype.api` | `PaymentTypeData` + request/response DTOs, read/write ports |
| `fineract-paymenttype-impl` | `org.apache.fineract.paymenttype.impl` | REST/handlers + `PaymentTypeOsgiServiceRegistrar` / `PaymentTypeOsgiBundleActivator` |
| `fineract-paymenttype-test` | `org.apache.fineract.paymenttype.test` | Fragment-Host → paymenttype.impl |

`PaymentType` entity residual in **fineract-core**. Equinox registers `PaymentTypeReadService` only (`retrieveAll*` → empty, `retrieveOne` → null). Did not register `PaymentTypeWriteService` (one thin port).

### Provider peel: fineract-search (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-search-api` | `org.apache.fineract.search.api` | `SearchReadService`, `SearchData`/`SearchConditions`, ad-hoc DTOs |
| `fineract-search-impl` | `org.apache.fineract.search.impl` | REST + `SearchOsgiServiceRegistrar` / `SearchOsgiBundleActivator` |
| `fineract-search-test` | `org.apache.fineract.search.test` | Fragment-Host → search.impl |

`SearchUtil` / advanced-query DTOs residual in **fineract-core**. Equinox registers `SearchReadService` (`retriveMatchingData` / ad-hoc match → empty, template → null).

### Provider peel: fineract-collectionsheet (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-collectionsheet-api` | `org.apache.fineract.collectionsheet.api` | Ports, constants, commands, pure DTOs |
| `fineract-collectionsheet-impl` | `org.apache.fineract.collectionsheet.impl` | REST/handlers + `CollectionSheetOsgiServiceRegistrar` / `CollectionSheetOsgiBundleActivator` |
| `fineract-collectionsheet-test` | `org.apache.fineract.collectionsheet.test` | Fragment-Host → collectionsheet.impl |

Write impl residual in **fineract-progressive-loan-impl**. Equinox registers `CollectionSheetWritePlatformService` only (`CommandProcessingResult.empty()`). Did not register `CollectionSheetReadPlatformService` (leftover core `SavingsProductData` in split package `…savings.data`).

### Provider peel: fineract-accounttransfer (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-accounttransfer-api` | `org.apache.fineract.accounttransfer.api` | Ports, enums, shared DTOs, exceptions, API constants |
| `fineract-accounttransfer-impl` | `org.apache.fineract.accounttransfer.impl` | REST/handlers + `AccountTransferOsgiServiceRegistrar` / `AccountTransferOsgiBundleActivator` |
| `fineract-accounttransfer-test` | `org.apache.fineract.accounttransfer.test` | Fragment-Host → accounttransfer.impl |

Write impl residual in **fineract-progressive-loan-impl**. Kernel residual `PortfolioAccountType` / `PortfolioAccountData` / `AccountTransferData` / `AccountTransfersReadPlatformService`. Equinox registers `StandingInstructionWritePlatformService` only (`CommandProcessingResult.empty()`). Did not register `AccountTransfersReadPlatformService` (kernel leftover), `AccountTransfersCommandWritePort` (leftover `PortfolioAccountType` in split package `…portfolio.account`), or SI read (`Page`).

### Provider peel: fineract-shares (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-shares-api` | `org.apache.fineract.shares.api` | Ports, pure DTOs, constants, exceptions |
| `fineract-shares-impl` | `org.apache.fineract.shares.impl` | REST/handlers + `SharesOsgiServiceRegistrar` / `SharesOsgiBundleActivator` |
| `fineract-shares-test` | `org.apache.fineract.shares.test` | Fragment-Host → shares.impl |

Product JPA residual in **fineract-core**. Equinox registers `ShareProductDropdownReadPlatformService` only (`retrieve*` → empty). Did not register account/product reads (Spring Data `Page`; leftover `ShareProduct*` / `ShareAccount*` types) or dividend reads (`Page`).

## Manifest check

```bash
python3 osgi/check-manifests.py
# or
./gradlew checkOsgiManifests
```

Fails on duplicate BSN, BSN/stem mismatch, missing `Fragment-Host`, impl `Export-Package` that is not exactly one `*.impl.osgi` package, new split packages, a `fineract-core` export list that is empty, overlaps an `*-api` export, or does not match unique kernel source packages, and an `*-api` `Import-Package` that omits an `org.apache.fineract.*` package the sources import when another scanned bundle exports it. Gradle writes `Import-Package` literally — `*` is not BND / `DynamicImport-Package`. There are no remaining allow-listed api-api type splits. Residual same-package leftovers in core stay unpublished from the kernel bundle.

## Layout

| Path | Purpose |
|------|---------|
| `start-equinox.sh` | Start Equinox console on port **2501** (`-configuration` = `config/` directory) |
| `check-manifests.py` | Static BSN / Fragment-Host / Export-Package / api Import-Package guard |
| `resolve-smoke.py` | Bounded Equinox install + resolve of the staged catalog |
| `EquinoxResolveSmoke.java` | Embedded Equinox resolver used by the smoke |
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

Copies every `fineract-*-api`, `fineract-*-impl`, and `fineract-core` jar into `osgi/bundles/` and writes `osgi/config/config.ini` (template + absolute `osgi.bundles` `reference:file:` URLs). Start levels: core `@2`, api `@3`, impl `@4`. Relative bundle paths resolve against `osgi.install.area` (`osgi/equinox`), not the working directory.

## Resolve smoke

```bash
./gradlew equinoxResolveSmoke
# or, after staging:
python3 osgi/resolve-smoke.py
```

Downloads Equinox if needed, compiles `EquinoxResolveSmoke.java`, installs the staged catalog, and resolves it. Writes `osgi/logs/resolve-smoke.txt`. Exit 0 means every staged jar installed. Pass `--strict` to fail when any `org.apache.fineract.*` bundle is INSTALLED.

```bash
./gradlew equinoxStartSmoke
# or, after staging:
python3 osgi/resolve-smoke.py --start --strict
```

Starts every staged bundle after resolve. Command, Wave-1 catalogs, Wave-2, Wave-3, Wave-4, core-slice, and later provider-peel ports register via Bundle-Activators (no Spring). `--strict` requires every fineract bundle to be ACTIVE.

## Start

```bash
./osgi/start-equinox.sh
# or
./gradlew equinoxStart
```

Equinox `-configuration` is the **directory** `osgi/config`, not the template ini file. The script seeds that directory from `osgi/equinox/config.ini` when nothing has been staged yet.

Defaults in `config.ini` enable read/write/batch-manager modes for local experiments.
Do not expose the Equinox console publicly in production.
