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
| Accounting BC (`org.apache.fineract.accounting..` only — not WC `…accounting…` processors) | **green** |
| Loan → Client / Group | **frozen** (`Loan.client` / `Loan.group`) |
| Savings → Client / Group | **frozen** |
| WC → Client | **frozen** |
| Savings → Loan internals | **green** (GSIM uses `SavingsAccountStatusType`) |
| Loan → Savings internals (guarantor / on-hold) | **green** |
| Loan/Investor → Accounting internals | **green** |

Exact counts: **156** frozen violation lines in **8** non-empty files (24 empty = rule green). Remaining lines are leftover JPA / entity graphs (Loan.client) plus leftover assembler attach and leftover Client attribute CALLs on incentive calculation. Enum / JSON-param leftovers and already-on-*-api ports that lived in INTERNAL packages are on `moduleapi`. WC product mapping reads and writes use `ProductToGLAccountMappingReadPlatformService` / `WritePlatformService`. WC journals use `WorkingCapitalLoanJournalPort`. Savings journals use `SavingsJournalPort`. Loan-transaction journals post through DTO-only `LoanJournalPort`. Investor external-transfer allowed-status checks compare config `List<String>` to `LoanDataForExternalTransfer.getLoanStatusName()` (no leftover `LoanStatus.valueOf`). Loan status-change listeners use `LoanStatusChangedBusinessEvent.wasActive()` / `isNowClosedOrOverpaid()`. Investor transfer owner mapping uses overpayment amount (not leftover `LoanStatus`). External-owner transfer journals post through `ExternalOwnerTransferJournalPort` with Object-typed accounting bridges. Investor transfer initiation uses `LoanDataForExternalTransferPort`; journal-entry ownership mapping uses `LoanReadPlatformServiceCommon.findLoanIdByTransactionId`. Investor loan-product attribute validation uses `LoanProductExistencePort`. Investor COB ownership transfer uses `ExternalOwnerTransferJournalPort` and `LoanSaleDeferredIncomePort` (no leftover `LoanJournalEntryPoster` / amortization services). Transfer outstanding interest uses `LoanOutstandingInterestPort`. Transferability uses `LoanTransferBalancePort`. Transfer detail amounts use `LoanTransferSnapshotPort`. Investor transfer journal amounts also use `LoanTransferSnapshotPort`; asset-transfer journal ownership skips a second FA lookup via in-flight entry identity. Ownership-transfer event serialization uses `LoanOwnershipEventDataPort`. COB delayed-settlement product id and declined-transfer overpaid use `LoanTransferBalancePort` / `LoanTransferSnapshotPort`. Transfer journal charge-off/office/currency context uses `LoanTransferJournalContextPort`. Ownership COB/service loan ids use `LoanTransferBalancePort.loanId`. Loan-linked savings validation uses `LinkedSavingsAccountPort`. `checkClientOrGroupActive` client probes use `ClientActivePort`; group probes use `GroupActivePort`. Loan-application submit/approval client dates use `ClientActivePort`. WC application validation and loan-schedule office lookup use `ClientActivePort.officeId` / `GroupActivePort.officeId`. Savings/deposit JSON assemble and modify `isNotActive` use `ClientActivePort`/`GroupActivePort`. Loan assembler office lookup uses `officeId` ports and `Loan.getClientId()`. WC assembler client ids use JSON/`WorkingCapitalLoan.getClientId()`. Loan transfer-date checks use `ClientActivePort.officeJoiningDate`. WC disbursement/undo/charge client-active checks use `ClientActivePort`. WC journals and loan/WC mappers use loan `officeId`/`clientId`; application office lookup uses client/group `officeId` ports. Loan-application client/group validation uses `ClientActivePort`/`GroupActivePort.hasClientAsMember`. Guarantor duplicate-name and existence checks use `ClientActivePort.displayName`. Loan/WC mappers read client name/account/external id via `ClientActivePort`. Guarantor savings activation uses `LinkedSavingsAccountPort`. Client collateral lists query by client id; inherited RD calendars use `ClientActivePort.groupIds`. Linked-loan savings id/account-number reads use `AccountAssociations.linkedSavingsAccountId` / `linkedSavingsAccountNumber`. Guarantor linked-savings ids use `GuarantorFundingDetails.linkedSavingsAccountId`. Client collateral data reads client id via JPQL. Loan-loss provisioning reserve currency uses application currency from the provisioning DTO code. Investor branch-closure checks read `acc_gl_closure` by office id. Investor owner mapping uses in-flight journal credit flags. Investor debit/credit journals persist through `ExternalOwnerTransferJournalPort`. Investor linked/charge-off GL lookups use `ExternalOwnerTransferJournalPort`. Investor owner-mapping journal loads use `ExternalOwnerTransferJournalPort`. Investor helper/mapping journal signatures are Object-typed. Investor transfer journal posting takes Object loan. Investor COB/service transfer helpers take Object loan. Investor ownership-transfer events take Object loan and loan id. External-owner journal mapping lives on accounting `moduleapi`. Investor accounting helpers no longer keep leftover mapping/journal/closure repos. Loan-loss provisioning entries store product id (not leftover LoanProduct). External-owner journal mappings store journal entry id (not leftover JournalEntry). Client collateral entities store client id (not leftover Client). Deposit interest-incentive DTOs take Object client. Savings application DTOs take Object client/group. Loan linked-savings helpers take Object savings. Guarantor on-hold helpers take Object on-hold transactions. Guarantor funding transactions store on-hold transaction id (not leftover DepositAccountOnHoldTransaction). GLIM accounts store group id (not leftover Group). GSIM accounts store group id (not leftover Group). Guarantor hold/release funds use `DepositAccountOnHoldPort`. Guarantor on-hold persist uses `DepositAccountOnHoldPort`. Guarantor hold-summary reconstruction uses `DepositAccountOnHoldPort`. Loan linked-savings association writes use `LinkedSavingsAccountPort.persistableById`. GSIM child lookup for loan-linked savings uses `LinkedSavingsAccountPort.childAccountIdForGsimClient`. Unused leftover loan savings-assembler/repo ctor siblings dropped together with leftover Client ctor siblings. Unused leftover Client ctor siblings dropped from loan-schedule assembler and WC application validator. Savings/deposit JSON assemble group-membership checks use `GroupActivePort.hasClientAsMember`. Savings DTO assemble takes Object client/group and reads ids via `ClientActivePort.id` / `GroupActivePort.id`. Savings/deposit application client association writes use `ClientActivePort.persistableById`. The loan-loss provisioning batch job lives in the Accounting package.

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
