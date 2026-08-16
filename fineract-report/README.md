# fineract-report

**SPI** — reporting process lookup. Not a bounded context and not an
OSGi api/impl/test split
([15 — explicit non-candidates](../docs/arc42/15_osgi_bundle_refactoring.md#explicit-non-candidates-for-osgi-bc-split)).

Six production types in one Gradle project: `@ReportService`,
`ReportingProcessService`, `AbstractReportingProcessService`,
`ReportingProcessServiceProvider`, and `ReportParameterTypeResolver` +
impl. No tests in this module.

Processors live on the owning module (`DatatableReportingProcessService`
in `fineract-dataqueries-impl`; MIX/XBRL in `fineract-mix`). Scheduled
email of reports is `fineract-reportmailingjob` (already api/impl/test).

| Do | Do not |
|----|--------|
| Depend on this jar to register or look up a `ReportingProcessService` | Split into `*-api` / `*-impl` / `*-test` |
| Add a processor on the module that owns the report type | Put stretchy-report REST, Pentaho, or MIX implementations here |
| Keep `@ReportService` next to the provider that reads it | Duplicate `fineract-reportmailingjob` or `fineract-dataqueries` here |

```bash
./gradlew :fineract-report:compileJava
```
