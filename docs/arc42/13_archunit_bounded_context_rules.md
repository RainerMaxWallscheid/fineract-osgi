# 13. ArchUnit – Bounded Context Entity Rules

Automated dependency rules against **cross-context entity imports** at the domain level. Implementation: module [`fineract-architecture`](../../fineract-architecture/).

References: [10 Context Map](10_domain_context_map.md) · [11 Aggregate Canvas](11_aggregate_canvas.md) · [ADR-017](decisions/ADR-017-hexagonale-architektur.md) · [ADR-019](decisions/ADR-019-domain-driven-design.md).

---

## 13.1 Goal

| Rule class | Target |
|-------------|------|
| **Entity sharing** | Domain package of a BC imports **no** JPA entities of foreign BCs (`Client`, `Group`, `Loan`, `SavingsAccount`, `JournalEntry`, …) |
| **Integration** | Only IDs, application ports, domain/business events, published language |
| **Hexagon** | `..domain..` does not depend on `..api..` (driving adapters) |

---

## 13.2 Module and execution

```bash
./gradlew :fineract-architecture:test
```

| Artifact | Path |
|----------|------|
| Entity boundaries | `…/BoundedContextEntityDependencyRulesTest.java` |
| **Module API boundaries** | `…/ModuleApiBoundaryRulesTest.java` ([ADR-021](decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md), [14](14_module_api_boundaries.md)) |
| Package constants | `ArchitecturePackages.java` |
| ArchUnit config | `src/test/resources/archunit.properties` |
| Freeze baseline | `src/test/resources/archunit_store/` |
| README | [`fineract-architecture/README.md`](../../fineract-architecture/README.md) |

Dependency: `com.tngtech.archunit:archunit-junit5` (version in `buildSrc/.../org.apache.fineract.dependencies.gradle`).

---

## 13.3 Rules (inventory)

All rules use **`FreezingArchRule`**: existing legacy violations are baselined; **new** violations break the build.

### Cross-context domain entities

| Rule-ID (test field) | From (domain) | Must not depend on | Rationale |
|--------------------|---------------|--------------------|------------|
| `loan_account_domain_must_not_depend_on_client_domain` | `..loanaccount.domain..` | `..client.domain..` | Client only as `ClientId` |
| `loan_account_domain_must_not_depend_on_group_domain` | `..loanaccount.domain..` | `..group.domain..` | Group only as `GroupId` |
| `loan_account_domain_must_not_depend_on_savings_domain` | `..loanaccount.domain..` | `..savings.domain..` | Transfer = process context |
| `loan_account_domain_must_not_depend_on_journal_entry_domain` | `..loanaccount.domain..` | `..journalentry.domain..` | Journal = projection |
| `savings_domain_must_not_depend_on_loan_account_domain` | `..savings.domain..` | `..loanaccount.domain..` | Separate BCs |
| `savings_domain_must_not_depend_on_client_domain` | `..savings.domain..` | `..client.domain..` | ClientId |
| `savings_domain_must_not_depend_on_group_domain` | `..savings.domain..` | `..group.domain..` | GroupId |
| `savings_domain_must_not_depend_on_journal_entry_domain` | `..savings.domain..` | `..journalentry.domain..` | Journal = projection |
| `accounting_domain_must_not_depend_on_loan_account_domain` | `..accounting..domain..` | `..loanaccount.domain..` | Events/DTOs, no loan entity |
| `accounting_domain_must_not_depend_on_savings_domain` | `..accounting..domain..` | `..savings.domain..` | analogous |
| `accounting_domain_must_not_depend_on_client_domain` | `..accounting..domain..` | `..client.domain..` | analogous |
| `loan_product_domain_must_not_depend_on_client_domain` | `..loanproduct.domain..` | `..client.domain..` | Product Catalog |
| `loan_origination_domain_must_not_depend_on_savings_domain` | `..loanorigination.domain..` | `..savings.domain..` | Handoff → Loan |
| `working_capital_domain_must_not_depend_on_client_domain` | `..workingcapitalloan.domain..` | `..client.domain..` | ClientId |

