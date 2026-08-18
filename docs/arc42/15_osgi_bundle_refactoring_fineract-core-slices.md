# fineract-core – optional OSGi *slices* (not full api/impl)

([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** — slices + leftover close-ins 1–30; remaining `~802` types are the **shared kernel** (rank 31) |
| **Rule** | Treat `fineract-core` as the shared kernel. **Do not** api/impl it. **Do not** peel remaining leftovers. New domain goes in `*-api` / `*-impl`. |

## Standing rule: fineract-core is the shared kernel

This is **policy**, not a leftover backlog. After leftover close-ins 1–30, remaining `fineract-core` (`~802` main / `~77` tests) **is** the shared kernel ([ADR-021](decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md), [14.7](14_module_api_boundaries.md)). Rank 31 is the floor.

| Do | Do not |
|----|--------|
| Depend on core from domain modules (**one-way**) | Depend from core on a domain `*-api` if that cycles (`core → module-api → core`) |
| Put **new** ports, DTOs, REST, and handlers in the owning `*-api` / `*-impl` | Move leftover hub / fund-style types out of core to “thin” it |
| Keep residual entities next to residual core DTOs that import them | Invent extra `*-api` consumers (e.g. organisation / calendar / search → loan-api) just to relocate `LoanStatus` |
| Grow core only with true platform types (tenant, Money, exceptions, serialization, command / batch metamodel) | Add new business aggregates or write paths to core |

Inventory and ranks 1–30 below are **historical**. They are not a mandate to peel further.

## Why not full core split

`fineract-core` is the **shared kernel**: tenant context, Money-related types, platform exceptions, serialization helpers, plus accepted hub / fund-style residual that other modules already compile against. A wholesale api/impl split forces every domain module through a huge residual graph and risks Gradle cycles.

## Slice 1 — businessdate ✅

| Project | Role |
|---------|------|
| `:fineract-businessdate-api` | Application ports, DTOs, exceptions |
| `:fineract-businessdate-impl` | Entity, repository, REST, handlers, `BusinessDateOsgiServiceRegistrar` / `BusinessDateOsgiBundleActivator` |
| `:fineract-businessdate-test` | Fragment-Host |

**Kernel residual:** `BusinessDateType` stays in `fineract-core` (same package) for `ThreadLocalContextUtil` / action context without core→businessdate-api→core cycles.

**Consumers:** provider/war compose api+impl; security/cob/WC add businessdate-api where they inject read ports.

## Slice 2 — codes ✅

| Project | Role |
|---------|------|
| `:fineract-codes-api` | `CodeValueData`, `CodeData`, read ports, swagger models (no core dep) |
| `:fineract-codes-impl` | REST/handlers/services (from provider) + `CodesOsgiServiceRegistrar` / `CodesOsgiBundleActivator` |
| Residual in core | `Code`/`CodeValue` entities, repos, exceptions, `CodeValueMapper` |

Core has `api project(':fineract-codes-api')` for transitive DTO access.

## Slice 3 — organisation (office / staff / holiday / working days / provisioning) ✅

| Project | Role |
|---------|------|
| `:fineract-organisation-api` | Ports + pure DTOs/exceptions: office, staff, holiday, working days, category/criteria write, category data |
| `:fineract-organisation-impl` | REST/handlers/services/repos; provisioning entities + criteria read DTO residual; `OrganisationOsgiServiceRegistrar` / `OrganisationOsgiBundleActivator` |
| Residual in core | `Office`/`Staff` entities + DTOs; `Holiday`/`WorkingDays` entities, utils, schedule DTOs/enums |
| Residual in impl | `ProvisioningCriteriaData` / criteria read (needs `LoanProductData`); `LoanProductProvisionCriteria`; loan-impl + accounting-api deps |

**Consumers:** provider/war compose api+impl; accounting/branch inject organisation-api; loan/savings/accounting entries use provisioning ports/entities via composition root.

## Slice 4 — monetary (currency admin) ✅

| Project | Role |
|---------|------|
| `:fineract-monetary-api` | Currency read/write ports, admin DTOs, `CurrencyUpdateCommand` |
| `:fineract-monetary-impl` | `CurrenciesApiResource`, handlers, read impls, `MonetaryOsgiServiceRegistrar` / `MonetaryOsgiBundleActivator` |
| Residual in core | `Money` / `CurrencyData` / currency entities, `CurrencyMapper` |
| Impl coupling | Currency write checks loan/savings/charge product catalogs (loan-impl + savings-api + charge-api) |

## Slice 5 — security residual ✅

Wave-4 `fineract-security` already held auth/2FA/OIDC. Core residual peel:

| Location | Types |
|----------|-------|
| security-api | `PlatformUserDetailsService`, `SqlInjectionPreventerService` (+ existing ports) |
| security-impl | `ColumnValidator`, `DefaultSqlValidator`, `DefaultInputValidator`; residual **closed**: 2FA config, OIDC user resolution, login lockout, temporary-password provider, dynamic JWT issuer resolver, filter-chain diagnostics |
| core residual | `PlatformSecurityContext`, password ports, `PlatformUser*`, `RoleRepository`, `SQLBuilder`, kernel exceptions |
| still on provider | `AuthorizationServerConfig` / `OidcFederationSecurityConfig` (jobs COB filters); `TwoFactorServiceImpl` (SMS/campaigns cycle) |

**Consumers:** provider/war/oauth2-tests; savings-impl depends on security-impl for `ColumnValidator`.

## Candidate later slices

| Slice | Rationale |
|-------|-----------|
| pure criteria ports without loan entities | Needs `LoanProductData` on loan-api first |
| full Money VO extraction | Deferred (kernel residual) |

## Core residual inventory (post-provider floor)

Inventory after the provider composition-root floor closed (`~1180` main Java types in `fineract-core`; `~90` tests). Ranked leftover close-ins 1–30 brought core to **`~802` main / `~77` tests**. Remaining mass is the **shared kernel** (platform + hub / fund-style residual). **Standing rule:** leave it in core.

### Snapshot by area

| Area | ~main types | Classification |
|------|-------------|----------------|
| `infrastructure.core` | ~284 | **Shared kernel** — tenant, config, DB, Jersey, exceptions, serialization |
| `portfolio.client` | ~44 | **Peeled** → `fineract-clients` api/impl/test; Client entity/DTO residual core; main Clients REST/write residual progressive; charges residual charge-impl; address residual address-impl |
| `infrastructure.event` | ~61 | **Mixed residual** — notifier/outbox write path kernel; jobs/config/API peeled to event-impl |
| `org.apache.fineract.shares.*` | ~19 | **Peeled** → `fineract-shares` api/impl/test (packages under `shares.shareaccounts` / `shares.shareproducts` / `shares.accounts`); product JPA + status/charge DTO residual in core; write/read residual charge/savings/progressive |
| `portfolio.group` | ~36 | **Peeled** → `fineract-group` api/impl/test; entity/DTO/exception residual in core; Centers/Groups REST + grouping write residual progressive |
| `portfolio.account` | ~4 | **Peeled** → `fineract-accounttransfer` api/impl/test; kernel residual `PortfolioAccountType`/`PortfolioAccountData`/`AccountTransferData`/`AccountTransfersReadPlatformService` (savings txn coupling); write entities in progressive-loan-impl |
| `organisation.*` | ~51 | **Kernel residual** — entities/DTOs kept after organisation-api/impl slice (by design) |
| `portfolio.savings` (kernel math/DTOs) | ~42 | **Shared kernel-ish** — compounding/posting math + shared savings DTOs used by savings-impl |
| `portfolio.collectionsheet` | 0 | **Peeled** → `fineract-collectionsheet` api/impl/test; write impl residual in progressive-loan-impl |
| `infrastructure.dataqueries` residual | ~27 | **Kernel residual** — shared datatable/report DTOs after dataqueries peel |
| `portfolio.paymenttype` | ~24 | **Strong peel candidate** — coherent entity+REST+handlers package |
| `commands` | ~23 | **Shared kernel** — command pipeline (alongside `fineract-command*`) |
| `portfolio.calendar` residual | ~23 | **Kernel residual** — entities/repos after calendar peel |
| `accounting` residual | ~21 | **Kernel residual** — thin shared accounting DTOs/enums after accounting peel |
| `batch` | ~19 | **Shared kernel** — batch API framework |
| `portfolio.search` | ~18 | **Peel candidate** — REST/JDBC already thinned via `LoanProductLookupReadPort` |
| `useradministration` residual | ~14 | **Kernel residual** — AppUser/Role residual after useradmin peel |
| `portfolio.transfer` | 0 | **Peeled** → `fineract-transfer` api/impl/test; write impl residual progressive-loan |
| `portfolio.repaymentwithpostdatedchecks` | 0 | **Peeled** → `fineract-postdatedchecks` api/impl/test; entity/assembler/write residual in loan-impl |

### Ranked leftover peels (closed)

| Rank | Candidate | ~types | Target | Why / risk |
|------|-----------|--------|--------|------------|
| **1** | **Payment type** | ~24 | `fineract-paymenttype` api/impl/test | **Done** — ports/DTOs + REST/handlers in paymenttype-*; Equinox `PaymentTypeOsgiBundleActivator` (`PaymentTypeReadService`); `PaymentType` entity/repo/not-found residual in core |
| **2** | **Search** | ~18 | `fineract-search` api/impl/test | **Done** — `SearchReadService` + REST in search-*; Equinox `SearchOsgiBundleActivator` (`SearchReadService`); `SearchUtil` + advanced-query DTOs residual in core (dataqueries/savings) |
| **3** | **Collection sheet** | ~29 | `fineract-collectionsheet` api/impl/test | **Done** — ports/commands/DTOs + REST/handlers/read impl in collectionsheet-*; Equinox `CollectionSheetOsgiBundleActivator` (`CollectionSheetWritePlatformService`); write impl residual in progressive-loan-impl |
| **4** | **External event subsystem** | subset of ~87 | extend `fineract-event` | **Done (phase 1)** — jobs/config REST/validation moved to event-impl; outbox entity/`ExternalEventService`/serializer SPI remain core (notifier-bound) |
| **5** | **Account transfer / SI pure+REST** | ~60 | `fineract-accounttransfer` api/impl/test | **Done** — pure+REST+reads/jobs in accounttransfer-*; Equinox `AccountTransferOsgiBundleActivator` (`StandingInstructionWritePlatformService`); write entities residual progressive-loan; kernel residual for savings txn DTO coupling |
| **6** | **Shares pure residual** | ~81 | `fineract-shares` api/impl/test | **Done** — pure+REST+handlers/reads/job in shares-*; Equinox `SharesOsgiBundleActivator` (`ShareProductDropdownReadPlatformService`); product JPA residual core; account write residual progressive; product write residual charge |
| **7** | **Group pure residual** | ~74 | `fineract-group` api/impl/test | **Done** — ports/handlers/reads/levels API in group-*; Equinox `GroupOsgiBundleActivator` (`GroupLevelReadPlatformService`); entity+DTO residual core; Centers/Groups REST + write residual progressive |
| **8** | **Client pure residual** | ~112 | `fineract-clients` api/impl/test | **Done** — pure REST/handlers/services in clients-*; Equinox `ClientsOsgiBundleActivator` (`ClientIdentifierWritePlatformService`); Client hub residual core; main write/REST residual progressive |
| **9** | **Post-dated checks** | ~11 | `fineract-postdatedchecks` api/impl/test | **Done** — ports/DTOs/REST/handlers; Equinox `PostDatedChecksOsgiBundleActivator` (`RepaymentWithPostDatedChecksWritePlatformService`); entity residual loan-impl |
| **10** | **Client office/group transfer** | ~13 | `fineract-transfer` api/impl/test | **Done** — ports/handlers/validator; write residual progressive-loan |
| **11** | **Generic products REST** | ~7 | `fineract-products` api/impl/test | **Done** — `/v1/products/{type}` + `ShareProductReadPlatformService`; Equinox `ProductsOsgiBundleActivator` (`ProductCommandsService`); `ProductNotFoundException` residual core |
| **12** | **Payment detail write** | ~8 | `fineract-paymentdetail` api/impl/test | **Done** — write port/impl/assembler; Equinox `PaymentDetailOsgiBundleActivator` (`PaymentDetailWritePlatformService`); entity + PaymentDetailData residual core |
| **13** | **Loan Rate catalog close-in** | ~3 | `fineract-rates` api | **Done** — `RateData` + `RateReadService`/`RateWriteService` on rates-api; entity/repo residual core |
| **14** | **Tax request DTOs** | ~3 | `fineract-tax` api | **Done** — `TaxComponentRequest`/`TaxGroupRequest`/`TaxGroupComponent` on tax-api; fat `TaxGroupData` residual core (SavingsAccountData cycle) |
| **15** | **Delinquency catalog entities** | ~6 | `fineract-loan-impl` | **Done** — `DelinquencyBucket`/`Range`/`MinimumPaymentPeriodAndRule` + enums next to repos; WC already depends on loan-impl |
| **16** | **Meeting attendance leftover** | ~3 | `fineract-meeting` api | **Done** — `MeetingAttendanceType`/`Enumerations` + dropdown port on meeting-api; Equinox `MeetingOsgiBundleActivator` (`MeetingAttendanceDropdownReadService`) |
| **17** | **Notification leftover** | ~2 | `fineract-notification` api | **Done** — `UserNotificationService` + `NotificationData` on notification-api; security-impl is api-only |
| **18** | **Interop identifier type** | 1 | `fineract-interoperation` api | **Done** — `InteropIdentifierType` on interop-api next to the other interop enums; entity residual savings-impl |
| **19** | **Cache admin REST** | ~7 | `fineract-cache` api/impl/test | **Done** — write port/DTOs + REST/handler/impl; Equinox `CacheOsgiBundleActivator` (`CacheWritePlatformService`); `CacheType`/`PlatformCache`/runtime manager residual core |
| **20** | **Loan product lookup port** | ~2 | `fineract-loan` api | **Done** — `LoanProductLookupData` + `LoanProductLookupReadPort` on loan-api (already exported) |
| **21** | **Entity image adapter** | 1 | `fineract-document` api | **Done** — `EntityImageIdAdapter` on document-api; clients-impl + organisation-impl implement it |
| **22** | **Spring Batch PropertyService** | ~2 | `fineract-springbatch` api | **Done** — `PropertyService` + `SpringBatchJobConstants` on springbatch-api; cob/loan/WC/jobs are api-only |
| **23** | **Bulk import ports** | ~5 | `fineract-bulkimport` api | **Done** — workbook ports + `GlobalEntityType`/`ImportData`/`LookupMode` on bulkimport-api |
| **24** | **Loan leftover ports** | ~2 | `fineract-loan` api | **Done** — `LoanReadPlatformServiceCommon` + `ExpectedDisbursementDateValidator` on loan-api; `LoanStatus` residual core |
| **25** | **Instance-mode API filter** | 1 | `fineract-instancemode` api | **Done** — `FineractInstanceModeApiFilter` on instancemode-api (security-impl api-only); `FineractInstanceModeConstants` residual core (event conditions) |
| **26** | **Leftover module tests** | 2 | `fineract-clients-test` / `fineract-bulkimport-test` | **Done** — `ClientDataValidatorTest` + `LookupModeTest` next to the already-moved production types |
| **27** | **Calendar leftover** | ~2 | `fineract-calendar` api | **Done** — `CalendarRequest` + `CalendarInstanceLookupPort` on calendar-api; Equinox `CalendarOsgiBundleActivator` (`CalendarDropdownReadPlatformService`); loan-impl api-only; entity/`CalendarData` residual core |
| **28** | **Charge convert leftover** | 1 | `fineract-charge` api | **Done** — `ConvertChargeDataToSpecificChargeData` on charge-api (savings-impl + progressive-loan already api-only); fat charge/savings/share DTOs residual core |
| **29** | **Unused image leftovers** | 4 | `fineract-document` api | **Done** — `ImageNotFoundException`/`ImageUploadException`/`ImageDataURLNotValidException`/`Base64EncodedImage` on document-api; no remaining consumers |
| **30** | **Unused JobParametersDTO** | 1 | `fineract-jobs` api | **Done** — unused wrapper on jobs-api; `JobParameterDTO` residual core (`CustomJobParameterRepository`) |
| **31** | **Kernel floor** | ~802 | stay in core | **Standing rule** — remaining mass **is** the shared kernel; do not invent further leftover peels |

### Explicitly **do not** peel as “core residual”

| Stay in core | Reason |
|--------------|--------|
| `infrastructure.core/**` | Shared kernel |
| `commands/**`, `batch/**` | Platform command/batch framework |
| Money / currency entities (monetary residual) | Kernel VO/entity residual by design |
| Organisation entity residual | Unlocks loan/savings holiday/office without cycles |
| Calendar/meeting entity residual | Shared by loan/group/COB |
| Savings compounding math + shared savings DTOs | Used as kernel by savings-impl |
| Global configuration / security context ports residual | Cross-cutting |
| `FineractInstanceModeConstants` | Used by core event conditions; moving would cycle core↔instancemode-api |
| `LoanStatus` | Hub residual — cob, accounttransfer, organisation, search, calendar, savings plus loan/progressive/WC/investor |
| `AccountType` / `AccountEnumerations` | Hub residual — savings-impl, loan-impl, progressive-loan, interop-api |
| `JobExecutionException` | Used by businessdate-api; moving would pull jobs-api (and loan-api) into businessdate-api |
| `JobName` / `StepName` / `SchedulerJobRunnerReadService` + job DTOs / `CustomJobParameter*` | Command/batch pipeline in core |
| `ProductNotFoundException` | Used by residual `ShareProductRepositoryWrapper` in core |
| `AddressData` | Used by residual `ClientData` in core |
| `TaxGroupData` / fat tax DTOs | Used by residual `SavingsAccountData` / `ChargeData` |
| `ChargeData` / `ChargeTimeType` | Kernel DTO/enum residual; `ChargeParameterUpdateNotSupportedException` used by residual `Rate` |
| `SearchUtil` + advanced-query DTOs | Used by dataqueries + savings |
| Fund-style entities | `PaymentType`, `PaymentDetail`, `Fund`, `Rate`, `Client`, `Group` (+ wrappers/exceptions) |

### Closed leftover order

1. **Payment-type pilot** ✅ (`fineract-paymenttype` api/impl/test; Equinox `PaymentTypeOsgiBundleActivator` (`PaymentTypeReadService`); entity residual in core).  
2. **Search** ✅ (`fineract-search` api/impl/test; Equinox `SearchOsgiBundleActivator` (`SearchReadService`); `SearchUtil` + advanced-query DTOs residual in core).  
3. **Collection sheet** ✅ (`fineract-collectionsheet` api/impl/test; Equinox `CollectionSheetOsgiBundleActivator` (`CollectionSheetWritePlatformService`); write impl residual in progressive-loan-impl).  
4. **External event subsystem** ✅ (phase 1: jobs/config/API → event-impl; outbox residual in core).  
5. **Account transfer / SI** ✅ (`fineract-accounttransfer` api/impl/test; Equinox `AccountTransferOsgiBundleActivator` (`StandingInstructionWritePlatformService`); write residual progressive-loan).  
6. **Shares pure residual** ✅ (`fineract-shares` api/impl/test; Equinox `SharesOsgiBundleActivator` (`ShareProductDropdownReadPlatformService`); product JPA residual core).  
7. **Group pure residual** ✅ (`fineract-group` api/impl/test; Equinox `GroupOsgiBundleActivator` (`GroupLevelReadPlatformService`); entity residual core).  
8. **Client pure residual** ✅ (`fineract-clients` api/impl/test; Equinox `ClientsOsgiBundleActivator` (`ClientIdentifierWritePlatformService`); Client hub residual core).  
9. **Post-dated checks** ✅ (`fineract-postdatedchecks` api/impl/test; Equinox `PostDatedChecksOsgiBundleActivator` (`RepaymentWithPostDatedChecksWritePlatformService`); entity residual loan-impl).  
10. **Client office/group transfer** ✅ (`fineract-transfer` api/impl/test; write residual progressive-loan).  
11. **Generic products REST** ✅ (`fineract-products` api/impl/test; Equinox `ProductsOsgiBundleActivator` (`ProductCommandsService`); ProductNotFoundException residual core).  
12. **Payment detail write** ✅ (`fineract-paymentdetail` api/impl/test; Equinox `PaymentDetailOsgiBundleActivator` (`PaymentDetailWritePlatformService`); entity residual core).  
13. **Loan Rate catalog close-in** ✅ (`RateData` + read/write ports → rates-api; `Rate` entity residual core).  
14. **Tax request DTOs** ✅ (`Tax*Request` → tax-api; fat `TaxGroupData` residual core for SavingsAccountData).  
15. **Delinquency catalog entities** ✅ (`DelinquencyBucket`/`Range` + enums → loan-impl; WC already on loan-impl).  
16. **Meeting attendance leftover** ✅ (`MeetingAttendance*` + dropdown port → meeting-api; Equinox `MeetingOsgiBundleActivator` (`MeetingAttendanceDropdownReadService`)).  
17. **Notification leftover** ✅ (`UserNotificationService` + `NotificationData` → notification-api; security-impl api-only).  
18. **Interop identifier type** ✅ (`InteropIdentifierType` → interop-api; entity residual savings-impl).  
19. **Cache admin REST** ✅ (`fineract-cache` api/impl/test; Equinox `CacheOsgiBundleActivator` (`CacheWritePlatformService`); `CacheType`/`PlatformCache`/runtime manager residual core).  
20. **Loan product lookup port** ✅ (`LoanProductLookupData` + read port → loan-api).  
21. **Entity image adapter** ✅ (`EntityImageIdAdapter` → document-api).  
22. **Spring Batch PropertyService** ✅ (`PropertyService` + job constants → springbatch-api).  
23. **Bulk import ports** ✅ (workbook ports + DTOs → bulkimport-api).  
24. **Loan leftover ports** ✅ (`LoanReadPlatformServiceCommon` + `ExpectedDisbursementDateValidator` → loan-api).  
25. **Instance-mode API filter** ✅ (`FineractInstanceModeApiFilter` → instancemode-api; constants residual core).  
26. **Leftover module tests** ✅ (`ClientDataValidatorTest` → clients-test; `LookupModeTest` → bulkimport-test).  
27. **Calendar leftover** ✅ (`CalendarRequest` + `CalendarInstanceLookupPort` → calendar-api; Equinox `CalendarOsgiBundleActivator` (`CalendarDropdownReadPlatformService`)).  
28. **Charge convert leftover** ✅ (`ConvertChargeDataToSpecificChargeData` → charge-api).  
29. **Unused image leftovers** ✅ (`Image*` exceptions + `Base64EncodedImage` → document-api).  
30. **Unused JobParametersDTO** ✅ (`JobParametersDTO` → jobs-api; `JobParameterDTO` residual core).  
31. **Kernel floor** ✅ (`fineract-core` **is** the shared kernel — standing rule; no further leftover peels).

## Related provider peels

| Peel | Status |
|------|--------|
| `fineract-useradministration` | **complete** (api/impl/test); kernel AppUser/Role residual in core; Equinox `UserAdministrationOsgiBundleActivator` (`PasswordValidationPolicyReadPlatformService`) |
| `fineract-adhocquery` | **complete** (api/impl/test); leftover generate-adhoc-client-schedule job closed into impl; Equinox `AdhocQueryOsgiBundleActivator` (`AdHocReadPlatformService`) |
| `fineract-template` | **complete** (api/impl/test); Template entity residual used by hooks via impl; Equinox `TemplateOsgiBundleActivator` (`TemplateMergeService`) |
| `fineract-notification` | **complete** (api/impl/test); Equinox `NotificationOsgiBundleActivator` (`UserNotificationService`); security-impl api-only |
| `fineract-spm` | **complete** (api/impl/test); Equinox `SpmOsgiBundleActivator` (`ScorecardReadPlatformService`); Client/AppUser from core |
| `fineract-fund` | **complete** (api/impl/test); Equinox `FundOsgiBundleActivator` (`FundReadPlatformService`); Fund entity residual in core |
| `fineract-accountnumberformat` | **complete** (api/impl/test); Equinox `AccountNumberFormatOsgiBundleActivator` (`AccountNumberFormatReadPlatformService`); entity/generator residual in core |
| `fineract-survey` | **complete** (api/impl/test); Equinox `SurveyOsgiBundleActivator` (`ReadLikelihoodService`); PPI/infrastructure surveys; datatable ports from core |
| `fineract-transfer` | **complete** (api/impl/test); Equinox `TransferOsgiBundleActivator` (`TransferWritePlatformService`); write impl residual progressive-loan |
| share account residual (pure) | status enums, `SharesEnumerations`, frequency/dividend status types, `ShareAccountWritePlatformService` + command handlers in core; entity write/read/job stay on provider |
| `fineract-clients` | **complete** (api/impl/test); Equinox `ClientsOsgiBundleActivator` (`ClientIdentifierWritePlatformService`); Client hub residual core; main Clients REST/write residual progressive; charges residual charge-impl; address residual address-impl |
| `fineract-group` | **complete** (api/impl/test); Equinox `GroupOsgiBundleActivator` (`GroupLevelReadPlatformService`); entity/DTO/exception residual in core; Centers/Groups REST + grouping write residual progressive |
| `fineract-collectionsheet` | **complete** (api/impl/test); Equinox `CollectionSheetOsgiBundleActivator` (`CollectionSheetWritePlatformService`); write impl residual in progressive-loan-impl; group SAVECOLLECTIONSHEET handlers moved into collectionsheet-impl |
| search residual | **closed** into fineract-search; `LoanProductLookupReadPort` + lookup DTO on loan-api; adapter residual loan-impl |
| `fineract-postdatedchecks` | **complete** (api/impl/test); Equinox `PostDatedChecksOsgiBundleActivator` (`RepaymentWithPostDatedChecksWritePlatformService`); entity/repo/assembler/impl/config residual loan-impl |
| product-mix residual | full productmix package (REST/commands/handlers/domain/services) in loan-impl |
| loan product residual | LoanProductsApiResource, data validator, read/write impls, Spring config, assembler/update util in loan-impl (office restriction + mapping validator ports); Rate entity/repo residual in core; `RateData` + Rate read/write ports on rates-api |
| infrastructure residual (pure) | jersey JSON converters/serializers + Jackson converter config/argument handler, command JSON deserializers, performance sampling, ExternalIdConverter, CustomDateTimeProvider, SchemaUpgradeNeededException in core; app bootstrap configs stay on provider |
| share product residual (pure) | write port, dropdown, exceptions, handlers, dividend JDBC/REST, product command ports/impl stub, products REST/constants/not-found, ShareProduct domain (+ market price/repos) in core; entity write/read/serializer stay on provider |
| infrastructure residual (pure) | jersey JSON converters/serializers + Jackson converter config/argument handler, command JSON deserializers, performance sampling, ExternalIdConverter, CustomDateTimeProvider, SchemaUpgradeNeededException, jdbc/jersey/cache/jpa/liquibase helpers, auditors, password encoder, AccountNumberFormatRepositoryWrapper, CalendarInstance repos in core; app bootstrap (Web/Liquibase-only) stay on provider |
| share account residual (JDBC reads/job) | purchased-shares + account-dividend reads, schedular port, post-dividends job, commands stub, ShareAccountApiConstants, full accounts REST/DTOs/exception in core; charge read stays (charge-api enums); entity write/read/schedular impl stay on provider |
| `fineract-entityaccess` | **complete** (api/impl/test); Equinox `EntityAccessOsgiBundleActivator` (`FineractEntityAccessReadService`); residual consumers in provider |
| `fineract-calendar` | **complete** (api/impl/test); Equinox `CalendarOsgiBundleActivator` (`CalendarDropdownReadPlatformService`); entity residual in core; GroupRepository residual to core |
| `fineract-meeting` | **complete** (api/impl/test); Equinox `MeetingOsgiBundleActivator` (`MeetingAttendanceDropdownReadService`); depends on calendar-api/impl |
| `fineract-address` | **complete** (api/impl/test); Equinox `AddressOsgiBundleActivator` (`FieldConfigurationReadPlatformService`); AddressData residual in core; ClientAddress on impl |
| `fineract-creditbureau` | **complete** (api/impl/test); Equinox `CreditBureauOsgiBundleActivator` (`CreditBureauReadPlatformService`); loan product mapping via loan-impl |
| `fineract-collateral` | **complete** (api/impl/test); Equinox `CollateralOsgiBundleActivator` (`CollateralWritePlatformService`); legacy loan collateral residual **closed** (entity/DTO on collateral; Loan inverse collection removed) |
| `fineract-collateralmanagement` | **complete** (api/impl/test); Equinox `CollateralManagementOsgiBundleActivator` (`CollateralManagementReadService`); entity residual **closed** (entities on impl; Loan inverse collection removed) |
| `fineract-note` | **complete** (api/impl/test); Equinox `NoteOsgiBundleActivator` (`NoteReadPlatformService`); FK-based Note entity; share residual via ShareAccountNoteSupport |
| `fineract-hooks` | **complete** (api/impl/test); Equinox `HooksOsgiBundleActivator` (`HookReadPlatformService`); ports DTO-only + HookEventQueryService on impl; MessageGatewayHookProcessor **closed** (hooks-impl via sms + campaigns); HookEvent residual in core; Template via template-impl |
| `fineract-sms` | **complete** (api/impl/test); Equinox `SmsOsgiBundleActivator` (`SmsWritePlatformService`); campaignId Long FK; scheduled job residual **closed** into campaigns-impl (`SmsMessageScheduledJobService`) |
| `fineract-reportmailingjob` | **complete** (api/impl/test); Equinox `ReportMailingJobOsgiBundleActivator` (`ReportMailingJobConfigurationReadPlatformService`); stretchyReportId Long FK (dataqueries Report residual); AppUser @ManyToOne (core); ExecuteReportMailingJobs in campaigns-impl |
| `fineract-campaigns` | **complete** (api/impl/test); Equinox `CampaignsOsgiBundleActivator` (`SmsCampaignDropdownReadPlatformService`); Report FKs Long; residual write/domain/jobs **closed** (campaigns-impl; dataqueries/gcm/configuration/loan/savings/event) |
| `fineract-gcm` | **complete** (api/impl/test); Equinox `GcmOsgiBundleActivator` (`NotificationConfigurationReadService`); NotificationConfigurationReadService port implemented by configuration residual; NotificationSenderService on impl |
| `fineract-dataqueries` | **complete** (api/impl/test); Equinox `DataqueriesOsgiBundleActivator` (`ReportWritePlatformService`); Report/datatable entities + platform impls; shared DTOs/ports remain in core |
| `fineract-configuration` | **complete** (api/impl/test); Equinox `ConfigurationOsgiBundleActivator` (`ExternalServicesReadPlatformService`); external services + write/read impls; global config entity/ports remain in core; async residual **closed** (SpringAsyncConfig on impl; TaskExecutor* in core) |
| `fineract-bulkimport` | **complete** (api/impl/test); Equinox `BulkImportOsgiBundleActivator` (no port: jersey / jakarta.ws.rs / POI); workbook ports + `GlobalEntityType`/`ImportData`/`LookupMode` on bulkimport-api; `LookupModeTest` on bulkimport-test; populator impl residual provider (share) |
| `fineract-instancemode` | **complete** (api/impl/test); Equinox `InstanceModeOsgiBundleActivator` (no port: swagger DTO + servlet filter only); test-profile REST + swagger DTO + `FineractInstanceModeApiFilter` on api; constants residual in core |
| `fineract-jobs` | **complete** (api/impl/test); Equinox `JobsOsgiBundleActivator` (`StuckJobExecutorService`); residual **closed** (filters + inline + retained-earning + NPA); unused `JobParametersDTO` on jobs-api; `LoanCOBEnabledCondition` on cob-impl; `BodyCachingHttpServletRequestWrapper` in core |
| `fineract-s3` | **complete** (api/impl/test); Equinox `S3OsgiBundleActivator` (no port: AWS SDK `S3ClientBuilder`); S3 client SPI + Amazon/Localstack config; report export bean via dataqueries-impl |
| `fineract-openapi` | **complete** (api/impl/test); Equinox `OpenApiOsgiBundleActivator` (no port: swagger reader/filter utilities only); OperationId reader + spec filter for swagger-gradle-plugin; tests on fragment |
| `fineract-springbatch` | **complete** (api/impl/test); Equinox `SpringBatchOsgiBundleActivator` (`PropertyService`); remote job messaging; `PropertyService` + `SpringBatchJobConstants` on springbatch-api |
| `fineract-event` | **complete** (api/impl/test) + external jobs/config API peel; no Equinox port (leftover `ExternalEventProducer` in core only); domain events + producers/serializers + config REST/jobs; core residual: notifier + outbox entity/service + serializer SPI |
| `fineract-interoperation` | **complete** (api/impl/test); Equinox `InteroperationOsgiBundleActivator` (no port: `InteropService` jakarta.validation + leftover unpublished savings types); `InteropIdentifier` entity residual savings-impl |
| `fineract-accounttransfer` | **complete** (api/impl/test); Equinox `AccountTransferOsgiBundleActivator` (`StandingInstructionWritePlatformService`); write entities residual progressive-loan; kernel residual AccountTransferData/read port + PortfolioAccount* for savings |
| `fineract-shares` | **complete** (api/impl/test); Equinox `SharesOsgiBundleActivator` (`ShareProductDropdownReadPlatformService`); ShareProduct JPA residual core; product write residual charge-impl; account entity residual savings-impl; account write residual progressive |
| `fineract-group` | **complete** (api/impl/test); Equinox `GroupOsgiBundleActivator` (`GroupLevelReadPlatformService`); Group entity+DTO residual core; Centers/Groups REST + grouping-types write residual progressive |
| `fineract-clients` | **complete** (api/impl/test); Equinox `ClientsOsgiBundleActivator` (`ClientIdentifierWritePlatformService`); Client entity+ClientData residual core; `ClientDataValidatorTest` on clients-test; main Clients REST/write residual progressive |
| `fineract-postdatedchecks` | **complete** (api/impl/test); Equinox `PostDatedChecksOsgiBundleActivator` (`RepaymentWithPostDatedChecksWritePlatformService`); entity/assembler/write residual loan-impl |
| `fineract-transfer` | **complete** (api/impl/test); ports/handlers/validator; write residual progressive-loan |
| `fineract-products` | **complete** (api/impl/test); Equinox `ProductsOsgiBundleActivator` (`ProductCommandsService`); ProductNotFoundException residual core; read impl residual charge-impl |
| `fineract-paymentdetail` | **complete** (api/impl/test); Equinox `PaymentDetailOsgiBundleActivator` (`PaymentDetailWritePlatformService`); PaymentDetail entity/repo + PaymentDetailData residual core |
| `fineract-rates` Rate catalog close-in | **complete**; `RateData` + `RateReadService`/`RateWriteService` on rates-api; Rate entity/`RateAppliesTo`/repo/wrapper/`RateNotFoundException` residual core |
| `fineract-tax` request close-in | **complete**; `TaxComponentRequest`/`TaxGroupRequest`/`TaxGroupComponent` on tax-api; fat tax DTOs residual core (`TaxGroupData` on SavingsAccountData / ChargeData) |
| delinquency catalog close-in | **complete**; `DelinquencyBucket`/`Range`/`MinimumPaymentPeriodAndRule` + type enums on loan-impl next to repos |
| `fineract-meeting` attendance close-in | **complete**; Equinox `MeetingOsgiBundleActivator` (`MeetingAttendanceDropdownReadService`) |
| `fineract-interoperation` identifier-type close-in | **complete**; `InteropIdentifierType` on interop-api; `InteropIdentifier` entity residual savings-impl |
| `fineract-cache` | **complete** (api/impl/test); Equinox `CacheOsgiBundleActivator` (`CacheWritePlatformService`); CacheType/PlatformCache/runtime manager residual core |
| loan product lookup close-in | **complete**; `LoanProductLookupData` + `LoanProductLookupReadPort` on loan-api; adapter residual loan-impl |
| `fineract-document` image-adapter close-in | **complete**; `EntityImageIdAdapter` on document-api; clients-impl + organisation-impl implement it |
| `fineract-springbatch` PropertyService close-in | **complete**; `PropertyService` + `SpringBatchJobConstants` on springbatch-api |
| `fineract-bulkimport` port close-in | **complete**; workbook ports + `GlobalEntityType`/`ImportData`/`LookupMode` on bulkimport-api |
| loan leftover ports close-in | **complete**; `LoanReadPlatformServiceCommon` + `ExpectedDisbursementDateValidator` on loan-api; `LoanStatus` residual core |
| `fineract-instancemode` filter close-in | **complete**; `FineractInstanceModeApiFilter` on instancemode-api; `FineractInstanceModeConstants` residual core |
| leftover module tests close-in | **complete**; `ClientDataValidatorTest` → clients-test; `LookupModeTest` → bulkimport-test |
| `fineract-calendar` leftover close-in | **complete**; Equinox `CalendarOsgiBundleActivator` (`CalendarDropdownReadPlatformService`); entity/`CalendarData` residual core |
| `fineract-charge` convert leftover close-in | **complete**; `ConvertChargeDataToSpecificChargeData` on charge-api; `ChargeData` / savings+share charge DTOs residual core |
| `fineract-document` unused image close-in | **complete**; `ImageNotFoundException`/`ImageUploadException`/`ImageDataURLNotValidException`/`Base64EncodedImage` on document-api |
| `fineract-jobs` unused JobParametersDTO close-in | **complete**; `JobParametersDTO` on jobs-api; `JobParameterDTO` residual core |
| kernel floor | **standing rule**; remaining `~802` core types **are** the shared kernel — do not invent leftover peels |


## Commands

```bash
./gradlew :fineract-businessdate-api:jar :fineract-businessdate-impl:jar :fineract-businessdate-test:test
./gradlew :fineract-codes-api:jar :fineract-codes-impl:jar :fineract-codes-test:test
./gradlew :fineract-organisation-api:jar :fineract-organisation-impl:jar :fineract-organisation-test:test
./gradlew :fineract-monetary-api:jar :fineract-monetary-impl:jar :fineract-monetary-test:test
./gradlew :fineract-security-api:jar :fineract-security-impl:jar :fineract-security-test:test
./gradlew :fineract-core:compileJava :fineract-provider:compileJava
```


- Leftover pure Spring configs closed into core: `FineractCorsConfiguration`, `FineractStartupValidationConfig`, `SpringConfig`.
- Leftover pure MetricsConfig + OkHttp3Config closed into core.
- Leftover Holiday/WorkingDays repositories, wrappers, and not-found exceptions closed into core.
- Leftover HikariCpConfig, CompatibilityConfig, JPAConfig, and JerseyConfig closed into core.
- Leftover JdbcTransactionConfig and AbandonedConnectionCleanupShutdownListener closed into core.
- Leftover TransactionBoundCacheManager closed into core.
- Leftover CacheConfig, SpecifiedCacheSupportingCacheManager, JdbcConfig, and tenant Liquibase migration closed into core.
- Leftover ShareProductDividentsCreateBusinessEvent closed into core.
