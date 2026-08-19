# fineract-template

Provider peel — document/SMS templates (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-template-api` | `api/` | `org.apache.fineract.template.api` | Ports, DTOs, enums, commands, exceptions |
| `fineract-template-impl` | `impl/` | `org.apache.fineract.template.impl` | REST, JPA entity, merge/mustache; Equinox DS `OSGI-INF/template.xml` |
| `fineract-template-test` | `test/` | `org.apache.fineract.template.test` | Fragment-Host → impl |

Hooks still use `Template` entity via **template-impl** (composition root).

```bash
./gradlew :fineract-template-api:jar :fineract-template-impl:jar :fineract-template-test:test
```