### Hexagon (domain → REST resource packages)

| Rule-ID | From | Must not depend on |
|---------|------|--------------------|
| `loan_account_domain_must_not_depend_on_rest_api` | loanaccount.domain | REST resource packages* |
| `savings_domain_must_not_depend_on_rest_api` | savings.domain | REST resource packages* |
| `client_domain_must_not_depend_on_rest_api` | client.domain | REST resource packages* |
| `accounting_domain_must_not_depend_on_rest_api` | accounting..domain | REST resource packages* |

\*See `ArchitecturePackages.REST_RESOURCE_PACKAGES` — e.g. `..portfolio..api..`, `..accounting..api..`.  
**Excluded:** `infrastructure.core.api` (`JsonCommand`) — application infrastructure, not HTTP adapters.

---

## 13.4 Freeze baseline (legacy debt)

On the first run, violations were written to `archunit_store`. Empty freeze files = rule already **green** (0 violations). Non-empty files = documented legacy debt.

**Baseline (domain-module classpath; refreshed after leftover peels + shares rename):**

| Rule group | Status |
|--------------|--------|
| Loan/Savings ↔ Journal | **green** (0 frozen) |
| Loan/Savings → Charge entity / write services | **green** (moduleapi only) |
| Loan → Tax catalog ports | **green** (tax-api service/moduleapi allowed) |
| Accounting → Savings internals | **green** (`SavingsTransactionEnumerations` on savings-api) |
| Accounting domain → REST `..api..` | **green** (JSON input params live in `..data..`) |
| Accounting BC (`org.apache.fineract.accounting..` only — not WC `…accounting…` processors) | **green** / residual frozen |
| Loan → Client / Group | **frozen** (`Loan.client` / `Loan.group`) |
| Savings → Client / Group | **frozen** |
| WC → Client | **frozen** |
| Savings → Loan internals | **green** (GSIM uses `SavingsAccountStatusType`) |
| Loan → Savings internals (guarantor / on-hold) | **frozen** residual |
| Loan/Investor → Accounting internals | **frozen** residual |

Exact counts: **399** frozen violation lines in **11** non-empty files (21 empty = rule green). Remaining lines are leftover JPA / entity graphs (Loan.client, investor journals) plus leftover service types that share constructors with those graphs (`GSIMReadPlatformService`, impl-only writes). Enum / JSON-param leftovers and already-on-*-api ports that lived in INTERNAL packages are on `moduleapi`. WC product mapping reads and writes use `ProductToGLAccountMappingReadPlatformService` / `WritePlatformService`. WC journals use `WorkingCapitalLoanJournalPort`. Savings journals use `SavingsJournalPort`. Loan-transaction journals post through DTO-only `LoanJournalPort`. Investor external-transfer allowed-status checks compare config `List<String>` to `LoanDataForExternalTransfer.getLoanStatusName()` (no leftover `LoanStatus.valueOf`). Loan status-change listeners use `LoanStatusChangedBusinessEvent.wasActive()` / `isNowClosedOrOverpaid()`. Investor transfer owner mapping uses overpayment amount (not leftover `LoanStatus`). External-owner transfer journals post through `ExternalOwnerTransferJournalPort` with Object-typed accounting bridges. Investor transfer initiation uses `LoanDataForExternalTransferPort`; journal-entry ownership mapping uses `LoanReadPlatformServiceCommon.findLoanIdByTransactionId`. Investor loan-product attribute validation uses `LoanProductExistencePort`. Investor COB ownership transfer uses `ExternalOwnerTransferJournalPort` and `LoanSaleDeferredIncomePort` (no leftover `LoanJournalEntryPoster` / amortization services). Transfer outstanding interest uses `LoanOutstandingInterestPort`. Transferability uses `LoanTransferBalancePort`. Transfer detail amounts use `LoanTransferSnapshotPort`. Investor transfer journal amounts also use `LoanTransferSnapshotPort`; asset-transfer journal ownership skips a second FA lookup via in-flight entry identity. Ownership-transfer event serialization uses `LoanOwnershipEventDataPort`. COB delayed-settlement product id and declined-transfer overpaid use `LoanTransferBalancePort` / `LoanTransferSnapshotPort`. Transfer journal charge-off/office/currency context uses `LoanTransferJournalContextPort`. Ownership COB/service loan ids use `LoanTransferBalancePort.loanId`. Loan-linked savings validation uses `LinkedSavingsAccountPort` (ctor savings repo retained for freeze-identity with client/group siblings). `checkClientOrGroupActive` client probes use `ClientActivePort`; group probes use `GroupActivePort`. Loan-application submit/approval client dates use `ClientActivePort`. WC application validation and loan-schedule office lookup use `ClientActivePort.officeId` / `GroupActivePort.officeId`. Savings/deposit JSON assemble and modify `isNotActive` use `ClientActivePort`/`GroupActivePort`. Loan assembler office lookup uses `officeId` ports and `Loan.getClientId()`. WC assembler client ids use JSON/`WorkingCapitalLoan.getClientId()`. Loan transfer-date checks use `ClientActivePort.officeJoiningDate`. WC disbursement/undo/charge client-active checks use `ClientActivePort`. WC journals and loan/WC mappers use loan `officeId`/`clientId`; application office lookup uses client/group `officeId` ports. Loan-application client/group validation uses `ClientActivePort`/`GroupActivePort.hasClientAsMember`. Guarantor duplicate-name and existence checks use `ClientActivePort.displayName`. Loan/WC mappers read client name/account/external id via `ClientActivePort`. Guarantor savings activation uses `LinkedSavingsAccountPort`. The loan-loss provisioning batch job lives in the Accounting package.

