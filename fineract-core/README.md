# fineract-core

**Shared kernel** — not a domain module and not a leftover backlog
([ADR-021](../docs/arc42/decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md)).

After leftover close-ins 1–30, remaining types (`~802` main / `~77` tests)
**are** the kernel. Rank 31 is the floor.

| Do | Do not |
|----|--------|
| Depend on this module from domain `*-api` / `*-impl` (**one-way**) | Depend from core on a domain `*-api` if that cycles |
| Put **new** ports, DTOs, REST, and handlers in the owning module | Peel hub / fund-style residuals to “thin” core |
| Grow core only with true platform types (tenant, Money, exceptions, serialization, command / batch metamodel) | Add new business aggregates or write paths here |

Standing rule and inventory:
[docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md).

```bash
./gradlew :fineract-core:compileJava :fineract-core:compileTestJava
```
