# fineract-command/impl

Gradle project: `:fineract-command-impl`

OSGi **implementation** bundle: default synchronous dispatcher, hooks, Spring Boot auto-configuration, and optional OSGi Service Registry registration.

- **Bundle-SymbolicName:** `org.apache.fineract.command.impl`
- **Depends on:** `fineract-command-api`
- **Spring:** allowed and expected inside this bundle
- **OSGi Equinox start:** `CommandOsgiBundleActivator` registers `CommandDispatcher`, `CommandHandlerManager`, `CommandHookManager` (Spring-free empty registry)
- **OSGi Spring bridge:** `CommandOsgiServiceRegistrar` registers the same ports from Spring beans when an OSGi `BundleContext` is present
- **Sources:** production **main** only — unit / white-box tests live in `:fineract-command-test` (`fineract-command/test`, Fragment-Host); shared IT fixtures in `:fineract-command-integrationtest`

Compatibility consumers may still depend on the `fineract-command` façade (api + impl).

See [docs/arc42/15_osgi_bundle_refactoring_fineract-command.md](../../docs/arc42/15_osgi_bundle_refactoring_fineract-command.md).
