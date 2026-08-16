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
| `portfolio.client` | ~112 | **Domain residual** — pure/client satellite REST/handlers/domain already here; `Client` entity is still a kernel hub |
| `infrastructure.event` | ~87 | **Mixed** — notifier/bus ports are kernel; external-event jobs/config/API look peelable toward `fineract-event` |
| `portfolio.shares*` + accounts/products | ~81 | **Domain residual** — pure share residual intentionally parked in core; entity write/read still elsewhere |
| `portfolio.group` | ~74 | **Domain residual** — pure group residual; `Group` entity + centers/groups write still composition-coupled |
| `portfolio.account` | ~60 | **Domain residual** — account-transfer/SI pure + REST; entity write adapters cross loan/savings |
| `organisation.*` | ~51 | **Kernel residual** — entities/DTOs kept after organisation-api/impl slice (by design) |
| `portfolio.savings` (kernel math/DTOs) | ~42 | **Shared kernel-ish** — compounding/posting math + shared savings DTOs used by savings-impl |
| `portfolio.collectionsheet` | ~29 | **Domain residual** — pure REST/DTO/handlers; write impl stays loan/savings-bound |
| `infrastructure.dataqueries` residual | ~27 | **Kernel residual** — shared datatable/report DTOs after dataqueries peel |
| `portfolio.paymenttype` | ~24 | **Strong peel candidate** — coherent entity+REST+handlers package |
| `commands` | ~23 | **Shared kernel** — command pipeline (alongside `fineract-command*`) |
| `portfolio.calendar` residual | ~23 | **Kernel residual** — entities/repos after calendar peel |
| `accounting` residual | ~21 | **Kernel residual** — thin shared accounting DTOs/enums after accounting peel |
| `batch` | ~19 | **Shared kernel** — batch API framework |
| `portfolio.search` | ~18 | **Peel candidate** — REST/JDBC already thinned via `LoanProductLookupReadPort` |
| `useradministration` residual | ~14 | **Kernel residual** — AppUser/Role residual after useradmin peel |
| `portfolio.transfer` | ~13 | **Thin residual** — transfer ports/handlers; entity write still client-bound |
| `portfolio.repaymentwithpostdatedchecks` | ~11 | **Thin residual** — pure ports/REST; entity already in loan-impl |

### Ranked next peels (if pursuing more core work)

| Rank | Candidate | ~types | Target | Why / risk |
|------|-----------|--------|--------|------------|
| **1** | **Payment type** | ~24 | `fineract-paymenttype` api/impl/test | **Done** — ports/DTOs + REST/handlers in paymenttype-*; `PaymentType` entity/repo/not-found residual in core |
| **2** | **Search** | ~18 | new `fineract-search` or dataqueries-adjacent | Already port-thinned (`LoanProductLookupReadPort`); low entity mass |
| **3** | **Collection sheet** | ~29 | new `fineract-collectionsheet` | Pure residual package; write impl stays behind ports on loan/savings |
| **4** | **External event subsystem** | subset of ~87 | extend `fineract-event` | Jobs/config/API/repos still in core while producers already live in event-impl — consolidate carefully to avoid notifier cycles |
| **5** | **Account transfer / SI pure+REST** | ~60 | new module or savings/loan-owned | Cross-product (loan+savings); entity write adapters remain hard |
| **6** | **Shares pure residual** | ~81 | new `fineract-shares` | Large; entity write/read/job residual still composition-coupled |
| **7** | **Group pure residual** | ~74 | new `fineract-group` | `Group` entity + progressive-loan composition roots still bind centers/groups write |
| **8** | **Client pure residual** | ~112 | new `fineract-clients` (domain) | Highest value long-term; highest risk — `Client` is a shared hub; only after paymenttype/search pilot |

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

### Suggested order of attack

1. **Payment-type pilot** ✅ (`fineract-paymenttype` api/impl/test; entity residual in core).  
2. **Search** (if payment-type proves the consumer retarget pattern).  
3. **Collection sheet** (package move behind existing ports).  
4. Only then consider **shares** or **client** — each is a multi-PR program, not a leftover peel.

## Related provider peels

