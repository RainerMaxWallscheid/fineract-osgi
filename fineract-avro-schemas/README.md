# fineract-avro-schemas

**Published language** — Avro payload schemas for external events. Not
a bounded context and not an OSGi api/impl/test split
([ADR-021](../docs/arc42/decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md),
[12.6 Avro](../docs/arc42/12_event_catalog.md)).

Source of truth is `src/main/avro/**/*.avsc` (`MessageV1`, `loan/v1`,
`savings/v1`, …). Gradle preprocesses them and `buildJavaSdk` generates
the Java records. The only hand-written type is
`ByteBufferSerializable`.

Serializers, outbox, and notifier live in `fineract-event` /
`fineract-core`. Consumers compile against the generated types after
`buildJavaSdk`.

| Do | Do not |
|----|--------|
| Add or version an `.avsc` here when it is an external-event payload | Split into `*-api` / `*-impl` / `*-test` |
| Depend on this jar for generated `SpecificRecord` types | Put serializers, REST, or outbox here |
| Keep the envelope (`MessageV1`, `BulkMessage*`) next to domain folders | Treat generated Java as a hidden impl |

```bash
./gradlew :fineract-avro-schemas:buildJavaSdk :fineract-avro-schemas:compileJava
```
