# fineract-cache

Core residual peel — cache admin REST / switch write path (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-cache-api` | `api/` | `org.apache.fineract.cache.api` | Write port, switch request/response DTOs |
| `fineract-cache-impl` | `impl/` | `org.apache.fineract.cache.impl` | REST, command handler, write impl; Equinox `CacheOsgiBundleActivator` |
| `fineract-cache-test` | `test/` | `org.apache.fineract.cache.test` | Fragment-Host → impl |

Residual in `fineract-core`: `CacheType`, `PlatformCache` / repo, `CacheData`,
`RuntimeDelegatingCacheManager`, `PlatformCacheConfiguration`, enumerations/constants
(configuration + security couple to the cache type and runtime manager).

```bash
./gradlew :fineract-cache-api:jar :fineract-cache-impl:jar :fineract-cache-test:test
```
