# ADR-015 – API DTOs: Composition over Inheritance

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Maintainability, Compatibility, Extensibility |

### Context

Many API data objects (portfolio, interop, campaigns) evolved historically as **inheritance hierarchies**:

- Specializations inherit dozens of `protected` fields from a shared parent (e.g. `FixedDepositProductData extends DepositProductData`).
- Interop GET responses unnecessarily inherit from `CommandProcessingResult`.
- Request DTOs (SmsCampaign, Interop Quote/Transfer) inherit shared fields even though they should only **compose**.

This hinders:

- **Maintainability** (fragile base class, package-field access, giant constructors),
- **Modularization** (shared fields stuck on the parent type),
- **Correct typing** (GET responses are not command results).

At the same time, the **public JSON shape** must not break: clients expect flat fields (`id`, `state`, `depositAmount`, …), not nested `product`/`request` objects. Legacy serialization uses **Gson** (not Jackson `@JsonUnwrapped`).

### Decision

**Composition first** for API DTOs, with explicit flattening for the wire form:

| Pattern | When | How |
|---------|------|-----|
| **Compose + flatten fields** | Read/response DTOs (Deposit FD/RD product & account, interop specialized responses) | Shared type remains; specialization holds flat copies of shared fields + own fields. Factories: `instance(shared, …)`, `asProductData()` / `asAccountData()`. |
| **Compose nested component** | Request DTOs (SmsCampaign create/update, interop request variants) | Nested `InteropRequestData` / `SmsCampaignDto`; Jackson `@JsonUnwrapped` where Jackson binds; for the Gson command pipeline possibly `toCommandMap()`. |
| **Drop false inheritance** | GET-only interop DTOs | No `extends CommandProcessingResult`; resource IDs as own fields. |
| **Keep CPR inheritance** | Write-pipeline responses | e.g. `InteropQuoteResponseData`, `InteropIdentifierAccountResponseData` remain `CommandProcessingResult` subtypes, but **compose** `InteropResponseData` flat. |

**Gson SPI** for module-specific type adapters:

- Interface `FineractGsonTypeAdapterRegistrar` in `fineract-core`
- `ServiceLoader` in `GoogleGsonSerializerHelper.registerTypeAdapters`
- Modules can register flatten adapters without changing core

**Polymorphic service returns** where specialization is no longer a subtype of the shared DTO: `Object` / `Collection<?>` / `Page<?>`; callers cast to concrete FD/RD types (API resources already use concrete serializers).

### Alternatives

| Option | Why not (now) |
|--------|---------------|
| Keep inheritance | Fragile base, wrong is-a relationships (GET ≠ CPR) |
| Nested JSON without flatten | Breaking change for clients and partial-response parameters |
| Jackson / OpenAPI models only | Legacy API and command pipeline are Gson-heavy |
| Big-bang all hierarchies | Risk and diff size intolerable; stepwise per bounded context |

### Implemented areas (as of now)

| Area | Composition |
|------|-------------|
| SmsCampaign create/update | Nested `SmsCampaignDto` + unwrapped / `toCommandMap` |
| Interop requests | Compose `InteropRequestData` |
| Interop specialized responses | Extend CPR + flatten `InteropResponseData` |
| Interop GET DTOs | No CPR; flat IDs |
| Fixed/Recurring Deposit Product | Compose/flatten `DepositProductData` |
| Fixed/Recurring Deposit Account | Compose/flatten `DepositAccountData` |

### Consequences

- **+** Clearer type boundaries, less super-field access, testable composition smoke tests  
- **+** API JSON stays flat (compatibility)  
- **+** Modules can supply Gson adapters via SPI  
- **−** Field duplication in specialized DTOs (intentional, for flatten)  
- **−** Service signatures partly more generic (`Object`/`Collection<?>`); callers need casts  
- **−** Watch static-init order for shared mapper helpers (e.g. `SHARED_COLUMNS` before mappers)

### Related

- Crosscutting [6.13](../06_crosscutting_concepts.md) · Runtime [4.3](../04_runtime_view.md) · Quality [7.8 Maintainability](../07_quality_attributes.md)  
- Code: `FineractGsonTypeAdapterRegistrar`, `*DtoCompositionTest`, Deposit/Interop data packages

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
