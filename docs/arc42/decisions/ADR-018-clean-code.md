# ADR-018 – Clean Code as Development Guiding Model

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Maintainability, Reliability, Testability, Compatibility |

### Context

fineract-osgi inherits a **large, historically grown** codebase (Apache Fineract 1.x): long methods, magic strings in `JsonCommand`, deep DTO inheritance, mixed persistence (JPA/JDBC), parallel command stacks. At the same time, requirements rise for:

- module-wise modernization ([ADR-003](ADR-003-spring-boot-gradle-module-als-kern-beibehalten.md), [ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md)),
- readable API and domain boundaries ([ADR-015](ADR-015-api-dtos-composition-statt-vererbung.md), [ADR-017](ADR-017-hexagonale-architektur.md)),
- safe change under high test load (unit, integration, E2E),
- onboarding and AI-assisted development (`AGENTS.md`, arc42).

Without a shared **Clean Code guiding model**, inconsistent styles, “quick fixes” beside migrated paths, and refactors without domain benefit risk proliferating.

### Decision

**Clean Code** (after Robert C. Martin and established practices) is the **binding quality guiding model** for new and touched code in fineract-osgi – **pragmatically**, with the Boy Scout Rule, without a big-bang rewrite of legacy.

#### Core principles (binding for new / touched code)

| Principle | In fineract-osgi |
|-----------|------------------|
| **Meaningful names** | Domain language (Loan, Deposit, Tenant); no abbreviation graveyards; API/command names mirror use cases |
| **Small, focused units** | Methods/classes one responsibility; handlers thin, domain logic in domain services |
| **Functions without side effects where possible** | Clear command boundaries; no hidden writes on read paths |
| **DRY with judgement** | Share only for real repetition; no premature framework abstractions |
| **Composition over inheritance** | DTOs and extensions: [ADR-015](ADR-015-api-dtos-composition-statt-vererbung.md); domain: clear aggregates instead of deep hierarchies |
| **Errors explicit** | Platform/domain exceptions; no swallowed exceptions; validation before side effects |
| **Comments sparingly** | Code explains *what*; comments for *why* (EclipseLink workarounds, tenant invariants, idempotency) |
| **Tests as specification** | Unit for domain/handler; IT for adapters; composition/contract tests at API seams |
| **Boy Scout Rule** | Leave touched code a bit cleaner – within diff scope, not as a mega-refactor |
| **Dependency rule** | Domain without REST/JPA vendor APIs ([ADR-017](ADR-017-hexagonale-architektur.md)) |

#### SOLID (as orientation, not dogma)

| Letter | Application |
|--------|-------------|
| **S** | One handler / one use case; resource ≠ domain |
| **O** | Extension via ports, OSGi bundles, events – not by core fork |
| **L** | Subtypes only where is-a holds (no CPR for pure GET DTOs) |
| **I** | Narrow repository/port interfaces; do not introduce new “god” service APIs |
| **D** | Application depends on ports (repos, event notifier, AI), not concrete adapters |

#### Tooling & enforcement

| Means | Role |
|-------|------|
| **Spotless / format** | uniform formatting (project Gradle) |
| **Checkstyle / SpotBugs** (where active) | mechanical hygiene |
| **CI tests** | unit + integration + selected E2E |
| **Code review** | Clean Code and hexagon rules; scope discipline |
| **arc42 + Gherkin** | architecture and behaviour clarity |
| **AGENTS.md / SECURITY.md** | bind agents and scans to guardrails |

#### Boy Scout vs. legacy

| Situation | Expectation |
|-----------|-------------|
| **New path** (`fineract-command`, new module, new adapter) | Clean Code rules fully |
| **Touched legacy** | Fix + local improvement (names, extraction, test); no unsolicited module rewrite |
| **Large refactor** | Own ticket/ADR reference; green CI; API compatibility |

### Alternatives

| Option | Assessment |
|--------|------------|
| No formal Clean Code guiding model | Inconsistency, poor onboarding |
| Strict “Clean Architecture only” packages | Too expensive parallel to hexagon/CQRS migration |
| Automatic formatters only | Insufficient for names, boundaries, tests |
| Big-bang clean rewrite | Incompatible with ADR-003/004 |

### Consequences

- **+** Shared review language; better readability and testability  
- **+** Reinforces hexagon, DTO composition, command migration  
- **+** AI/agent work stays bound to traceable rules  
- **−** Existing code diverges – expectation is evolution, not perfection  
- **−** Reviews need discipline against scope creep (“while I’m here…”)  

### Non-Goals

- Reformatting the entire repo in one PR  
- Enforcing maximally short methods at the cost of unreadable fragmentation  
- Replacing domain-necessary complexity (interest, COB, multi-tenant) with “simple” code  
- Substitute for architecture ADRs (hexagon, JPA, CQRS remain leading for structure)

### Related

- [ADR-004](ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md) Commands  
- [ADR-014](ADR-014-arc42-gherkin-als-doku-strategie.md) Docs  
- [ADR-015](ADR-015-api-dtos-composition-statt-vererbung.md) Composition  
- [ADR-016](ADR-016-jpa-ausbau-read-write-persistenz.md) Persistence clarity  
- [ADR-017](ADR-017-hexagonale-architektur.md) Dependency rule  
- Quality maintainability: [07.8](../07_quality_attributes.md) · Crosscutting: [06](../06_crosscutting_concepts.md)

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
