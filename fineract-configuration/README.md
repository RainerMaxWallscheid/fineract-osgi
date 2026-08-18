# fineract-configuration

Provider peel — global configuration + external services (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-configuration-api` | `api/` | `org.apache.fineract.configuration.api` | External-services ports/DTOs |
| `fineract-configuration-impl` | `impl/` | `org.apache.fineract.configuration.impl` | Entities, REST, write/read impls; Equinox `ConfigurationOsgiBundleActivator` |
| `fineract-configuration-test` | `test/` | `org.apache.fineract.configuration.test` | Fragment-Host → impl |

Global configuration entity/ports already in `fineract-core` (`ConfigurationDomainService`, `GlobalConfigurationProperty`, …). This peel hosts **external services** properties and JPA/write implementations.

Residual on provider: **closed** — `SpringAsyncConfig` / catch-up executors live in configuration-impl; `TaskExecutorConstant` / `TaskExecutorConfig` in core.

```bash
./gradlew :fineract-configuration-api:jar :fineract-configuration-impl:jar :fineract-configuration-test:test
```
