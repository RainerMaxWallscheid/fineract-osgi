# fineract-collectionsheet

Core residual peel — JLG / individual collection sheet API (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-collectionsheet-api` | `api/` | `org.apache.fineract.collectionsheet.api` | Ports, constants, commands, pure DTOs |
| `fineract-collectionsheet-impl` | `impl/` | `org.apache.fineract.collectionsheet.impl` | REST, handlers, deserializers, read impl, `CollectionSheetOsgiServiceRegistrar` |
| `fineract-collectionsheet-test` | `test/` | `org.apache.fineract.collectionsheet.test` | Fragment-Host → impl |

### Residual / composition-root

`CollectionSheetWritePlatformServiceJpaRepositoryImpl` stays in `fineract-progressive-loan-impl` (loan + savings deposit write coupling).

```bash
./gradlew :fineract-collectionsheet-api:jar :fineract-collectionsheet-impl:jar :fineract-collectionsheet-test:test
```
