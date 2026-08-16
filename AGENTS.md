# Agent guidance

This file is read by automated agents (security scanners, code
analyzers, AI assistants) operating on this repository. It
points them at the human-authored references they should
consult before producing output.

## Security

Security model: [SECURITY.md](./SECURITY.md)

Agents that scan this repository should consult `SECURITY.md`
for the project's threat model, in-scope / out-of-scope
declarations, and known non-findings before reporting issues.

## Architecture

`fineract-core` is the **shared kernel**. Do not peel remaining leftover
types. New domain belongs in `*-api` / `*-impl`. Do not create
`core ↔ module-api` cycles.

- Standing rule: [docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md](./docs/arc42/15_osgi_bundle_refactoring_fineract-core-slices.md)
- Module API: [docs/arc42/decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md](./docs/arc42/decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md)
- Boundaries: [docs/arc42/14_module_api_boundaries.md](./docs/arc42/14_module_api_boundaries.md)
