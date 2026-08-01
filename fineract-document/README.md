# fineract-document

Document management + content store (filesystem / S3) — Wave 2 OSGi modularization
([ADR-022](../docs/arc42/decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

| Gradle project | Path | Bundle-SymbolicName | Role |
|----------------|------|---------------------|------|
| `fineract-document-api` | `api/` | `org.apache.fineract.document.api` | Contracts: `ContentStoreService`, document/image ports, DTOs, exceptions |
| `fineract-document-impl` | `impl/` | `org.apache.fineract.document.impl` | FS/S3 adapters, policies, REST, handlers; **OSGi** `DocumentOsgiServiceRegistrar` |
| `fineract-document-test` | `test/` | `org.apache.fineract.document.test` | White-box tests; **Fragment-Host** → `document.impl` |

No `:fineract-document` façade.

### Module API

- **Ports:** `ContentStoreService` (FS/S3), `ContentStreamPort` (async stream pipe)
- Document & image read/write service interfaces
- Pure request/response DTOs and command types
- Content-store exceptions

Adapters: `FileContentStoreService`, `S3ContentStoreService`, `ContentPipe` (impl only — do not leak AWS types into api).

### Consumers

| Module | Depend on |
|--------|-----------|
| provider / war | `-api` + `-impl` (composition root; bulk-import uses `ContentStreamPort`) |

```bash
./gradlew :fineract-document-api:jar :fineract-document-impl:jar :fineract-document-test:test
```

Plan: [docs/arc42/15_osgi_bundle_refactoring_fineract-document.md](../docs/arc42/15_osgi_bundle_refactoring_fineract-document.md).
