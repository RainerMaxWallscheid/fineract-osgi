# Equinox OSGi runtime scaffold (fineract-osgi)

Minimal layout for running Eclipse Equinox alongside Fineract modularization work.
See also `docs/arc42/` (Runtime / Deployment / OSGi concepts).

**Architecture (target):** domain modules split into **api / impl / test** bundles; inter-bundle access only via the **OSGi Service Registry** (not Karaf Features). Spring may remain inside impl bundles. Decisions: [ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md), [ADR-023](../docs/arc42/decisions/ADR-023-fineract-command-module-naming.md) (command module naming). Playbook: [15 OSGi Bundle Refactoring](../docs/arc42/15_osgi_bundle_refactoring.md).

**Catalog status:** complete for every Gradle `api` / `impl` / `test` split (waves 1–4, core slices, leftover peels 1–30). Each impl registers ports via `*OsgiServiceRegistrar`. Each `*-test` is `Fragment-Host` → the matching impl unless noted. Domain consumers depend on **api only**; `fineract-provider` / `fineract-war` compose **api + impl**.

Convention: Bundle-SymbolicName is `org.apache.fineract.<stem>.{api,impl,test}` where `<stem>` is the module name with hyphens removed (`loan-origination` → `loanorigination`). Impl bundles have no `Export-Package` (registrar / DS types stay private). Shared kernel BSN is `org.apache.fineract.core` (no api/impl suffix). Copy jars into `osgi/bundles/` with `./gradlew osgiStageBundles`.

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
| `fineract-rates-impl` | `org.apache.fineract.rates.impl` | JPA + REST + `RatesOsgiServiceRegistrar` / DS `OSGI-INF/rates.xml` |
| `fineract-rates-test` | `org.apache.fineract.rates.test` | Fragment-Host → rates.impl |

Loan uses **rates-api only** (`floatingRateId` + port).

### Wave 1: fineract-tax bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-tax-api` | `org.apache.fineract.tax.api` | `TaxCatalogPort`, `ChargeTaxApplicationService`, exceptions |
| `fineract-tax-impl` | `org.apache.fineract.tax.impl` | JPA + REST + `TaxOsgiServiceRegistrar` / DS `OSGI-INF/tax.xml` |
| `fineract-tax-test` | `org.apache.fineract.tax.test` | Fragment-Host → tax.impl |

Charge/loan/savings use **tax-api only** (`taxGroupId` / `taxComponentId` + ports). Plan: [15_osgi_bundle_refactoring_fineract-tax.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-tax.md).

### Wave 2: fineract-document bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-document-api` | `org.apache.fineract.document.api` | `ContentStoreService`, `ContentStreamPort`, document/image ports |
| `fineract-document-impl` | `org.apache.fineract.document.impl` | FS/S3 + REST + `DocumentOsgiServiceRegistrar` / DS `OSGI-INF/document-store.xml, document-stream.xml` |
| `fineract-document-test` | `org.apache.fineract.document.test` | Fragment-Host → document.impl |

Provider bulk-import uses **`ContentStreamPort`**; composition root still api+impl. Plan: [15_osgi_bundle_refactoring_fineract-document.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-document.md).

### Wave 2: fineract-branch bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-branch-api` | `org.apache.fineract.branch.api` | Teller service interfaces, DTOs, exceptions, pure enums, `CashierTxnValidationPort` |
| `fineract-branch-impl` | `org.apache.fineract.branch.impl` | JPA + REST + `BranchOsgiServiceRegistrar` / DS `OSGI-INF/branch.xml` |
| `fineract-branch-test` | `org.apache.fineract.branch.test` | Fragment-Host → branch.impl |

Loan cash path uses **`CashierTxnValidationPort`**; residual closed. Plan: [15_osgi_bundle_refactoring_fineract-branch.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-branch.md).

### Wave 2: fineract-loan-origination bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-loan-origination-api` | `org.apache.fineract.loanorigination.api` | Originator service ports, DTOs (`LoanOriginatorData`), exceptions |
| `fineract-loan-origination-impl` | `org.apache.fineract.loanorigination.impl` | JPA + REST + `LoanOriginationOsgiServiceRegistrar` / DS `OSGI-INF/loan-origination.xml` (empty catalog, lowest ranking) |
| `fineract-loan-origination-test` | `org.apache.fineract.loanorigination.test` | Fragment-Host → loanorigination.impl |

Loan / WC use **api only**; provider composition root api+impl. Plan: [15_osgi_bundle_refactoring_fineract-loan-origination.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-loan-origination.md).

### Wave 2: fineract-mix bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-mix-api` | `org.apache.fineract.mix.api` | Taxonomy / mapping / XBRL service interfaces + DTOs |
| `fineract-mix-impl` | `org.apache.fineract.mix.impl` | JPA + REST + `MixOsgiServiceRegistrar` / DS `OSGI-INF/mix.xml` (empty catalog, lowest ranking) |
| `fineract-mix-test` | `org.apache.fineract.mix.test` | Fragment-Host → mix.impl |

Provider/war composition root only. Plan: [15_osgi_bundle_refactoring_fineract-mix.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-mix.md).

### Wave 3: fineract-investor bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-investor-api` | `org.apache.fineract.investor.api` | Pure ports, DTOs/status enums, exceptions |
| `fineract-investor-impl` | `org.apache.fineract.investor.impl` | JPA + REST + `InvestorOsgiServiceRegistrar` / DS `OSGI-INF/investor.xml` (empty catalog, lowest ranking) |
| `fineract-investor-test` | `org.apache.fineract.investor.test` | Fragment-Host → investor.impl |

Provider journal residual uses entities/`AccountingService` from impl. Plan: [15_osgi_bundle_refactoring_fineract-investor.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-investor.md).

### Wave 3: fineract-accounting bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-accounting-api` | `org.apache.fineract.accounting.api` | Ports, DTOs, exceptions, pure constants |
| `fineract-accounting-impl` | `org.apache.fineract.accounting.impl` | JPA + REST + `AccountingOsgiServiceRegistrar` / DS `OSGI-INF/accounting.xml` |
| `fineract-accounting-test` | `org.apache.fineract.accounting.test` | Fragment-Host → accounting.impl |

investor-api uses **api only**; loan/savings/provider use api+impl residual. Plan: [15_osgi_bundle_refactoring_fineract-accounting.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-accounting.md).

### Wave 3: fineract-savings bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-savings-api` | `org.apache.fineract.savings.api` | Pure product/application ports, DTOs, exceptions |
| `fineract-savings-impl` | `org.apache.fineract.savings.impl` | Domain + COB + `SavingsOsgiServiceRegistrar` / DS `OSGI-INF/savings.xml` |
| `fineract-savings-test` | `org.apache.fineract.savings.test` | Fragment-Host → savings.impl |