| Peel | Status |
|------|--------|
| `fineract-useradministration` | **complete** (api/impl/test); kernel AppUser/Role residual in core |
| `fineract-adhocquery` | **complete** (api/impl/test); leftover generate-adhoc-client-schedule job closed into impl |
| `fineract-template` | **complete** (api/impl/test); Template entity residual used by hooks via impl |
| `fineract-notification` | **complete** (api/impl/test); domain event listeners residual in provider; UserNotificationService in core |
| `fineract-spm` | **complete** (api/impl/test); self-contained provider peel; Client/AppUser from core |
| `fineract-fund` | **complete** (api/impl/test); Fund entity residual in core |
| `fineract-accountnumberformat` | **complete** (api/impl/test); entity/generator residual in core |
| `fineract-survey` | **complete** (api/impl/test); PPI/infrastructure surveys; datatable ports from core |
| client office/group transfer residual | pure types + `TransferWritePlatformService` + command handlers in core; entity write impl stays on provider |
| share account residual (pure) | status enums, `SharesEnumerations`, frequency/dividend status types, `ShareAccountWritePlatformService` + command handlers in core; entity write/read/job stay on provider |
| client residual (pure write/read/REST) | family/identifiers/transactions REST + search v2 + ClientChargeData + validators + internal client REST + family/nonperson/transfer domain + family/identifier write impls + ClientMapper + pure support types + JDBC txn read in core; address REST/handlers/read in address-impl; main clients/charges REST + charge/txn entity write + main client write/read stay on provider |
| group residual (pure) | exceptions, GroupTypes/enumerations, level/role repos+wrappers, write ports, level/roles JDBC reads, center/group JDBC reads, roles write impl, validators, GroupsLevelApiResource, handlers (incl. collection-sheet) + AllGroupTypesDataMapper in core; Centers/Groups REST + grouping-types write stay on provider |
| collectionsheet residual (pure) | pure DTOs/requests, write port, handlers, deserializers, JLGCollectionSheetData, read impl, REST in core (thin LoanProductLookupData); write impl stays (loan/savings) |
| search residual | SearchApiResource + SearchRead JDBC + AdHocSearchQueryData in core via LoanProductLookupReadPort (loan-impl adapter) |
| postdated-check residual (pure) | data/status/exceptions/ports/handlers/REST in core; entity/repo/assembler/impl/config in loan-impl |
| product-mix residual | full productmix package (REST/commands/handlers/domain/services) in loan-impl |
| loan product residual | LoanProductsApiResource, data validator, read/write impls, Spring config, assembler/update util in loan-impl (office restriction + mapping validator ports); Rate repo/wrapper in core |
| infrastructure residual (pure) | jersey JSON converters/serializers + Jackson converter config/argument handler, command JSON deserializers, performance sampling, ExternalIdConverter, CustomDateTimeProvider, SchemaUpgradeNeededException in core; app bootstrap configs stay on provider |
| share product residual (pure) | write port, dropdown, exceptions, handlers, dividend JDBC/REST, product command ports/impl stub, products REST/constants/not-found, ShareProduct domain (+ market price/repos) in core; entity write/read/serializer stay on provider |
| infrastructure residual (pure) | jersey JSON converters/serializers + Jackson converter config/argument handler, command JSON deserializers, performance sampling, ExternalIdConverter, CustomDateTimeProvider, SchemaUpgradeNeededException, jdbc/jersey/cache/jpa/liquibase helpers, auditors, password encoder, AccountNumberFormatRepositoryWrapper, CalendarInstance repos in core; app bootstrap (Web/Liquibase-only) stay on provider |
| share account residual (JDBC reads/job) | purchased-shares + account-dividend reads, schedular port, post-dividends job, commands stub, ShareAccountApiConstants, full accounts REST/DTOs/exception in core; charge read stays (charge-api enums); entity write/read/schedular impl stay on provider |
| `fineract-entityaccess` | **complete** (api/impl/test); office↔product/charge access; residual consumers in provider |
| `fineract-calendar` | **complete** (api/impl/test); entity residual in core; GroupRepository residual to core |
| `fineract-meeting` | **complete** (api/impl/test); depends on calendar-api/impl |
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
| `fineract-bulkimport` | **complete** (api/impl/test); ports/DTOs in core; residual on provider: populator service + share-account import/populators + guarantor import (GuarantorData still on provider) |
| `fineract-instancemode` | **complete** (api/impl/test); test-profile REST + swagger DTO peeled; constants + servlet filter remain in core |
| `fineract-jobs` | **complete** (api/impl/test); residual **closed** (filters + inline + retained-earning + NPA); `LoanCOBEnabledCondition` on cob-impl; `BodyCachingHttpServletRequestWrapper` in core |
| `fineract-s3` | **complete** (api/impl/test); S3 client SPI + Amazon/Localstack config; report export bean via dataqueries-impl |
| `fineract-openapi` | **complete** (api/impl/test); OperationId reader + spec filter for swagger-gradle-plugin; tests on fragment |
| `fineract-springbatch` | **complete** (api/impl/test); remote job messaging (JMS/Kafka/Spring events); PropertyService port remains in core |
| `fineract-event` | **complete** (api/impl/test); domain business events + external producers/serializers; residual share + loan stayed-locked on provider; core keeps ports/repos |


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
