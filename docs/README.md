# Dokumentation für fineract-osgi

| Pfad | Inhalt |
|------|--------|
| **[arc42/](arc42/README.md)** | Architekturdokumentation (Ziele, Kontext, Bausteine, Runtime, Deployment, Qualität, ADRs, Glossar) |
| **[gherkin/](gherkin/README.md)** | Behavior-Driven Requirements (Given/When/Then), an arc42 angebunden |

## Zusammenspiel

```text
Anforderung (Gherkin)  ←→  Architektur (arc42)  ←→  Code / Tests
```

- Jedes Gherkin-Scenario trägt Tags wie `@arc42-04`, `@runtime-loan-creation`, `@adr-006`, `@quality-Q-CORR-1`.
- Die Mapping-Matrix steht in [gherkin/README.md](gherkin/README.md).
- Architekturkapitel verweisen unter „Verwandte Gherkin-Features“ zurück.

## Schnellstart Lesen

1. [arc42/01 Introduction](arc42/01_introduction.md)  
2. [gherkin Mapping](gherkin/README.md)  
3. Passendes Feature unter `gherkin/features/`  