Provider composition root uses api+impl. Plan: [15_osgi_bundle_refactoring_fineract-savings.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-savings.md).

### Wave 4: fineract-loan bundles (complete — entity residual)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-loan-api` | `org.apache.fineract.loan.api` | Pure ports, DTOs, exceptions, selected pure enums |
| `fineract-loan-impl` | `org.apache.fineract.loan.impl` | Domain + COB + `LoanOsgiServiceRegistrar` / DS `OSGI-INF/loan.xml` |
| `fineract-loan-test` | `org.apache.fineract.loan.test` | Fragment-Host → loan.impl |

Progressive / WC / provider / custom use **api + impl**. Plan: [15_osgi_bundle_refactoring_fineract-loan.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-loan.md).

### Wave 4: fineract-progressive-loan bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-progressive-loan-api` | `org.apache.fineract.progressiveloan.api` | Pure ports & calc DTOs |
| `fineract-progressive-loan-impl` | `org.apache.fineract.progressiveloan.impl` | Schedule engine residual + `ProgressiveLoanOsgiServiceRegistrar` / DS `OSGI-INF/progressive-loan.xml` |
| `fineract-progressive-loan-test` | `org.apache.fineract.progressiveloan.test` | Fragment-Host → progressiveloan.impl |

### Wave 4: fineract-working-capital-loan bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-working-capital-loan-api` | `org.apache.fineract.workingcapitalloan.api` | Pure ports, DTOs, exceptions, pure enums |
| `fineract-working-capital-loan-impl` | `org.apache.fineract.workingcapitalloan.impl` | Domain + COB residual + `WorkingCapitalLoanOsgiServiceRegistrar` / DS `OSGI-INF/working-capital-loan.xml` |
| `fineract-working-capital-loan-test` | `org.apache.fineract.workingcapitalloan.test` | Fragment-Host → workingcapitalloan.impl |

### Wave 4: fineract-cob bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-cob-api` | `org.apache.fineract.cob.api` | Pure ports, DTOs, exceptions |
| `fineract-cob-impl` | `org.apache.fineract.cob.impl` | Batch residual + `CobOsgiServiceRegistrar` / DS `OSGI-INF/cob.xml` |
| `fineract-cob-test` | `org.apache.fineract.cob.test` | Fragment-Host → cob.impl |

### Wave 4: fineract-security bundles (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-security-api` | `org.apache.fineract.security.api` | Pure ports, DTOs, exceptions, constants |
| `fineract-security-impl` | `org.apache.fineract.security.impl` | Filters/OIDC residual + `SecurityOsgiServiceRegistrar` / DS `OSGI-INF/security.xml` |
| `fineract-security-test` | `org.apache.fineract.security.test` | Fragment-Host → security.impl |

### Core slice: fineract-businessdate (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-businessdate-api` | `org.apache.fineract.businessdate.api` | Ports, DTOs, exceptions |
| `fineract-businessdate-impl` | `org.apache.fineract.businessdate.impl` | JPA/REST + `BusinessDateOsgiServiceRegistrar` / DS `OSGI-INF/businessdate.xml` |
| `fineract-businessdate-test` | `org.apache.fineract.businessdate.test` | Fragment-Host → businessdate.impl |

Kernel enum `BusinessDateType` remains in **fineract-core**. Plan: [15_osgi_bundle_refactoring_fineract-core-slices.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).

### Core slice: fineract-codes (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-codes-api` | `org.apache.fineract.codes.api` | Pure DTOs + read ports + swagger models |
| `fineract-codes-impl` | `org.apache.fineract.codes.impl` | REST/handlers + `CodesOsgiServiceRegistrar` / DS `OSGI-INF/codes.xml` |
| `fineract-codes-test` | `org.apache.fineract.codes.test` | Fragment-Host → codes.impl |

Entities/exceptions residual in **fineract-core**.

### Core slice: fineract-organisation (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-organisation-api` | `org.apache.fineract.organisation.api` | Office / staff / holiday / working-days / provisioning ports |
| `fineract-organisation-impl` | `org.apache.fineract.organisation.impl` | REST/handlers + `OrganisationOsgiServiceRegistrar` / DS `OSGI-INF/organisation.xml` |
| `fineract-organisation-test` | `org.apache.fineract.organisation.test` | Fragment-Host → organisation.impl |

Office / Staff / Holiday / WorkingDays entities residual in **fineract-core**. Plan: [core slices](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).

### Core slice: fineract-monetary (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-monetary-api` | `org.apache.fineract.monetary.api` | Currency read/write ports, admin DTOs |
| `fineract-monetary-impl` | `org.apache.fineract.monetary.impl` | REST/handlers + `MonetaryOsgiServiceRegistrar` / DS `OSGI-INF/monetary.xml` |
| `fineract-monetary-test` | `org.apache.fineract.monetary.test` | Fragment-Host → monetary.impl |

`Money` / `CurrencyData` residual in **fineract-core**.

### Provider peel: fineract-useradministration (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-useradministration-api` | `org.apache.fineract.useradministration.api` | Read/write ports + password policy DTO |
| `fineract-useradministration-impl` | `org.apache.fineract.useradministration.impl` | REST/handlers + `UserAdministrationOsgiServiceRegistrar` / DS `OSGI-INF/useradministration.xml` |
| `fineract-useradministration-test` | `org.apache.fineract.useradministration.test` | Fragment-Host → useradministration.impl |

`AppUser` / `Role` / `Permission` and shared DTOs residual in **fineract-core**.

### Provider peel: fineract-adhocquery (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-adhocquery-api` | `org.apache.fineract.adhocquery.api` | Ports, DTOs, `ReportRunFrequency`, exceptions |
| `fineract-adhocquery-impl` | `org.apache.fineract.adhocquery.impl` | REST/entity/handlers + `AdhocQueryOsgiServiceRegistrar` / DS `OSGI-INF/adhocquery.xml` |
| `fineract-adhocquery-test` | `org.apache.fineract.adhocquery.test` | Fragment-Host → adhocquery.impl |

### Provider peel: fineract-template (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-template-api` | `org.apache.fineract.template.api` | Ports, DTOs, enums, commands, exceptions |
| `fineract-template-impl` | `org.apache.fineract.template.impl` | REST/entity/merge + `TemplateOsgiServiceRegistrar` / DS `OSGI-INF/template.xml` |
| `fineract-template-test` | `org.apache.fineract.template.test` | Fragment-Host → template.impl |

