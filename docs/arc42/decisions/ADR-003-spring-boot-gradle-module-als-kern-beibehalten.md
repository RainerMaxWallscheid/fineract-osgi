# ADR-003 – Keep Spring Boot + Gradle modules as the core

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Maintainability, Compatibility, Reliability |

### Context

A full rewrite (new language, new framework) would put domain logic (loans, savings, accounting, COB) at risk. Fineract already brings Spring, Batch, Security, and a large test suite.

### Decision

- **Spring Boot** remains the application container and DI foundation.  
- Existing **Gradle modules** (`fineract-provider`, `fineract-loan`, `fineract-core`, …) remain the build structure.  
- OSGi **extends** the core (bridge); it does not replace it in a single step.

### Alternatives

| Option | Why rejected |
|--------|--------------|
| Quarkus / Micronaut rewrite | Insufficient ROI vs. migration risk |
| Pure OSGi Blueprint without Spring | Loss of ecosystem and contributor knowledge |
| Softwarica “modulith only” without OSGi | Not enough for dynamic customer features |

### Consequences

- **+** Continuity; existing tests and integrations remain usable  
- **+** Incremental modernization possible  
- **−** Two worlds (Spring + OSGi) must be bridged  
- **−** Technical debt of the monolith remains for now  

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
