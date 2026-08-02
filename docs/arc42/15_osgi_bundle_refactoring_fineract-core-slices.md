# fineract-core – optional OSGi *slices* (not full api/impl)

([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md),
[15 OSGi Bundle Refactoring](15_osgi_bundle_refactoring.md)).

| Field | Value |
|-------|--------|
| **Status** | **in progress** — slices **businessdate**, **codes**, **organisation** (incl. holiday/workingdays), **monetary**, **security residual** complete |
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

## Slice 3 — organisation (office / staff / holiday / working days) ✅

| Project | Role |
|---------|------|
| `:fineract-organisation-api` | Read ports + DTOs: office, staff, holiday, working days |
| `:fineract-organisation-impl` | REST/handlers/write services/repos wrappers; `OrganisationOsgiServiceRegistrar` |
| Residual in core | `Office`/`Staff` entities + DTOs; `Holiday`/`WorkingDays` entities, utils, schedule DTOs/enums |
| Residual in provider | Organisation **provisioning** (loan-product coupling) |

**Consumers:** provider/war compose api+impl; accounting/branch inject organisation-api for office read; loan/savings inject holiday/working-days repository wrappers from impl via composition root.

## Slice 4 — monetary (currency admin) ✅

| Project | Role |
|---------|------|
| `:fineract-monetary-api` | Currency read/write ports, admin DTOs, `CurrencyUpdateCommand` |
| `:fineract-monetary-impl` | `CurrenciesApiResource`, handlers, read impls, `MonetaryOsgiServiceRegistrar` |
| Residual in core | `Money` / `CurrencyData` / currency entities, `CurrencyMapper` |
| Residual in provider | `CurrencyWritePlatformServiceJpaRepositoryImpl` + `OrganisationMonetaryConfiguration` (loan/savings/charge product coupling) |

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
| organisation provisioning | Still in provider; couples to loan products |
| full Money VO extraction | Deferred (kernel residual) |

## Commands

```bash
./gradlew :fineract-businessdate-api:jar :fineract-businessdate-impl:jar :fineract-businessdate-test:test
./gradlew :fineract-codes-api:jar :fineract-codes-impl:jar :fineract-codes-test:test
./gradlew :fineract-organisation-api:jar :fineract-organisation-impl:jar :fineract-organisation-test:test
./gradlew :fineract-monetary-api:jar :fineract-monetary-impl:jar :fineract-monetary-test:test
./gradlew :fineract-security-api:jar :fineract-security-impl:jar :fineract-security-test:test
./gradlew :fineract-core:compileJava :fineract-provider:compileJava
```