### Provider peel: fineract-notification (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-notification-api` | `org.apache.fineract.notification.api` | Read/write ports, event publisher port, DTOs |
| `fineract-notification-impl` | `org.apache.fineract.notification.impl` | REST/JPA/JMS + `NotificationOsgiServiceRegistrar` / DS `OSGI-INF/notification.xml` |
| `fineract-notification-test` | `org.apache.fineract.notification.test` | Fragment-Host → notification.impl |

### Provider peel: fineract-spm (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-spm-api` | `org.apache.fineract.spm.api` | DTOs, exceptions, `ScorecardReadPlatformService`, constants |
| `fineract-spm-impl` | `org.apache.fineract.spm.impl` | REST/JPA + `SpmOsgiServiceRegistrar` / DS `OSGI-INF/spm.xml` |
| `fineract-spm-test` | `org.apache.fineract.spm.test` | Fragment-Host → spm.impl |

### Provider peel: fineract-fund (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-fund-api` | `org.apache.fineract.fund.api` | `FundData`/`FundRequest`, read/write ports |
| `fineract-fund-impl` | `org.apache.fineract.fund.impl` | REST/handlers + `FundOsgiServiceRegistrar` / DS `OSGI-INF/fund.xml` |
| `fineract-fund-test` | `org.apache.fineract.fund.test` | Fragment-Host → fund.impl |

`Fund` entity residual in **fineract-core**.

### Provider peel: fineract-accountnumberformat (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-accountnumberformat-api` | `org.apache.fineract.accountnumberformat.api` | `AccountNumberFormatData`, read/write ports |
| `fineract-accountnumberformat-impl` | `org.apache.fineract.accountnumberformat.impl` | REST/handlers + `AccountNumberFormatOsgiServiceRegistrar` / DS `OSGI-INF/accountnumberformat.xml` |
| `fineract-accountnumberformat-test` | `org.apache.fineract.accountnumberformat.test` | Fragment-Host → accountnumberformat.impl |

Entity / generator residual in **fineract-core**.

### Provider peel: fineract-survey (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-survey-api` | `org.apache.fineract.survey.api` | PPI/likelihood/poverty-line DTOs and ports |
| `fineract-survey-impl` | `org.apache.fineract.survey.impl` | REST/JPA + `SurveyOsgiServiceRegistrar` / DS `OSGI-INF/survey.xml` |
| `fineract-survey-test` | `org.apache.fineract.survey.test` | Fragment-Host → survey.impl |

Datatable ports come from **fineract-core**. Equinox registers `ReadLikelihoodService` only (`retrieveAll` → empty, `retrieve` → null). Did not register `ReadSurveyService` (one thin port; `GenericResultsetData` is already imported from dataqueries-api).

### Provider peel: fineract-transfer (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-transfer-api` | `org.apache.fineract.transfer.api` | Write port, event type, constants, exceptions |
| `fineract-transfer-impl` | `org.apache.fineract.transfer.impl` | Handlers/validator + `TransferOsgiServiceRegistrar` / DS `OSGI-INF/transfer.xml` |
| `fineract-transfer-test` | `org.apache.fineract.transfer.test` | Fragment-Host → transfer.impl |

Write impl residual in **fineract-progressive-loan-impl**. Equinox registers `TransferWritePlatformService` only (`CommandProcessingResult.empty()`).

### Provider peel: fineract-paymenttype (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-paymenttype-api` | `org.apache.fineract.paymenttype.api` | `PaymentTypeData` + request/response DTOs, read/write ports |
| `fineract-paymenttype-impl` | `org.apache.fineract.paymenttype.impl` | REST/handlers + `PaymentTypeOsgiServiceRegistrar` / DS `OSGI-INF/paymenttype.xml` |
| `fineract-paymenttype-test` | `org.apache.fineract.paymenttype.test` | Fragment-Host → paymenttype.impl |

`PaymentType` entity residual in **fineract-core**. Equinox registers `PaymentTypeReadService` only (`retrieveAll*` → empty, `retrieveOne` → null). Did not register `PaymentTypeWriteService` (one thin port).

### Provider peel: fineract-search (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-search-api` | `org.apache.fineract.search.api` | `SearchReadService`, `SearchData`/`SearchConditions`, ad-hoc DTOs |
| `fineract-search-impl` | `org.apache.fineract.search.impl` | REST + `SearchOsgiServiceRegistrar` / DS `OSGI-INF/search.xml` |
| `fineract-search-test` | `org.apache.fineract.search.test` | Fragment-Host → search.impl |

`SearchUtil` / advanced-query DTOs residual in **fineract-core**. Equinox registers `SearchReadService` (`retriveMatchingData` / ad-hoc match → empty, template → null).

### Provider peel: fineract-collectionsheet (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-collectionsheet-api` | `org.apache.fineract.collectionsheet.api` | Ports, constants, commands, pure DTOs |
| `fineract-collectionsheet-impl` | `org.apache.fineract.collectionsheet.impl` | REST/handlers + `CollectionSheetOsgiServiceRegistrar` / DS `OSGI-INF/collectionsheet.xml` |
| `fineract-collectionsheet-test` | `org.apache.fineract.collectionsheet.test` | Fragment-Host → collectionsheet.impl |

Write impl residual in **fineract-progressive-loan-impl**. Equinox registers `CollectionSheetWritePlatformService` only (`CommandProcessingResult.empty()`). Did not register `CollectionSheetReadPlatformService` (leftover core `SavingsProductData` in split package `…savings.data`).

### Provider peel: fineract-accounttransfer (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-accounttransfer-api` | `org.apache.fineract.accounttransfer.api` | Ports, enums, shared DTOs, exceptions, API constants |
| `fineract-accounttransfer-impl` | `org.apache.fineract.accounttransfer.impl` | REST/handlers + `AccountTransferOsgiServiceRegistrar` / DS `OSGI-INF/accounttransfer.xml` |
| `fineract-accounttransfer-test` | `org.apache.fineract.accounttransfer.test` | Fragment-Host → accounttransfer.impl |

Write impl residual in **fineract-progressive-loan-impl**. Kernel residual `PortfolioAccountType` / `PortfolioAccountData` / `AccountTransferData` / `AccountTransfersReadPlatformService`. Equinox registers `StandingInstructionWritePlatformService` only (`CommandProcessingResult.empty()`). Did not register `AccountTransfersReadPlatformService` (kernel leftover), `AccountTransfersCommandWritePort` (leftover `PortfolioAccountType` in split package `…portfolio.account`), or SI read (`Page`).

