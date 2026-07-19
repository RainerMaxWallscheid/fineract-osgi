# ADR-015 – API-DTOs: Composition statt Vererbung

| | |
|--|--|
| **Status** | accepted |
| **Qualitäten** | Maintainability, Compatibility, Extensibility |

### Kontext

Viele API-Datenobjekte (Portfolio, Interop, Kampagnen) entstanden historisch als **Vererbungshierarchien**:

- Spezialisierungen erben Dutzende `protected`-Felder vom Shared-Parent (z. B. `FixedDepositProductData extends DepositProductData`).
- Interop-GET-Responses erben unnötig von `CommandProcessingResult`.
- Request-DTOs (SmsCampaign, Interop Quote/Transfer) erben Shared-Felder, obwohl sie nur **komponieren** müssten.

Das erschwert:

- **Wartung** (fragile base class, package-field-Zugriff, Riesen-Konstruktoren),
- **Modularisierung** (Shared-Felder kleben am Parent-Typ),
- **Korrekte Typisierung** (GET-Responses sind keine Command-Results).

Gleichzeitig darf die **öffentliche JSON-Form** nicht brechen: Clients erwarten flache Felder (`id`, `state`, `depositAmount`, …), nicht verschachtelte `product`/`request`-Objekte. Die Legacy-Serialisierung läuft über **Gson** (nicht Jackson `@JsonUnwrapped`).

### Entscheidung

**Composition first** für API-DTOs, mit explizitem Flatten für die Wire-Form:

| Muster | Wann | Wie |
|--------|------|-----|
| **Compose + flatten fields** | Read/Response-DTOs (Deposit FD/RD Product & Account, Interop specialized responses) | Shared-Typ bleibt; Spezialisierung hält flache Kopien der Shared-Felder + eigene Felder. Factories: `instance(shared, …)`, `asProductData()` / `asAccountData()`. |
| **Compose nested component** | Request-DTOs (SmsCampaign create/update, Interop request variants) | Nested `InteropRequestData` / `SmsCampaignDto`; Jackson `@JsonUnwrapped` wo Jackson bindet; für Gson-Command-Pipeline ggf. `toCommandMap()`. |
| **Drop false inheritance** | GET-only Interop DTOs | Kein `extends CommandProcessingResult`; Resource-IDs als eigene Felder. |
| **Keep CPR inheritance** | Write-Pipeline-Responses | z. B. `InteropQuoteResponseData`, `InteropIdentifierAccountResponseData` bleiben `CommandProcessingResult`-Subtypen, **komponieren** aber `InteropResponseData` flach. |

**Gson SPI** für modulspezifische TypeAdapter:

- Interface `FineractGsonTypeAdapterRegistrar` in `fineract-core`
- `ServiceLoader` in `GoogleGsonSerializerHelper.registerTypeAdapters`
- Module können Flatten-Adapter registrieren, ohne den Core zu ändern

**Polymorphe Service-Returns** wo Specialization kein Subtyp des Shared-DTO mehr ist: `Object` / `Collection<?>` / `Page<?>`; Callers casten auf konkrete FD/RD-Typen (API-Ressourcen nutzen ohnehin konkrete Serializer).

### Alternativen

| Option | Warum nicht (jetzt) |
|--------|---------------------|
| Vererbung beibehalten | Fragile Base, falsche Is-A-Beziehungen (GET ≠ CPR) |
| Nested JSON ohne Flatten | Breaking Change für Clients und Partial-Response-Parameter |
| Nur Jackson / OpenAPI-Modelle | Legacy-API und Command-Pipeline sind Gson-lastig |
| Big-Bang alle Hierarchien | Risiko und Diff-Größe untragbar; schrittweise pro Bounded Context |

### Umgesetzte Bereiche (Stand)

| Bereich | Composition |
|---------|-------------|
| SmsCampaign create/update | Nested `SmsCampaignDto` + Unwrapped / `toCommandMap` |
| Interop requests | Compose `InteropRequestData` |
| Interop specialized responses | Extend CPR + flatten `InteropResponseData` |
| Interop GET DTOs | Kein CPR; flache IDs |
| Fixed/Recurring Deposit Product | Compose/flatten `DepositProductData` |
| Fixed/Recurring Deposit Account | Compose/flatten `DepositAccountData` |

### Konsequenzen

- **+** Klarere Typgrenzen, weniger Super-Feld-Zugriff, testbare Composition-Smoke-Tests  
- **+** API-JSON bleibt flach (Kompatibilität)  
- **+** Module können Gson-Adapter via SPI liefern  
- **−** Feld-Duplikation in spezialisierten DTOs (bewusst, für Flatten)  
- **−** Service-Signaturen teils generischer (`Object`/`Collection<?>`); Callers brauchen Casts  
- **−** Static-Init-Reihenfolge bei shared Mapper-Helpers beachten (z. B. `SHARED_COLUMNS` vor Mappern)

### Bezug

- Crosscutting [6.13](../06_crosscutting_concepts.md) · Runtime [4.3](../04_runtime_view.md) · Quality [7.8 Maintainability](../07_quality_attributes.md)  
- Code: `FineractGsonTypeAdapterRegistrar`, `*DtoCompositionTest`, Deposit/Interop data packages

---

*Zurück zur Übersicht:* [08 Design Decisions](../08_design_decisions.md)
