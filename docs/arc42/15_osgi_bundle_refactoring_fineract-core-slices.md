# fineract-core – optional OSGi *slices* (not full api/impl)

([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **complete** for planned slices — **businessdate**, **codes**, **organisation** (office/staff/holiday/workingdays/provisioning), **monetary**, **security residual** |
| **Rule** | Extract coherent platform slices; **do not** api/impl the whole ~800-type kernel |

## Why not full core split

`fineract-core` is the **shared kernel** ([ADR-021](decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md)): tenant context, Money-related types, platform exceptions, serialization helpers. A wholesale api/impl split forces every domain module through a huge residual graph and risks Gradle cycles.

## Slice 1 — businessdate ✅

| Project | Role |
|---------|------|
| `:fineract-businessdate-api` | Application ports, DTOs, exceptions |
| `:fineract-businessdate-impl` | Entity, repository, REST, handlers, `BusinessDateOsgiServiceRegistrar` |
| `:fineract-businessdate-test` | Fragment-Host |

**Kernel residual:** `BusinessDateType` stays in `fineract-core` (same package) for `ThreadLocalContextUtil` / action context without core→businessdate-api→core cycles.

**Consumers:** provider/war compose api+impl; security/cob/WC add businessdate-api where they inject read ports.

## Slice 2 — codes ✅

| Project | Role |
|---------|------|
| `:fineract-codes-api` | `CodeValueData`, `CodeData`, read ports, swagger models (no core dep) |
| `:fineract-codes-impl` | REST/handlers/services (from provider) + `CodesOsgiServiceRegistrar` |
| Residual in core | `Code`/`CodeValue` entities, repos, exceptions, `CodeValueMapper` |

Core has `api project(':fineract-codes-api')` for transitive DTO access.

## Slice 3 — organisation (office / staff / holiday / working days / provisioning) ✅

| Project | Role |
|---------|------|
| `:fineract-organisation-api` | Ports + pure DTOs/exceptions: office, staff, holiday, working days, category/criteria write, category data |
| `:fineract-organisation-impl` | REST/handlers/services/repos; provisioning entities + criteria read DTO residual; `OrganisationOsgiServiceRegistrar` |
| Residual in core | `Office`/`Staff` entities + DTOs; `Holiday`/`WorkingDays` entities, utils, schedule DTOs/enums |
| Residual in impl | `ProvisioningCriteriaData` / criteria read (needs `LoanProductData`); `LoanProductProvisionCriteria`; loan-impl + accounting-api deps |

**Consumers:** provider/war compose api+impl; accounting/branch inject organisation-api; loan/savings/accounting entries use provisioning ports/entities via composition root.

## Slice 4 — monetary (currency admin) ✅

| Project | Role |
|---------|------|
| `:fineract-monetary-api` | Currency read/write ports, admin DTOs, `CurrencyUpdateCommand` |
| `:fineract-monetary-impl` | `CurrenciesApiResource`, handlers, read impls, `MonetaryOsgiServiceRegistrar` |
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

Inventory after the provider composition-root floor closed (`~1180` main Java types in `fineract-core`; `~90` tests). This is **not** a mandate to peel everything; it ranks residual **domain** mass still living in the shared kernel.

### Snapshot by area

| Area | ~main types | Classification |
|------|-------------|----------------|
| `infrastructure.core` | ~284 | **Shared kernel** — tenant, config, DB, Jersey, exceptions, serialization |
| `portfolio.client` | ~44 | **Peeled** → `fineract-clients` api/impl/test; Client entity/DTO residual core; main Clients REST/write residual progressive; charges residual charge-impl; address residual address-impl |
| `infrastructure.event` | ~61 | **Mixed residual** — notifier/outbox write path kernel; jobs/config/API peeled to event-impl |
| `portfolio.shares*` + accounts/products | ~19 | **Peeled** → `fineract-shares` api/impl/test; product JPA + status/charge DTO residual in core; write/read residual charge/savings/progressive |
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

### Ranked next peels (if pursuing more core work)

| Rank | Candidate | ~types | Target | Why / risk |
|------|-----------|--------|--------|------------|
| **1** | **Payment type** | ~24 | `fineract-paymenttype` api/impl/test | **Done** — ports/DTOs + REST/handlers in paymenttype-*; `PaymentType` entity/repo/not-found residual in core |
| **2** | **Search** | ~18 | `fineract-search` api/impl/test | **Done** — `SearchReadService` + REST in search-*; `SearchUtil` + advanced-query DTOs residual in core (dataqueries/savings) |
| **3** | **Collection sheet** | ~29 | `fineract-collectionsheet` api/impl/test | **Done** — ports/commands/DTOs + REST/handlers/read impl in collectionsheet-*; write impl residual in progressive-loan-impl |
| **4** | **External event subsystem** | subset of ~87 | extend `fineract-event` | **Done (phase 1)** — jobs/config REST/validation moved to event-impl; outbox entity/`ExternalEventService`/serializer SPI remain core (notifier-bound) |
| **5** | **Account transfer / SI pure+REST** | ~60 | `fineract-accounttransfer` api/impl/test | **Done** — pure+REST+reads/jobs in accounttransfer-*; write entities residual progressive-loan; kernel residual for savings txn DTO coupling |
| **6** | **Shares pure residual** | ~81 | `fineract-shares` api/impl/test | **Done** — pure+REST+handlers/reads/job in shares-*; product JPA residual core; account write residual progressive; product write residual charge |
| **7** | **Group pure residual** | ~74 | `fineract-group` api/impl/test | **Done** — ports/handlers/reads/levels API in group-*; entity+DTO residual core; Centers/Groups REST + write residual progressive |
| **8** | **Client pure residual** | ~112 | `fineract-clients` api/impl/test | **Done** — pure REST/handlers/services in clients-*; Client hub residual core; main write/REST residual progressive |
| **9** | **Post-dated checks** | ~11 | `fineract-postdatedchecks` api/impl/test | **Done** — ports/DTOs/REST/handlers; entity residual loan-impl |
| **10** | **Client office/group transfer** | ~13 | `fineract-transfer` api/impl/test | **Done** — ports/handlers/validator; write residual progressive-loan |
| **11** | **Generic products REST** | ~7 | `fineract-products` api/impl/test | **Done** — `/v1/products/{type}` + `ShareProductReadPlatformService`; `ProductNotFoundException` residual core |
| **12** | **Payment detail write** | ~8 | `fineract-paymentdetail` api/impl/test | **Done** — write port/impl/assembler; entity + PaymentDetailData residual core |
| **13** | **Loan Rate catalog close-in** | ~3 | `fineract-rates` api | **Done** — `RateData` + `RateReadService`/`RateWriteService` on rates-api; entity/repo residual core |
| **14** | **Tax request DTOs** | ~3 | `fineract-tax` api | **Done** — `TaxComponentRequest`/`TaxGroupRequest`/`TaxGroupComponent` on tax-api; fat `TaxGroupData` residual core (SavingsAccountData cycle) |
| **15** | **Delinquency catalog entities** | ~6 | `fineract-loan-impl` | **Done** — `DelinquencyBucket`/`Range`/`MinimumPaymentPeriodAndRule` + enums next to repos; WC already depends on loan-impl |
| **16** | **Meeting attendance leftover** | ~3 | `fineract-meeting` api | **Done** — `MeetingAttendanceType`/`Enumerations` + dropdown port on meeting-api |
| **17** | **Notification leftover** | ~2 | `fineract-notification` api | **Done** — `UserNotificationService` + `NotificationData` on notification-api; security-impl is api-only |
| **18** | **Interop identifier type** | 1 | `fineract-interoperation` api | **Done** — `InteropIdentifierType` on interop-api next to the other interop enums; entity residual savings-impl |
| **19** | **Cache admin REST** | ~7 | `fineract-cache` api/impl/test | **Done** — write port/DTOs + REST/handler/impl; `CacheType`/`PlatformCache`/runtime manager residual core |
| **20** | **Loan product lookup port** | ~2 | `fineract-loan` api | **Done** — `LoanProductLookupData` + `LoanProductLookupReadPort` on loan-api (already exported) |
| **21** | **Entity image adapter** | 1 | `fineract-document` api | **Done** — `EntityImageIdAdapter` on document-api; clients-impl + organisation-impl implement it |
| **22** | **Spring Batch PropertyService** | ~2 | `fineract-springbatch` api | **Done** — `PropertyService` + `SpringBatchJobConstants` on springbatch-api; cob/loan/WC/jobs are api-only |
| **23** | **Bulk import ports** | ~5 | `fineract-bulkimport` api | **Done** — workbook ports + `GlobalEntityType`/`ImportData`/`LookupMode` on bulkimport-api |
| **24** | **Loan leftover ports** | ~2 | `fineract-loan` api | **Done** — `LoanReadPlatformServiceCommon` + `ExpectedDisbursementDateValidator` on loan-api; `LoanStatus` residual core |
| **25** | **Instance-mode API filter** | 1 | `fineract-instancemode` api | **Done** — `FineractInstanceModeApiFilter` on instancemode-api (security-impl api-only); `FineractInstanceModeConstants` residual core (event conditions) |
| **26** | **Leftover module tests** | 2 | `fineract-clients-test` / `fineract-bulkimport-test` | **Done** — `ClientDataValidatorTest` + `LookupModeTest` next to the already-moved production types |
| **27** | **Calendar leftover** | ~2 | `fineract-calendar` api | **Done** — `CalendarRequest` + `CalendarInstanceLookupPort` on calendar-api; loan-impl api-only; entity/`CalendarData` residual core |
| **28** | **Charge convert leftover** | 1 | `fineract-charge` api | **Done** — `ConvertChargeDataToSpecificChargeData` on charge-api (savings-impl + progressive-loan already api-only); fat charge/savings/share DTOs residual core |
| **29** | **Unused image leftovers** | 4 | `fineract-document` api | **Done** — `ImageNotFoundException`/`ImageUploadException`/`ImageDataURLNotValidException`/`Base64EncodedImage` on document-api; no remaining consumers |
| **30** | **Unused JobParametersDTO** | 1 | `fineract-jobs` api | **Done** — unused wrapper on jobs-api; `JobParameterDTO` residual core (`CustomJobParameterRepository`) |

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

### Suggested order of attack

1. **Payment-type pilot** ✅ (`fineract-paymenttype` api/impl/test; entity residual in core).  
2. **Search** ✅ (`fineract-search` api/impl/test; `SearchUtil` + advanced-query DTOs residual in core).  
3. **Collection sheet** ✅ (`fineract-collectionsheet` api/impl/test; write impl residual in progressive-loan-impl).  
4. **External event subsystem** ✅ (phase 1: jobs/config/API → event-impl; outbox residual in core).  
5. **Account transfer / SI** ✅ (`fineract-accounttransfer` api/impl/test; write residual progressive-loan).  
6. **Shares pure residual** ✅ (`fineract-shares` api/impl/test; product JPA residual core).  
7. **Group pure residual** ✅ (`fineract-group` api/impl/test; entity residual core).  
8. **Client pure residual** ✅ (`fineract-clients` api/impl/test; Client hub residual core).  
9. **Post-dated checks** ✅ (`fineract-postdatedchecks` api/impl/test; entity residual loan-impl).  
10. **Client office/group transfer** ✅ (`fineract-transfer` api/impl/test; write residual progressive-loan).  
11. **Generic products REST** ✅ (`fineract-products` api/impl/test; ProductNotFoundException residual core).  
12. **Payment detail write** ✅ (`fineract-paymentdetail` api/impl/test; entity residual core).  
13. **Loan Rate catalog close-in** ✅ (`RateData` + read/write ports → rates-api; `Rate` entity residual core).  
14. **Tax request DTOs** ✅ (`Tax*Request` → tax-api; fat `TaxGroupData` residual core for SavingsAccountData).  
15. **Delinquency catalog entities** ✅ (`DelinquencyBucket`/`Range` + enums → loan-impl; WC already on loan-impl).  
16. **Meeting attendance leftover** ✅ (`MeetingAttendance*` + dropdown port → meeting-api).  
17. **Notification leftover** ✅ (`UserNotificationService` + `NotificationData` → notification-api; security-impl api-only).  
18. **Interop identifier type** ✅ (`InteropIdentifierType` → interop-api; entity residual savings-impl).  
19. **Cache admin REST** ✅ (`fineract-cache` api/impl/test; `CacheType`/`PlatformCache`/runtime manager residual core).  
20. **Loan product lookup port** ✅ (`LoanProductLookupData` + read port → loan-api).  
21. **Entity image adapter** ✅ (`EntityImageIdAdapter` → document-api).  
22. **Spring Batch PropertyService** ✅ (`PropertyService` + job constants → springbatch-api).  
23. **Bulk import ports** ✅ (workbook ports + DTOs → bulkimport-api).  
24. **Loan leftover ports** ✅ (`LoanReadPlatformServiceCommon` + `ExpectedDisbursementDateValidator` → loan-api).  
25. **Instance-mode API filter** ✅ (`FineractInstanceModeApiFilter` → instancemode-api; constants residual core).  
26. **Leftover module tests** ✅ (`ClientDataValidatorTest` → clients-test; `LookupModeTest` → bulkimport-test).  
27. **Calendar leftover** ✅ (`CalendarRequest` + `CalendarInstanceLookupPort` → calendar-api).  
28. **Charge convert leftover** ✅ (`ConvertChargeDataToSpecificChargeData` → charge-api).  
29. **Unused image leftovers** ✅ (`Image*` exceptions + `Base64EncodedImage` → document-api).  
30. **Unused JobParametersDTO** ✅ (`JobParametersDTO` → jobs-api; `JobParameterDTO` residual core).

## Related provider peels

| Peel | Status |
|------|--------|
| `fineract-useradministration` | **complete** (api/impl/test); kernel AppUser/Role residual in core |
| `fineract-adhocquery` | **complete** (api/impl/test); leftover generate-adhoc-client-schedule job closed into impl |
| `fineract-template` | **complete** (api/impl/test); Template entity residual used by hooks via impl |
| `fineract-notification` | **complete** (api/impl/test); `UserNotificationService` + `NotificationData` on notification-api; security-impl api-only |
| `fineract-spm` | **complete** (api/impl/test); self-contained provider peel; Client/AppUser from core |
| `fineract-fund` | **complete** (api/impl/test); Fund entity residual in core |
| `fineract-accountnumberformat` | **complete** (api/impl/test); entity/generator residual in core |
| `fineract-survey` | **complete** (api/impl/test); PPI/infrastructure surveys; datatable ports from core |
| `fineract-transfer` | **complete** (api/impl/test); write impl residual progressive-loan |
| share account residual (pure) | status enums, `SharesEnumerations`, frequency/dividend status types, `ShareAccountWritePlatformService` + command handlers in core; entity write/read/job stay on provider |
| `fineract-clients` | **complete** (api/impl/test); pure family/identifiers/transactions/search; Client hub residual core; main Clients REST/write residual progressive; charges residual charge-impl; address residual address-impl |
| `fineract-group` | **complete** (api/impl/test); entity/DTO/exception residual in core; Centers/Groups REST + grouping write residual progressive |
| `fineract-collectionsheet` | **complete** (api/impl/test); ports/commands/DTOs + REST/handlers/deserializers/read; write impl residual in progressive-loan-impl; group SAVECOLLECTIONSHEET handlers moved into collectionsheet-impl |
| search residual | **closed** into fineract-search; `LoanProductLookupReadPort` + lookup DTO on loan-api; adapter residual loan-impl |
| `fineract-postdatedchecks` | **complete** (api/impl/test); entity/repo/assembler/impl/config residual loan-impl |
| product-mix residual | full productmix package (REST/commands/handlers/domain/services) in loan-impl |
| loan product residual | LoanProductsApiResource, data validator, read/write impls, Spring config, assembler/update util in loan-impl (office restriction + mapping validator ports); Rate entity/repo residual in core; `RateData` + Rate read/write ports on rates-api |
| infrastructure residual (pure) | jersey JSON converters/serializers + Jackson converter config/argument handler, command JSON deserializers, performance sampling, ExternalIdConverter, CustomDateTimeProvider, SchemaUpgradeNeededException in core; app bootstrap configs stay on provider |
| share product residual (pure) | write port, dropdown, exceptions, handlers, dividend JDBC/REST, product command ports/impl stub, products REST/constants/not-found, ShareProduct domain (+ market price/repos) in core; entity write/read/serializer stay on provider |
| infrastructure residual (pure) | jersey JSON converters/serializers + Jackson converter config/argument handler, command JSON deserializers, performance sampling, ExternalIdConverter, CustomDateTimeProvider, SchemaUpgradeNeededException, jdbc/jersey/cache/jpa/liquibase helpers, auditors, password encoder, AccountNumberFormatRepositoryWrapper, CalendarInstance repos in core; app bootstrap (Web/Liquibase-only) stay on provider |
| share account residual (JDBC reads/job) | purchased-shares + account-dividend reads, schedular port, post-dividends job, commands stub, ShareAccountApiConstants, full accounts REST/DTOs/exception in core; charge read stays (charge-api enums); entity write/read/schedular impl stay on provider |
| `fineract-entityaccess` | **complete** (api/impl/test); office↔product/charge access; residual consumers in provider |
| `fineract-calendar` | **complete** (api/impl/test); `CalendarRequest` + `CalendarInstanceLookupPort` on calendar-api; entity residual in core; GroupRepository residual to core |
| `fineract-meeting` | **complete** (api/impl/test); depends on calendar-api/impl; attendance type/enum + dropdown port closed into meeting-api |
| `fineract-address` | **complete** (api/impl/test); AddressData residual in core; ClientAddress on impl |
| `fineract-creditbureau` | **complete** (api/impl/test); loan product mapping via loan-impl |
| `fineract-collateral` | **complete** (api/impl/test); legacy loan collateral residual **closed** (entity/DTO on collateral; Loan inverse collection removed) |
| `fineract-collateralmanagement` | **complete** (api/impl/test); entity residual **closed** (entities on impl; Loan inverse collection removed) |
| `fineract-note` | **complete** (api/impl/test); FK-based Note entity; share residual via ShareAccountNoteSupport |
| `fineract-hooks` | **complete** (api/impl/test); ports DTO-only + HookEventQueryService on impl; MessageGatewayHookProcessor **closed** (hooks-impl via sms + campaigns); HookEvent residual in core; Template via template-impl |
| `fineract-sms` | **complete** (api/impl/test); campaignId Long FK; scheduled job residual **closed** into campaigns-impl (`SmsMessageScheduledJobService`) |
| `fineract-reportmailingjob` | **complete** (api/impl/test); stretchyReportId Long FK (dataqueries Report residual); AppUser @ManyToOne (core); ExecuteReportMailingJobs in campaigns-impl |
| `fineract-campaigns` | **complete** (api/impl/test); Report FKs Long; residual write/domain/jobs **closed** (campaigns-impl; dataqueries/gcm/configuration/loan/savings/event) |
| `fineract-gcm` | **complete** (api/impl/test); NotificationConfigurationReadService port implemented by configuration residual; NotificationSenderService on impl |
| `fineract-dataqueries` | **complete** (api/impl/test); Report/datatable entities + platform impls; shared DTOs/ports remain in core |
| `fineract-configuration` | **complete** (api/impl/test); external services + write/read impls; global config entity/ports remain in core; async residual **closed** (SpringAsyncConfig on impl; TaskExecutor* in core) |
| `fineract-bulkimport` | **complete** (api/impl/test); workbook ports + `GlobalEntityType`/`ImportData`/`LookupMode` on bulkimport-api; `LookupModeTest` on bulkimport-test; populator impl residual provider (share) |
| `fineract-instancemode` | **complete** (api/impl/test); test-profile REST + swagger DTO + `FineractInstanceModeApiFilter` on api; constants residual in core |
| `fineract-jobs` | **complete** (api/impl/test); residual **closed** (filters + inline + retained-earning + NPA); unused `JobParametersDTO` on jobs-api; `LoanCOBEnabledCondition` on cob-impl; `BodyCachingHttpServletRequestWrapper` in core |
| `fineract-s3` | **complete** (api/impl/test); S3 client SPI + Amazon/Localstack config; report export bean via dataqueries-impl |
| `fineract-openapi` | **complete** (api/impl/test); OperationId reader + spec filter for swagger-gradle-plugin; tests on fragment |
| `fineract-springbatch` | **complete** (api/impl/test); remote job messaging; `PropertyService` + `SpringBatchJobConstants` on springbatch-api |
| `fineract-event` | **complete** (api/impl/test) + external jobs/config API peel; domain events + producers/serializers + config REST/jobs; core residual: notifier + outbox entity/service + serializer SPI |
| `fineract-accounttransfer` | **complete** (api/impl/test); ports/enums/DTOs + REST/handlers/reads/SI job; write entities residual progressive-loan; kernel residual AccountTransferData/read port + PortfolioAccount* for savings |
| `fineract-shares` | **complete** (api/impl/test); ports/DTOs/REST/handlers/reads/dividend job; ShareProduct JPA residual core; product write residual charge-impl; account entity residual savings-impl; account write residual progressive |
| `fineract-group` | **complete** (api/impl/test); ports/handlers/JDBC reads/roles write/levels REST; Group entity+DTO residual core; Centers/Groups REST + grouping-types write residual progressive |
| `fineract-clients` | **complete** (api/impl/test); family/identifiers/transactions/search pure; Client entity+ClientData residual core; `ClientDataValidatorTest` on clients-test; main Clients REST/write residual progressive |
| `fineract-postdatedchecks` | **complete** (api/impl/test); ports/DTOs/REST/handlers; entity/assembler/write residual loan-impl |
| `fineract-transfer` | **complete** (api/impl/test); ports/handlers/validator; write residual progressive-loan |
| `fineract-products` | **complete** (api/impl/test); generic products REST + share-product read port; ProductNotFoundException residual core; read impl residual charge-impl |
| `fineract-paymentdetail` | **complete** (api/impl/test); write port/impl/assembler; PaymentDetail entity/repo + PaymentDetailData residual core |
| `fineract-rates` Rate catalog close-in | **complete**; `RateData` + `RateReadService`/`RateWriteService` on rates-api; Rate entity/`RateAppliesTo`/repo/wrapper/`RateNotFoundException` residual core |
| `fineract-tax` request close-in | **complete**; `TaxComponentRequest`/`TaxGroupRequest`/`TaxGroupComponent` on tax-api; fat tax DTOs residual core (`TaxGroupData` on SavingsAccountData / ChargeData) |
| delinquency catalog close-in | **complete**; `DelinquencyBucket`/`Range`/`MinimumPaymentPeriodAndRule` + type enums on loan-impl next to repos |
| `fineract-meeting` attendance close-in | **complete**; `MeetingAttendanceType`/`Enumerations` + dropdown port on meeting-api |
| `fineract-interoperation` identifier-type close-in | **complete**; `InteropIdentifierType` on interop-api; `InteropIdentifier` entity residual savings-impl |
| `fineract-cache` | **complete** (api/impl/test); write port/DTOs + REST/handler/impl; CacheType/PlatformCache/runtime manager residual core |
| loan product lookup close-in | **complete**; `LoanProductLookupData` + `LoanProductLookupReadPort` on loan-api; adapter residual loan-impl |
| `fineract-document` image-adapter close-in | **complete**; `EntityImageIdAdapter` on document-api; clients-impl + organisation-impl implement it |
| `fineract-springbatch` PropertyService close-in | **complete**; `PropertyService` + `SpringBatchJobConstants` on springbatch-api |
| `fineract-bulkimport` port close-in | **complete**; workbook ports + `GlobalEntityType`/`ImportData`/`LookupMode` on bulkimport-api |
| loan leftover ports close-in | **complete**; `LoanReadPlatformServiceCommon` + `ExpectedDisbursementDateValidator` on loan-api; `LoanStatus` residual core |
| `fineract-instancemode` filter close-in | **complete**; `FineractInstanceModeApiFilter` on instancemode-api; `FineractInstanceModeConstants` residual core |
| leftover module tests close-in | **complete**; `ClientDataValidatorTest` → clients-test; `LookupModeTest` → bulkimport-test |
| `fineract-calendar` leftover close-in | **complete**; `CalendarRequest` + `CalendarInstanceLookupPort` on calendar-api; entity/`CalendarData` residual core |
| `fineract-charge` convert leftover close-in | **complete**; `ConvertChargeDataToSpecificChargeData` on charge-api; `ChargeData` / savings+share charge DTOs residual core |
| `fineract-document` unused image close-in | **complete**; `ImageNotFoundException`/`ImageUploadException`/`ImageDataURLNotValidException`/`Base64EncodedImage` on document-api |
| `fineract-jobs` unused JobParametersDTO close-in | **complete**; `JobParametersDTO` on jobs-api; `JobParameterDTO` residual core |


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
