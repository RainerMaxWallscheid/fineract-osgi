# fineract-architecture

ArchUnit tests that enforce **Bounded Context boundaries** at the domain-entity layer (and selected Hexagon rules).

## Why

Strategic DDD ([docs/arc42/10_domain_context_map.md](../docs/arc42/10_domain_context_map.md)) and [ADR-021 Module API](../docs/arc42/decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md) forbid:

1. Free JPA entity sharing across contexts (e.g. `Loan` holding a `Client` entity).
2. Domain modules depending on foreign **internals** (`domain` / `service` / `handler`) instead of `moduleapi`.

Legacy code still violates that; these tests:

1. Document the **target** dependency rules.
2. **Freeze** current violations so the build stays green.
3. Fail when **new** illegal dependencies are introduced.

## Run

```bash
./gradlew :fineract-architecture:test
```

## Freeze store

Violations are stored under `src/test/resources/archunit_store/` (see `src/test/resources/archunit.properties`).

- After **fixing** legacy coupling: re-run tests; the store should shrink (allowed by `allowStoreUpdate=true`).
- Do **not** grow the store without an explicit architecture decision — a growing store means new debt.

## Related docs

- [13 ArchUnit Bounded Context Rules](../docs/arc42/13_archunit_bounded_context_rules.md)
- [14 Module API Boundaries](../docs/arc42/14_module_api_boundaries.md)
- [ADR-017 Hexagon](../docs/arc42/decisions/ADR-017-hexagonale-architektur.md)
- [ADR-019 DDD](../docs/arc42/decisions/ADR-019-domain-driven-design.md)
- [ADR-021 Module API only](../docs/arc42/decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md)
