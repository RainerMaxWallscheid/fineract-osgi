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
| security-impl | `ColumnValidator`, `DefaultSqlValidator`, `DefaultInputValidator` |
| core residual | `PlatformSecurityContext`, password ports, `PlatformUser*`, `SQLBuilder`, kernel exceptions |

**Consumers:** provider/war/oauth2-tests; savings-impl depends on security-impl for `ColumnValidator`.

## Candidate later slices

| Slice | Rationale |
|-------|-----------|
| pure criteria ports without loan entities | Needs `LoanProductData` on loan-api first |
| full Money VO extraction | Deferred (kernel residual) |

## Related provider peels

| Peel | Status |
|------|--------|
| `fineract-useradministration` | **complete** (api/impl/test); kernel AppUser/Role residual in core |
| `fineract-adhocquery` | **complete** (api/impl/test); self-contained provider peel |
| `fineract-template` | **complete** (api/impl/test); Template entity residual used by hooks via impl |
| `fineract-notification` | **complete** (api/impl/test); domain event listeners residual in provider; UserNotificationService in core |
| `fineract-spm` | **complete** (api/impl/test); self-contained provider peel; Client/AppUser from core |
| `fineract-fund` | **complete** (api/impl/test); Fund entity residual in core |
| `fineract-accountnumberformat` | **complete** (api/impl/test); entity/generator residual in core |
| `fineract-survey` | **complete** (api/impl/test); PPI/infrastructure surveys; datatable ports from core |
| `fineract-entityaccess` | **complete** (api/impl/test); office↔product/charge access; residual consumers in provider |
| `fineract-calendar` | **complete** (api/impl/test); entity residual in core; GroupRepository residual to core |
| `fineract-meeting` | **complete** (api/impl/test); depends on calendar-api/impl |
| `fineract-address` | **complete** (api/impl/test); AddressData residual in core; ClientAddress on impl |
| `fineract-creditbureau` | **complete** (api/impl/test); loan product mapping via loan-impl |
| `fineract-collateral` | **complete** (api/impl/test); legacy loan collateral residual **closed** (entity/DTO on collateral; Loan inverse collection removed) |
| `fineract-collateralmanagement` | **complete** (api/impl/test); entity residual **closed** (entities on impl; Loan inverse collection removed) |


## Commands

```bash
./gradlew :fineract-businessdate-api:jar :fineract-businessdate-impl:jar :fineract-businessdate-test:test
./gradlew :fineract-codes-api:jar :fineract-codes-impl:jar :fineract-codes-test:test
./gradlew :fineract-organisation-api:jar :fineract-organisation-impl:jar :fineract-organisation-test:test
./gradlew :fineract-monetary-api:jar :fineract-monetary-impl:jar :fineract-monetary-test:test
./gradlew :fineract-security-api:jar :fineract-security-impl:jar :fineract-security-test:test
./gradlew :fineract-core:compileJava :fineract-provider:compileJava
```