### Provider peel: fineract-shares (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-shares-api` | `org.apache.fineract.shares.api` | Ports, pure DTOs, constants, exceptions |
| `fineract-shares-impl` | `org.apache.fineract.shares.impl` | REST/handlers + `SharesOsgiServiceRegistrar` / DS `OSGI-INF/shares.xml` |
| `fineract-shares-test` | `org.apache.fineract.shares.test` | Fragment-Host → shares.impl |

Product JPA residual in **fineract-core**. Equinox registers `ShareProductDropdownReadPlatformService` only (`retrieve*` → empty). Did not register account/product reads (Spring Data `Page`; leftover `ShareProduct*` / `ShareAccount*` types) or dividend reads (`Page`).

### Provider peel: fineract-group (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-group-api` | `org.apache.fineract.group.api` | Read/write ports, enumerations helper |
| `fineract-group-impl` | `org.apache.fineract.group.impl` | REST/handlers + `GroupOsgiServiceRegistrar` / DS `OSGI-INF/group.xml` |
| `fineract-group-test` | `org.apache.fineract.group.test` | Fragment-Host → group.impl |

Entity/DTO residual in **fineract-core**. Equinox registers `GroupLevelReadPlatformService` only (`retrieveAllLevels` → empty). Did not register `GroupReadPlatformService` / `CenterReadPlatformService` (leftover `GroupGeneralData` / `CenterData`; `Page`).

### Provider peel: fineract-clients (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-clients-api` | `org.apache.fineract.clients.api` | Ports, pure DTOs/requests, search v2 API types |
| `fineract-clients-impl` | `org.apache.fineract.clients.impl` | REST/handlers + `ClientsOsgiServiceRegistrar` / DS `OSGI-INF/clients.xml` |
| `fineract-clients-test` | `org.apache.fineract.clients.test` | Fragment-Host → clients.impl |

`Client` / `ClientData` residual in **fineract-core**. Equinox registers `ClientIdentifierWritePlatformService` only (`CommandProcessingResult.empty()`). Did not register `ClientReadPlatformService` / `ClientWritePlatformService` / `ClientTemplateReadPlatformService` (leftover `Client` / `ClientData`) or search (`Page`).

### Provider peel: fineract-postdatedchecks (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-postdatedchecks-api` | `org.apache.fineract.postdatedchecks.api` | Ports, DTOs, status, exceptions |
| `fineract-postdatedchecks-impl` | `org.apache.fineract.postdatedchecks.impl` | REST/handlers + `PostDatedChecksOsgiServiceRegistrar` / DS `OSGI-INF/postdatedchecks.xml` |
| `fineract-postdatedchecks-test` | `org.apache.fineract.postdatedchecks.test` | Fragment-Host → postdatedchecks.impl |

Entity residual in **fineract-loan-impl**. Equinox registers `RepaymentWithPostDatedChecksWritePlatformService` only (`CommandProcessingResult.empty()`). Did not register `RepaymentWithPostDatedChecksReadPlatformService` (one thin port).

### Provider peel: fineract-products (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-products-api` | `org.apache.fineract.products.api` | `ShareProductReadPlatformService`, `ProductCommandsService`, `ProductData` |
| `fineract-products-impl` | `org.apache.fineract.products.impl` | REST + `ProductsOsgiServiceRegistrar` / DS `OSGI-INF/products.xml` |
| `fineract-products-test` | `org.apache.fineract.products.test` | Fragment-Host → products.impl |

`ProductNotFoundException` residual in **fineract-core**. Equinox registers `ProductCommandsService` only (`handleCommand` → null). Did not register `ShareProductReadPlatformService` (`Page`).

### Provider peel: fineract-paymentdetail (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-paymentdetail-api` | `org.apache.fineract.paymentdetail.api` | Write port, constants |
| `fineract-paymentdetail-impl` | `org.apache.fineract.paymentdetail.impl` | Write impl + `PaymentDetailOsgiServiceRegistrar` / DS `OSGI-INF/paymentdetail.xml` |
| `fineract-paymentdetail-test` | `org.apache.fineract.paymentdetail.test` | Fragment-Host → paymentdetail.impl |

`PaymentDetail` entity / `PaymentDetailData` residual in **fineract-core**. Equinox registers `PaymentDetailWritePlatformService` only (`create*` / `persist*` → null).

### Provider peel: fineract-cache (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-cache-api` | `org.apache.fineract.cache.api` | Write port, switch request/response DTOs |
| `fineract-cache-impl` | `org.apache.fineract.cache.impl` | REST/handler + `CacheOsgiServiceRegistrar` / DS `OSGI-INF/cache.xml` |
| `fineract-cache-test` | `org.apache.fineract.cache.test` | Fragment-Host → cache.impl |

`CacheType` / `PlatformCache` residual in **fineract-core**. Equinox registers `CacheWritePlatformService` only (`switchToCache` → empty).

### Provider peel: fineract-entityaccess (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-entityaccess-api` | `org.apache.fineract.entityaccess.api` | Ports, DTOs, access types, exceptions |
| `fineract-entityaccess-impl` | `org.apache.fineract.entityaccess.impl` | REST/JPA + `EntityAccessOsgiServiceRegistrar` / DS `OSGI-INF/entityaccess.xml` |
| `fineract-entityaccess-test` | `org.apache.fineract.entityaccess.test` | Fragment-Host → entityaccess.impl |

Equinox registers `FineractEntityAccessReadService` only (`retrieve*` → empty, SQL clauses → `""`). Did not register `FineractEntityAccessWriteService` (leftover `CodeValue` in `…codes.domain`).

### Provider peel: fineract-calendar (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-calendar-api` | `org.apache.fineract.calendar.api` | Read/write/dropdown ports, exceptions, command, `CalendarRequest`, `CalendarInstanceLookupPort` |
| `fineract-calendar-impl` | `org.apache.fineract.calendar.impl` | REST/handlers + `CalendarOsgiServiceRegistrar` / DS `OSGI-INF/calendar.xml` |
| `fineract-calendar-test` | `org.apache.fineract.calendar.test` | Fragment-Host → calendar.impl |

Entity / `CalendarData` residual in **fineract-core**. Equinox registers `CalendarDropdownReadPlatformService` only (`retrieve*` → empty). Did not register `CalendarReadPlatformService` (leftover `CalendarData`) or `CalendarInstanceLookupPort` (leftover `CalendarInstance`).

### Provider peel: fineract-meeting (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-meeting-api` | `org.apache.fineract.meeting.api` | DTOs, commands, ports, exceptions |
| `fineract-meeting-impl` | `org.apache.fineract.meeting.impl` | REST/JPA + `MeetingOsgiServiceRegistrar` / DS `OSGI-INF/meeting.xml` |
| `fineract-meeting-test` | `org.apache.fineract.meeting.test` | Fragment-Host → meeting.impl |

