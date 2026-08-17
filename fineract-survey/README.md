# fineract-survey

Provider peel — PPI / infrastructure surveys (ADR-022). Distinct from SPM scorecards (`fineract-spm`).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-survey-api` | `api/` | `org.apache.fineract.survey.api` | DTOs, constants, survey/likelihood/poverty-line ports |
| `fineract-survey-impl` | `impl/` | `org.apache.fineract.survey.impl` | REST, JPA likelihood, handlers, services; Equinox `SurveyOsgiBundleActivator` |
| `fineract-survey-test` | `test/` | `org.apache.fineract.survey.test` | Fragment-Host → impl |

Uses datatable ports from `fineract-core` (`DatatableReadService` / `DatatableWriteService`); implementations stay on the composition root.

```bash
./gradlew :fineract-survey-api:jar :fineract-survey-impl:jar :fineract-survey-test:test
```
