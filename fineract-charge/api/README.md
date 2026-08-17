# fineract-charge/api

OSGi **interface** bundle for the Charge Catalog
([ADR-022](../../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| | |
|--|--|
| Gradle project | `:fineract-charge-api` |
| Bundle-SymbolicName | `org.apache.fineract.charge.api` |
| Export-Package | `…moduleapi`, catalog `…exception` |
| Import-Package | named exported fineract packages the sources import (kernel exception/data bases, leftover `ChargeData`, …) |
| Spring / JPA entity / REST | **none** (enum `AttributeConverter`s only) |

## Contents

| Package | Content |
|---------|---------|
| `…charge.moduleapi` | Ports/DTOs (`ChargeDefinitionPort`, `ChargeDefinitionData`); pure catalog enums + converters; `ChargeReadPlatformService`; `ChargeEnumerations` |
| `…charge.exception` | Catalog exceptions (`ChargeNotFoundException`, `ChargeIsNotActiveException`, …) |

**Not here:** JPA `Charge` entity, Spring `@Service` impls, REST, fat `ChargeData` (still in `fineract-core`).  
`ChargeTimeType` (+ converter) is under the same `moduleapi` package name on **fineract-core**.

## Consumers

Prefer this module (or no charge dep) over `:fineract-charge-impl`:

- progressive-loan, accounting, loan, savings, WC → **api only**
- investor → **no charge module**
- provider / war / ITs → **api + impl** (composition root)

```bash
./gradlew :fineract-charge-api:jar
```

Plan: [15_osgi_bundle_refactoring_fineract-charge.md](../../docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md).
