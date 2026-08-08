# fineract-note

Provider peel — portfolio notes (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-note-api` | `api/` | `org.apache.fineract.note.api` | Ports, DTOs, NoteType, exceptions |
| `fineract-note-impl` | `impl/` | `org.apache.fineract.note.impl` | Entity (FK ids), REST, handlers, OSGi |
| `fineract-note-test` | `test/` | `org.apache.fineract.note.test` | Fragment-Host → impl |

`Note` stores foreign keys as Long columns (no cross-module `@ManyToOne`). Share-account notes use residual `ShareAccountNoteSupport` on provider.

```bash
./gradlew :fineract-note-api:jar :fineract-note-impl:jar :fineract-note-test:test
```