Equinox registers `MeetingAttendanceDropdownReadService` only (`retrieveAttendanceTypeOptions` → empty). Did not register `MeetingReadService` (leftover `MeetingData` coupling).

### Provider peel: fineract-address (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-address-api` | `org.apache.fineract.address.api` | Ports, DTOs, filter, exception |
| `fineract-address-impl` | `org.apache.fineract.address.impl` | REST/JPA + `AddressOsgiServiceRegistrar` / DS `OSGI-INF/address.xml` |
| `fineract-address-test` | `org.apache.fineract.address.test` | Fragment-Host → address.impl |

`AddressData` residual in **fineract-core**. Equinox registers `FieldConfigurationReadPlatformService` only (`retrieve*` → empty). Did not register `AddressReadPlatformService` (leftover `AddressData`) or `AddressWritePlatformService` (leftover `Client`).

### Provider peel: fineract-creditbureau (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-creditbureau-api` | `org.apache.fineract.creditbureau.api` | DTOs, ports, exception |
| `fineract-creditbureau-impl` | `org.apache.fineract.creditbureau.impl` | REST/JPA + `CreditBureauOsgiServiceRegistrar` / DS `OSGI-INF/creditbureau.xml` |
| `fineract-creditbureau-test` | `org.apache.fineract.creditbureau.test` | Fragment-Host → creditbureau.impl |

Equinox registers `CreditBureauReadPlatformService` only (`retrieveCreditBureau` → empty). Did not register loan-product mapping reads (loan-impl coupling).

### Provider peel: fineract-collateral (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-collateral-api` | `org.apache.fineract.collateral.api` | Ports, DTOs, exceptions |
| `fineract-collateral-impl` | `org.apache.fineract.collateral.impl` | REST/JPA + `CollateralOsgiServiceRegistrar` / DS `OSGI-INF/collateral.xml` |
| `fineract-collateral-test` | `org.apache.fineract.collateral.test` | Fragment-Host → collateral.impl |

Equinox registers `CollateralWritePlatformService` only (`add*`/`update*`/`delete*` → empty). Did not register `CollateralReadPlatformService` (leftover `CurrencyData` in `organisation.monetary.data`, which monetary-api also exports).

### Provider peel: fineract-collateralmanagement (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-collateralmanagement-api` | `org.apache.fineract.collateralmanagement.api` | Ports, DTOs, exceptions |
| `fineract-collateralmanagement-impl` | `org.apache.fineract.collateralmanagement.impl` | REST/JPA + `CollateralManagementOsgiServiceRegistrar` / DS `OSGI-INF/collateralmanagement.xml` |
| `fineract-collateralmanagement-test` | `org.apache.fineract.collateralmanagement.test` | Fragment-Host → collateralmanagement.impl |

Equinox registers `CollateralManagementReadService` only (`getCollateralProduct` → null, `getAllCollateralProducts` → empty). Did not register client/loan reads (leftover `ClientCollateralManagementData`; `LoanCollateralResponseData` loads `loanaccount.data.LoanCollateralManagementData`) or writes (request DTOs pull swagger / jakarta.validation).

### Provider peel: fineract-note (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-note-api` | `org.apache.fineract.note.api` | Ports, DTOs, NoteType, exceptions |
| `fineract-note-impl` | `org.apache.fineract.note.impl` | REST/JPA + `NoteOsgiServiceRegistrar` / DS `OSGI-INF/note.xml` |
| `fineract-note-test` | `org.apache.fineract.note.test` | Fragment-Host → note.impl |

Equinox registers `NoteReadPlatformService` only (`retrieveNote` → null, `retrieveNotesByResource` → empty). Did not register `NoteWritePlatformService` (request DTOs pull swagger / jakarta.validation) or `ShareAccountNoteSupport` (share residual on provider).

### Provider peel: fineract-hooks (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-hooks-api` | `org.apache.fineract.hooks.api` | Ports, DTOs, exceptions, constants |
| `fineract-hooks-impl` | `org.apache.fineract.hooks.impl` | REST/JPA + `HooksOsgiServiceRegistrar` / DS `OSGI-INF/hooks.xml` |
| `fineract-hooks-test` | `org.apache.fineract.hooks.test` | Fragment-Host → hooks.impl |

Equinox registers `HookReadPlatformService` only (`retrieveAllHooks` → empty, `retrieveHook` / `retrieveNewHookDetails` → null). Did not register `HookWritePlatformService` (request DTOs pull jakarta.validation).

### Provider peel: fineract-sms (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-sms-api` | `org.apache.fineract.sms.api` | Ports, DTOs, exceptions, constants |
| `fineract-sms-impl` | `org.apache.fineract.sms.impl` | REST/JPA + `SmsOsgiServiceRegistrar` / DS `OSGI-INF/sms.xml` |
| `fineract-sms-test` | `org.apache.fineract.sms.test` | Fragment-Host → sms.impl |

Equinox registers `SmsWritePlatformService` only (`create`/`update`/`delete` → empty). Did not register `SmsReadPlatformService` (`Page` / `SearchParameters`).

### Provider peel: fineract-reportmailingjob (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-reportmailingjob-api` | `org.apache.fineract.reportmailingjob.api` | Ports, DTOs, exceptions, constants |
| `fineract-reportmailingjob-impl` | `org.apache.fineract.reportmailingjob.impl` | REST/JPA + `ReportMailingJobOsgiServiceRegistrar` / DS `OSGI-INF/reportmailingjob.xml` |
| `fineract-reportmailingjob-test` | `org.apache.fineract.reportmailingjob.test` | Fragment-Host → reportmailingjob.impl |

Equinox registers `ReportMailingJobConfigurationReadPlatformService` only (`retrieveAll*` → empty, `retrieveReportMailingJobConfiguration` → null). Did not register job/run-history reads (`Page` / leftover `ReportData`) or write/email ports.

### Provider peel: fineract-campaigns (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-campaigns-api` | `org.apache.fineract.campaigns.api` | Ports, DTOs, exceptions, constants |
| `fineract-campaigns-impl` | `org.apache.fineract.campaigns.impl` | REST/JPA + `CampaignsOsgiServiceRegistrar` / DS `OSGI-INF/campaigns.xml` |
| `fineract-campaigns-test` | `org.apache.fineract.campaigns.test` | Fragment-Host → campaigns.impl |

Equinox registers `SmsCampaignDropdownReadPlatformService` only (`retrieve*` → empty). Did not register SMS/email campaign or email reads (`Page` / leftover `ReportData`), `TwoFactorSmsDeliveryPort` (leftover `Staff`), or write/email-job ports.

