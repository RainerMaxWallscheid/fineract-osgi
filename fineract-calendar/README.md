# fineract-calendar

Provider peel — collection/meeting calendars (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-calendar-api` | `api/` | `org.apache.fineract.calendar.api` | Read/write/dropdown ports, exceptions, command, `CalendarRequest`, `CalendarInstanceLookupPort` |
| `fineract-calendar-impl` | `impl/` | `org.apache.fineract.calendar.impl` | REST, repos, handlers, services, starter; Equinox DS `OSGI-INF/calendar.xml` |
| `fineract-calendar-test` | `test/` | `org.apache.fineract.calendar.test` | Fragment-Host → impl |

### Residual in `fineract-core`

`Calendar` / `CalendarInstance` / history entities, enums, `CalendarData`, `CalendarUtils`, shared exceptions. Meeting entities store calendar-instance id (not leftover CalendarInstance). Remaining leftover CalendarInstance JPA is only in `fineract-core`.

### Residual resolve

- `GroupRepository` + `GroupNotFoundException` moved to core (used by calendar write).
- `generateNextEligibleMeetingDateForCollection` takes `LocalDate` (not `MeetingData`) so api does not depend on meeting residual.

```bash
./gradlew :fineract-calendar-api:jar :fineract-calendar-impl:jar :fineract-calendar-test:test
```