`ACCOUNTING_OWNED` / `ACCOUNTING_INTERNAL` use `org.apache.fineract.accounting..` so loan-owned `…workingcapitalloan.accounting…` is not treated as the Accounting BC.

**Working practice when reducing debt**

1. Replace entity ref with ID/snapshot (canvas [11](11_aggregate_canvas.md)) or retarget to `-api` / `moduleapi`.
2. Refine `ArchitecturePackages` when peels move ports out of “internal” packages (e.g. tax-api `..service..`).
3. `./gradlew :fineract-architecture:test` – freeze store may **shrink** (`allowStoreUpdate=true`).
4. PR: commit store diff (proof that debt was reduced); remove orphan freeze files when rule text changes.
5. Let store **grow** only with deliberate exception (review + ADR note).

---

## 13.5 Scope / non-goals

| In scope | Not in scope (yet) |
|----------|------------------------|
| Domain packages of loaded modules (core, loan, savings, accounting, progressive, WC, origination, …) | Entire `fineract-provider` service layer (deliberately not on the architecture classpath to keep module scope lean) |
| Entity/package dependencies | Runtime OSGi service graph |
| Freeze against regression | Immediate zero-violation goal |

**Extension:** Later add provider packages via `testImplementation project(':fineract-provider')` and freeze additional service-layer rules.

---

## 13.6 CI recommendation

- Job/stage: `./gradlew :fineract-architecture:test` (fast, ~domain-module classpath).
- Optional: on main branch `allowStoreUpdate=false` via property so freeze may shrink only locally/PR (stricter CI mode – team decision).

---

## 13.7 References

| Document | Role |
|----------|--------|
| [10 Context Map](10_domain_context_map.md) | U/D and entity-sharing ban |
| [11 Aggregate Canvas](11_aggregate_canvas.md) | Loan/Savings/Client roots |
| [12 Event Catalog](12_event_catalog.md) | Integration via events |
| [06.15 DDD](06_crosscutting_concepts.md) | Cross-cutting |
| [ADR-017](decisions/ADR-017-hexagonale-architektur.md) / [ADR-019](decisions/ADR-019-domain-driven-design.md) | North stars |

---

*Navigation:* [README](README.md) · [10 Context Map](10_domain_context_map.md) · [fineract-architecture](../../fineract-architecture/README.md)
