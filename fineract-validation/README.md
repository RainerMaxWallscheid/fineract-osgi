# fineract-validation

**Library** — Jakarta Bean Validation constraints. Not a bounded context
and not an OSGi api/impl/test split
([15 — explicit non-candidates](../docs/arc42/15_osgi_bundle_refactoring.md#explicit-non-candidates-for-osgi-bc-split)).

Eight production types in one Gradle project: `@LocalDate`, `@Locale`,
`@DateFormat`, `@EnumValue`, and the `ConstraintValidator`s they name in
`validatedBy`. Tests stay in `src/test` on the same project.

| Do | Do not |
|----|--------|
| Depend on this jar from core / command / domain modules | Split into `*-api` / `*-impl` / `*-test` |
| Add a new constraint here only when several modules share it | Put domain-specific validators here (those belong on the owning module) |
| Keep each annotation next to its validator | Publish OSGi services or REST from this module |

Consumers already compile against the jar the same way they depend on
`hibernate-validator`. There is nothing for `-impl` to hide.

```bash
./gradlew :fineract-validation:compileJava :fineract-validation:test
```