### Provider peel: fineract-gcm (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-gcm-api` | `org.apache.fineract.gcm.api` | Config DTO + `NotificationConfigurationReadService` |
| `fineract-gcm-impl` | `org.apache.fineract.gcm.impl` | Sender + `GcmOsgiServiceRegistrar` / DS `OSGI-INF/gcm.xml` |
| `fineract-gcm-test` | `org.apache.fineract.gcm.test` | Fragment-Host → gcm.impl |

Equinox registers `NotificationConfigurationReadService` only (`getNotificationConfiguration` → null). Did not register `NotificationSenderService` (impl-only; SMS/JPA coupling).

### Provider peel: fineract-dataqueries (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-dataqueries-api` | `org.apache.fineract.dataqueries.api` | Ports, extra DTOs, exceptions |
| `fineract-dataqueries-impl` | `org.apache.fineract.dataqueries.impl` | REST/JPA + `DataqueriesOsgiServiceRegistrar` / DS `OSGI-INF/dataqueries.xml` |
| `fineract-dataqueries-test` | `org.apache.fineract.dataqueries.test` | Fragment-Host → dataqueries.impl |

Equinox registers `ReportWritePlatformService` only (`create*`/`update*`/`delete*` → empty). Did not register `ReadReportingService` / template reads (leftover unpublished `ReportData` / `DatatableData`), leftover `DatatableReadService` / `GenericDataService`, or export/check ports (jakarta.ws.rs / Gson).

### Provider peel: fineract-configuration (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-configuration-api` | `org.apache.fineract.configuration.api` | External-services ports/DTOs |
| `fineract-configuration-impl` | `org.apache.fineract.configuration.impl` | REST/JPA + `ConfigurationOsgiServiceRegistrar` / DS `OSGI-INF/configuration.xml` |
| `fineract-configuration-test` | `org.apache.fineract.configuration.test` | Fragment-Host → configuration.impl |

Equinox registers `ExternalServicesReadPlatformService` only (`getExternalServiceDetailsByServiceName` → null). Did not register properties read (`MaskedValueSerializer` leftover; extends `NotificationConfigurationReadService`), leftover global-config ports, or write ports.

### Provider peel: fineract-bulkimport (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-bulkimport-api` | `org.apache.fineract.bulkimport.api` | Constants, SPI, extra DTOs |
| `fineract-bulkimport-impl` | `org.apache.fineract.bulkimport.impl` | REST/JPA + `BulkImportOsgiServiceRegistrar` (no Equinox port) |
| `fineract-bulkimport-test` | `org.apache.fineract.bulkimport.test` | Fragment-Host → bulkimport.impl |

No Equinox port. Did not register `BulkImportWorkbookService` (jersey multipart), `BulkImportWorkbookPopulatorService` (jakarta.ws.rs), or POI `WorkbookPopulator` / `ImportHandler`.

### Provider peel: fineract-instancemode (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-instancemode-api` | `org.apache.fineract.instancemode.api` | Swagger request DTO + servlet filter |
| `fineract-instancemode-impl` | `org.apache.fineract.instancemode.impl` | Test-profile REST + `InstanceModeOsgiServiceRegistrar` (no Equinox port) |
| `fineract-instancemode-test` | `org.apache.fineract.instancemode.test` | Fragment-Host → instancemode.impl |

No Equinox port. instancemode-api has no application port (swagger DTO + `FineractInstanceModeApiFilter` only).

### Provider peel: fineract-jobs (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-jobs-api` | `org.apache.fineract.jobs.api` | SPI, exceptions, constants |
| `fineract-jobs-impl` | `org.apache.fineract.jobs.impl` | Quartz/Batch/REST + `JobsOsgiServiceRegistrar` / DS `OSGI-INF/jobs.xml` |
| `fineract-jobs-test` | `org.apache.fineract.jobs.test` | Fragment-Host → jobs.impl |

Equinox registers `StuckJobExecutorService` only (`resumeStuckJob` no-op). Did not register leftover `SchedulerJobRunnerReadService` (`Page`/`SearchParameters`, unpublished `JobDetailData`), `NamedJobLaunchPort` / `JobParameterProvider` (unpublished `JobParameterDTO`; Spring Batch), or servlet COB filters.

### Provider peel: fineract-s3 (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-s3-api` | `org.apache.fineract.s3.api` | `S3ClientCustomizer` SPI |
| `fineract-s3-impl` | `org.apache.fineract.s3.impl` | Amazon/Localstack config + `S3OsgiServiceRegistrar` (no Equinox port) |
| `fineract-s3-test` | `org.apache.fineract.s3.test` | Fragment-Host → s3.impl |

No Equinox port. Did not register `S3ClientCustomizer` (AWS SDK `S3ClientBuilder` has no staged Equinox BSN).

### Provider peel: fineract-openapi (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-openapi-api` | `org.apache.fineract.openapi.api` | swagger-gradle-plugin reader/filter utilities |
| `fineract-openapi-impl` | `org.apache.fineract.openapi.impl` | `OpenApiOsgiServiceRegistrar` (no Equinox port) |
| `fineract-openapi-test` | `org.apache.fineract.openapi.test` | Fragment-Host → openapi.impl |

No Equinox port. openapi-api has no application port (`FineractOperationIdReader` / `FineractOpenApiSpecFilter` only).

### Provider peel: fineract-springbatch (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-springbatch-api` | `org.apache.fineract.springbatch.api` | `PropertyService`, constants, handler conditions |
| `fineract-springbatch-impl` | `org.apache.fineract.springbatch.impl` | JMS/Kafka/Spring events + `SpringBatchOsgiServiceRegistrar` / DS `OSGI-INF/springbatch.xml` |
| `fineract-springbatch-test` | `org.apache.fineract.springbatch.test` | Fragment-Host → springbatch.impl |

Equinox registers `PropertyService` only (partition/chunk sizes → null). Did not register Spring `AllNestedConditions` handlers or `ContextualMessage` (Spring Batch `StepExecutionRequest`).

### Provider peel: fineract-interoperation (complete)

| Artifact | Bundle-SymbolicName | Notes |
|----------|---------------------|-------|
| `fineract-interoperation-api` | `org.apache.fineract.interoperation.api` | Ports, DTOs, enums, exceptions |
| `fineract-interoperation-impl` | `org.apache.fineract.interoperation.impl` | REST/JPA + `InteroperationOsgiServiceRegistrar` (no Equinox port) |
| `fineract-interoperation-test` | `org.apache.fineract.interoperation.test` | Fragment-Host → interoperation.impl |

