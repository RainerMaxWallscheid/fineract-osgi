# fineract-command/impl

Gradle project: `:fineract-command-impl`

OSGi **implementation** bundle: default synchronous dispatcher, hooks, Spring Boot auto-configuration, and optional OSGi Service Registry registration.

- **Bundle-SymbolicName:** `org.apache.fineract.command.impl`
- **Depends on:** `fineract-command-api`
- **Spring:** allowed and expected inside this bundle
- **OSGi bridge:** `org.apache.fineract.command.impl.osgi.CommandOsgiServiceRegistrar` registers `CommandDispatcher`, `CommandHandlerManager`, `CommandHookManager` when an OSGi `BundleContext` is present
- **Sources:** production **main** only — unit / white-box tests live in sibling `:fineract-command-test` (`Fragment-Host` of this bundle)

Compatibility consumers may still depend on the `fineract-command` façade (api + impl).

See [docs/arc42/15_osgi_bundle_refactoring_fineract-command.md](../../docs/arc42/15_osgi_bundle_refactoring_fineract-command.md).
