# ADR-002 – OSGi (Equinox) for runtime modularity

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Extensibility, Maintainability, Deployability |

### Context

Gradle modules structure the build but do not allow **dynamic** activation/replacement of features (AI, institution-specific rules) at runtime. Customers should be able to load extensions without rebuilding the core.

### Decision

Introduce **OSGi** as the modularity model; as framework use **Eclipse Equinox** (see `osgi/`, `docs/arc42/osgi.gradle`).

Principles:

1. Feature implementations as **bundles**  
2. Contracts as exported **service interfaces**  
3. Core uses services **optionally** (Service Registry / Tracker)  
4. Missing bundle → **degradation**, not total failure  

### Alternatives

| Option | Assessment |
|--------|------------|
| **Apache Felix** | Valid; Equinox preferred for tooling/console/enterprise proximity |
| **Apache Karaf** | More ops comfort, but heavier platform; later optional as a distribution only — **not** as inter-bundle Features API (see [ADR-022](ADR-022-osgi-api-impl-test-bundles-services.md)) |
| **PF4J / Spring Plugin** | Lighter, but weaker isolation/versioning than OSGi |
| **Microservices per feature** | Maximum isolation, but ops and transaction complexity too high for core banking |
| **Gradle modules only** | Insufficient for hot-deploy and customer-specific binaries |

### Consequences

- **+** Hot-deploy, clear API/impl separation, customer-specific bundles  
- **+** Supports the extensibility quality goal ([Q-EXT-*](../07_quality_attributes.md))  
- **−** Bundle lifecycle, package exports, versioning discipline  
- **−** Learning curve; Equinox console must be hardened (port 2501)  
- **−** Cluster: same bundle versions on all nodes  

### Related

- Runtime [4.4](../04_runtime_view.md), Deployment [5.7](../05_deployment_view.md), Crosscutting [6.7](../06_crosscutting_concepts.md)  
- Bundle layout & Service Registry only: [ADR-022](ADR-022-osgi-api-impl-test-bundles-services.md), playbook [15](../15_osgi_bundle_refactoring.md)

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