No Equinox port. Did not register `InteropService` (jakarta.validation; leftover unpublished `DepositAccountType` / `SavingsAccountTransactionType` in savings-api-exported packages). Skipped `fineract-event` (leftover `ExternalEventProducer` in core only).

## Manifest check

```bash
python3 osgi/check-manifests.py
# or
./gradlew checkOsgiManifests
```

Fails on duplicate BSN, BSN/stem mismatch, missing `Fragment-Host`, impl `Export-Package` that is not empty, any impl `Bundle-Activator`, a missing `Service-Component` descriptor, implementation class, or provide interface on `*-api` / `fineract-core`, a DS provide interface that is not a PILOT_PORT, unused `org.osgi.framework` Import-Package on a DS or no-port impl, a DS impl missing `Require-Capability` `osgi.extender=osgi.component`, an impl with no Equinox start path (unless it is a no-port stem), new split packages, a `fineract-core` export list that is empty, overlaps an `*-api` export, or does not match unique kernel source packages, and an `*-api` `Import-Package` that omits an `org.apache.fineract.*` package the sources import when another scanned bundle exports it. Gradle writes `Import-Package` literally — `*` is not BND / `DynamicImport-Package`. There are no remaining allow-listed api-api type splits. Residual same-package leftovers in core stay unpublished from the kernel bundle.

```bash
python3 osgi/check-foreign-impl-deps.py
# or
./gradlew checkForeignImplDeps
```

Fails on a new domain `*-impl` dependency on a foreign `*-impl`, any `*-api` dependency on a `*-impl`, or a stale `osgi/foreign-impl-allowlist.txt` row. Composition roots are not scanned. Remaining allow-listed edges are leftover JPA residuals. Full OSGi lookup is started (ADR-022 B4): `ChargeDefinitionPort` Boot consumers resolve via a `@Primary` Service Registry façade when `fineract.osgi.enabled=true`; remaining PILOT_PORTs still Spring-inject.

```bash
python3 osgi/check-archunit-freeze.py
# or
./gradlew checkArchUnitFreeze
```

Fails when leftover ArchUnit freeze-store lines exceed `osgi/archunit-freeze-budget.txt`, or when the budget is stale after a shrink. Remaining lines are leftover JPA / entity residuals (ADR-022 B5). Freeze shrink started at 66 leftover JPA/entity lines. Leftover catalog enums are closed onto `moduleapi`. WC journals use `WorkingCapitalLoanJournalPort`. Savings journals use `SavingsJournalPort`. Loan-transaction journals use `LoanJournalPort`. Investor external-transfer allowed-status checks compare config strings to `LoanDataForExternalTransfer.getLoanStatusName()`. Investor transfer owner mapping uses overpayment amount (not leftover `LoanStatus`). External-owner transfer journals post through `ExternalOwnerTransferJournalPort`. Transfer initiation uses `LoanDataForExternalTransferPort`. Loan-product attribute validation uses `LoanProductExistencePort`. Sale deferred-income recognition uses `LoanSaleDeferredIncomePort`. Transfer outstanding interest uses `LoanOutstandingInterestPort`. Transferability uses `LoanTransferBalancePort`. Transfer detail amounts use `LoanTransferSnapshotPort`. Ownership-transfer event serialization uses `LoanOwnershipEventDataPort`. COB delayed-settlement product id uses `LoanTransferBalancePort`. Transfer journal charge-off/office/currency context uses `LoanTransferJournalContextPort`. Ownership COB/service loan ids use `LoanTransferBalancePort.loanId`. Loan-linked savings validation uses `LinkedSavingsAccountPort`. `checkClientOrGroupActive` client probes use `ClientActivePort`; group probes use `GroupActivePort`. WC application validation and loan-schedule office lookup use client/group `officeId` ports. Savings/deposit JSON assemble and modify `isNotActive` use `ClientActivePort`/`GroupActivePort`. Loan assembler office lookup uses `officeId` ports and `Loan.getClientId()`. WC assembler client ids use JSON/`WorkingCapitalLoan.getClientId()`. Loan transfer-date checks use `ClientActivePort.officeJoiningDate`. WC disbursement/undo/charge client-active checks use `ClientActivePort`. WC journals and loan/WC mappers use loan `officeId`/`clientId`; application office lookup uses client/group `officeId` ports. Loan-application client/group validation uses `ClientActivePort`/`GroupActivePort.hasClientAsMember`. Guarantor duplicate-name and existence checks use `ClientActivePort.displayName`. Loan/WC mappers read client name/account/external id via `ClientActivePort`. Guarantor savings activation uses `LinkedSavingsAccountPort`. Client collateral lists query by client id; inherited RD calendars use `ClientActivePort.groupIds`. Linked-loan savings id/account-number reads use `AccountAssociations.linkedSavingsAccountId` / `linkedSavingsAccountNumber`. Guarantor linked-savings ids use `GuarantorFundingDetails.linkedSavingsAccountId`. Client collateral data reads client id via JPQL. Loan-loss provisioning reserve currency uses application currency from the provisioning DTO code. Investor branch-closure checks read `acc_gl_closure` by office id. Investor owner mapping uses in-flight journal credit flags. Investor debit/credit journals persist through `ExternalOwnerTransferJournalPort`. Investor linked/charge-off GL lookups use `ExternalOwnerTransferJournalPort`. Investor owner-mapping journal loads use `ExternalOwnerTransferJournalPort`. Investor helper/mapping journal signatures are Object-typed. Investor transfer journal posting takes Object loan. Investor COB/service transfer helpers take Object loan. Investor ownership-transfer events take Object loan and loan id. External-owner journal mapping lives on accounting `moduleapi`. Investor accounting helpers no longer keep leftover mapping/journal/closure repos. Loan-loss provisioning entries store product id (not leftover LoanProduct). External-owner journal mappings store journal entry id (not leftover JournalEntry). Client collateral entities store client id (not leftover Client). Deposit interest-incentive DTOs take Object client. Savings application DTOs take Object client/group. Loan linked-savings helpers take Object savings. Guarantor on-hold helpers take Object on-hold transactions. Guarantor funding transactions store on-hold transaction id (not leftover DepositAccountOnHoldTransaction). GLIM accounts store group id (not leftover Group). GSIM accounts store group id (not leftover Group). Guarantor hold/release funds use `DepositAccountOnHoldPort`. Guarantor on-hold persist uses `DepositAccountOnHoldPort`. Guarantor hold-summary reconstruction uses `DepositAccountOnHoldPort`. Loan linked-savings association writes use `LinkedSavingsAccountPort.persistableById`. GSIM child lookup for loan-linked savings uses `LinkedSavingsAccountPort.childAccountIdForGsimClient`. Unused leftover loan savings-assembler/repo ctor siblings dropped together with leftover Client ctor siblings. Unused leftover Client ctor siblings dropped from loan-schedule assembler and WC application validator. Savings/deposit JSON assemble group-membership checks use `GroupActivePort.hasClientAsMember`. Savings DTO assemble takes Object client/group and reads ids via `ClientActivePort.id` / `GroupActivePort.id`. Savings/deposit application client association writes use `ClientActivePort.persistableById`. Deposit interest-incentive Client attributes use `ClientActivePort.incentiveAttributes`. Savings account client/group id, office id, and transaction-allowed checks use `ClientActivePort` / `GroupActivePort`. Savings account activate/validate client and group dates use `ClientActivePort` / `GroupActivePort`. Savings account office lookup uses `ClientActivePort.office` / `GroupActivePort.office`. Loan client/group id and office lookup use `ClientActivePort` / `GroupActivePort`. WC loan client id and office lookup use `ClientActivePort`. Loan factory, constructor, and client/group updates take Object client/group. Savings/FD/RD factory and constructor take Object client/group. Savings account client/group updates take Object client/group. Do not peel `fineract-core` or the composition root to force a shrink.

