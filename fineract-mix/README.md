# fineract-mix

MIX taxonomy mapping and XBRL report generation — Wave 2 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-mix-api` | `api/` | `org.apache.fineract.mix.api` | Service interfaces, DTOs, command, exceptions |
| `fineract-mix-impl` | `impl/` | `org.apache.fineract.mix.impl` | JPA domain, REST, MapStruct, XBRL builder; Equinox `MixOsgiBundleActivator` |
| `fineract-mix-test` | `test/` | `org.apache.fineract.mix.test` | White-box tests; **Fragment-Host** → `mix.impl` |

No `:fineract-mix` façade.

### Module API

- `MixTaxonomyReadService`, `MixTaxonomyMappingReadService` / `WriteService`
- `MixReportXBRLResultService`, `MixReportXBRLNamespaceReadService`
- Pure DTOs under `…mix.data`; `MixTaxonomyMappingUpdateCommand`
- `MixReportXBRLMappingInvalidException`

### Consumers

| Module | Depend on |
|--------|-----------|
| provider / war | `-api` + `-impl` (composition root; JDBC scans `mix.domain`) |

```bash
./gradlew :fineract-mix-api:jar :fineract-mix-impl:jar :fineract-mix-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-mix.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-mix.md).
