# fineract-meeting

Provider peel — group/center meetings and attendance (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-meeting-api` | `api/` | `org.apache.fineract.meeting.api` | DTOs, commands, ports, exceptions |
| `fineract-meeting-impl` | `impl/` | `org.apache.fineract.meeting.impl` | REST, JPA, handlers, listener, OSGi registrar |
| `fineract-meeting-test` | `test/` | `org.apache.fineract.meeting.test` | Fragment-Host → impl |

Depends on `fineract-calendar-api/impl` (`CalendarInstance` association) and core `Client` / `Group` repositories.

Attendance leftover **closed**: `MeetingAttendanceType`, `MeetingAttendanceEnumerations`, and
`MeetingAttendanceDropdownReadService` live on **meeting-api** (collectionsheet-impl is api-only).

```bash
./gradlew :fineract-meeting-api:jar :fineract-meeting-impl:jar :fineract-meeting-test:test
```