## Layout

| Path | Purpose |
|------|---------|
| `start-equinox.sh` | Start Equinox console on port **2501** (`-configuration` = `config/` directory) |
| `check-manifests.py` | Static BSN / Fragment-Host / Export-Package / api Import-Package guard |
| `check-foreign-impl-deps.py` | B4 Gradle/api-first guard: no new domain foreign `-impl` |
| `foreign-impl-allowlist.txt` | Leftover JPA `*-impl` → foreign `*-impl` edges |
| `check-archunit-freeze.py` | B5 freeze-store budget: leftover violation lines must not grow |
| `archunit-freeze-budget.txt` | Current leftover ArchUnit freeze-store line count |
| `resolve-smoke.py` | Bounded Equinox install + resolve of the staged catalog |
| `EquinoxResolveSmoke.java` | Embedded Equinox resolver used by the smoke |
| `CompositionRootOsgiBridge.java` | Composition-root Spring→OSGi registration of every hosted PILOT_PORT |
| `Hosted*.java` | In-memory hosted ports for the bridge smoke (one per catalog module) |
| `EquinoxSpringBridgeSmoke.java` | Start catalog, register hosted PILOT_PORTs, assert ranking |
| `spring-bridge-smoke.py` | Compiles and runs the composition-root bridge smoke |
| `equinox/config.ini` | Framework + Fineract mode **template** |
| `equinox/org.eclipse.osgi-*.jar` | Framework JAR (**not** in git; download locally) |
| `ensure-ds-runtime.py` | Download Felix SCR + OSGi DS API jars into `equinox/` (B6) |
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

Copies every `fineract-*-api`, `fineract-*-impl`, and `fineract-core` jar into `osgi/bundles/` and writes `osgi/config/config.ini` (template + absolute `osgi.bundles` `reference:file:` URLs). Start levels: Felix SCR + OSGi DS API `@1`, core `@2`, api `@3`, impl `@4`. Relative bundle paths resolve against `osgi.install.area` (`osgi/equinox`), not the working directory. Equinox-safe empty catalog ports and the command dispatcher graph register via Declarative Services (`Service-Component`). No-port modules have no Equinox activator.

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

Starts every staged bundle after resolve (no Spring). Exit 0 requires every PILOT_PORT in the Service Registry (`SERVICE_MISS` otherwise). Equinox-safe empty catalog ports and the command dispatcher graph register via Declarative Services. `--strict` requires every fineract bundle to be ACTIVE. `:equinoxStartSmoke` passes `--start --strict`.

```bash
./gradlew equinoxSpringBridgeSmoke
# or, after staging:
python3 osgi/spring-bridge-smoke.py
```

Starts the same catalog, then registers every composition-root hosted PILOT_PORT (in-memory, not JPA / Spring). Exit 0 requires Felix SCR ACTIVE, every fineract bundle ACTIVE, and the selected services to be the hosted ports. Empty catalog ports stay lowest-ranked. Empty stubs stay in the impl bundle class space; the system classpath does not treat those Classes as assignable. `ContentStreamPort` stays empty-catalog only (JDK pipe). `PaymentDetailWritePlatformService` stays empty-catalog only (leftover JPA `PaymentDetail`). Modules with no Equinox-safe port (bulkimport, instancemode, s3, openapi, interoperation, event) have no Equinox activator.

Optional Boot embed (`fineract.osgi.enabled=true`, default off): `ServerApplication` starts in-process Equinox and registers every Equinox-safe hosted Spring bean via `org.apache.fineract.infrastructure.osgi.SpringOsgiPortBridge` (Waves 1–8 plus remaining `FineractEntityAccessReadService`, `CalendarDropdownReadPlatformService`, `MeetingAttendanceDropdownReadService`, `FieldConfigurationReadPlatformService`, `CreditBureauReadPlatformService`, `CollateralWritePlatformService`, `CollateralManagementReadService`, `NoteReadPlatformService`, `HookReadPlatformService`, `SmsWritePlatformService`, `ReportMailingJobConfigurationReadPlatformService`, `SmsCampaignDropdownReadPlatformService`, `NotificationConfigurationReadService`, `ReportWritePlatformService`, `ExternalServicesReadPlatformService`, `StuckJobExecutorService`, `PropertyService`). Boot callers look services up with `OsgiServiceLookup` (empty when Equinox is off or the type is unpublished). When Equinox is on, `ChargeDefinitionPort` is a `@Primary` lookup façade so Boot injection resolves the Service Registry; the bridge publishes the Spring-owned adapter, not that façade. When Boot has no bean for another Equinox-safe hosted port, `OsgiBackedPortFactory` supplies a lazy no-op proxy that is not published back into Equinox. `CommandDispatcher` stays hosted-only. Set `fineract.osgi.catalog-dir` to a staged `osgi/` directory (`./gradlew osgiStageBundles`) to install empty catalog activators first; Spring ports still win on ranking. Spring is not staged. Missing catalog is a no-op.

## Start

```bash
./osgi/start-equinox.sh
# or
./gradlew equinoxStart
```

Equinox `-configuration` is the **directory** `osgi/config`, not the template ini file. The script seeds that directory from `osgi/equinox/config.ini` when nothing has been staged yet.

Defaults in `config.ini` enable read/write/batch-manager modes for local experiments.
Do not expose the Equinox console publicly in production.
