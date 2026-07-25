# fineract-command/api

Gradle project: `:fineract-command-api`

OSGi **interface** bundle for the modern Fineract command stack.

- **Bundle-SymbolicName:** `org.apache.fineract.command.api`
- **Export-Package:** `org.apache.fineract.command.core`, `org.apache.fineract.command.core.exception`
- **No Spring** on this surface (ADR-022)

Other modules should compile against this project (not `-impl`).

See [docs/arc42/15_osgi_bundle_refactoring_fineract-command.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-command.md).
