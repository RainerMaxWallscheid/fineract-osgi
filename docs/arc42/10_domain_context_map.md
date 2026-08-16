# 10. Domain Context Map (DDD)

This chapter documents the **strategic domain decomposition** of fineract-osgi: bounded contexts, subdomain classification, context map (upstream/downstream), and migration order.

It fulfills evolution stage **D1** from [ADR-019](decisions/ADR-019-domain-driven-design.md) (*context map in documentation*) and complements:

- physical modules → [03 Building Block View](03_building_block_view.md)
- hexagon / ports → [ADR-017](decisions/ADR-017-hexagonale-architektur.md)
- write events / ES → [ADR-020](decisions/ADR-020-event-sourcing-writes-pflicht.md)
- business/technical context → [02 Context and Scope](02_context_and_scope.md)

**Status:** living document – context boundaries sharpen with ES and module migration (D3/D4).

---

## 10.1 Guiding principles

| Principle | Meaning in fineract-osgi |
|---------|----------------------------|
| **Gradle module ≠ bounded context** | Modules are physical cuts; BCs are linguistic and model boundaries. One BC can span multiple modules (e.g. Loan Servicing); one module can host parts of several legacy contexts (`fineract-core`). |
| **Integration without entity sharing** | Across context boundaries: **IDs**, **published language** (commands, Avro/business events, application DTOs) – do not import JPA entities of foreign domains. |
| **Shared kernel is `fineract-core`** | Remaining `fineract-core` (`~802` types) **is** the shared kernel. **Growth** stays narrow: new aggregates go in domain `*-api` / `*-impl`, not core. Do not peel leftover hub / fund-style residuals. |
| **Accounting remains the ledger** | Journal/GL is its own context and a **projection** from domain events – not replaced by the event store ([ADR-020](decisions/ADR-020-event-sourcing-writes-pflicht.md)). |
| **Incremental** | The context map steers strangler migration; no big-bang microservice cut. |

### Integration styles (legend)

| Abbrev. | Style | Use here |
|--------|------|-----------------|
| **U/D** | Upstream / Downstream | Data and model flow: downstream depends on upstream |
| **OHS** | Open Host Service | Stable API/events of the upstream for multiple downstream consumers |
| **PL** | Published Language | Shared integration vocabulary (Avro, command types, event names) |
| **C/S** | Customer / Supplier | Explicit supply relationship (downstream as customer) |
| **CF** | Conformist | Downstream largely adopts the upstream model unchanged |
| **ACL** | Anti-Corruption Layer | Translation of foreign/external models into the own model |
| **SK** | Shared Kernel | `fineract-core` as-is; **growth** stays narrow (no new aggregates in core) |
| **PROC** | Process / Orchestration | Context orchestrates multiple aggregates without own product truth |

---

## 10.2 Bounded contexts (target picture)

### 10.2.1 Portfolio / core products

| Bounded context | Responsibility | Ubiquitous language (excerpt) | As-is artifacts |
|-----------------|---------------|------------------------------|---------------|
| **Loan Servicing** | Lifecycle and account management of active loans | Disbursement, Schedule, Repayment, Write-off, Reschedule, Delinquency, Charge-off | `fineract-loan`, `fineract-progressive-loan`, `fineract-working-capital-loan`, `portfolio/loanaccount` |
| **Loan Origination** | Application, assessment, approval, handoff to servicing | Application, Underwriting, Approval, Scoring | `fineract-loan-origination` (+ application-submit parts in loan legacy) |
| **Savings & Deposits** | Savings deposits, fixed and recurring deposit contracts | Deposit, Withdrawal, Interest Posting, Hold, Maturity, Pre-Closure, GSIM | `fineract-savings` |
| **Share Accounts** | Cooperative/membership shares | Share Product, Subscription, Dividend | `portfolio/shareaccounts`, `shareproducts` (provider/core) |
| **Account Transfer** | Cross-account movements (process context) | Account Transfer, Standing Instruction, Loan from Savings | `portfolio/account` (provider) |

**Loan Servicing – internal modules (no separate deploy cut required):**

| Module / subdomain | Role |
|-------------------|--------|
| Standard Loan | Classic loan lifecycle |
| Progressive Loan | Progressive schedule / recalculation |
| Working Capital Loan | WC products, breach / near-breach |
| Delinquency | Ranges, buckets, pause – speaks loan language |

### 10.2.2 Party & organisation

| Bounded context | Responsibility | Ubiquitous language (excerpt) | As-is artifacts |
|-----------------|---------------|------------------------------|---------------|
| **Client & Group (Party)** | Clients and groups as portfolio carriers | Client, Non-Person, Activation, Closure, Transfer, Group/Center, Membership | `portfolio/client`, `portfolio/group` (core + provider) |
| **Organisation** | Institutional structure and calendar | Office, Staff, Working Days, Holiday, Currency | `organisation/*` (core/provider) |
| **Branch Cash / Teller** | Branch cash and teller settlement | Teller, Cashier, Cash Transaction | `fineract-branch` |

### 10.2.3 Product & pricing configuration

| Bounded context | Responsibility | Ubiquitous language (excerpt) | As-is artifacts |
|-----------------|---------------|------------------------------|---------------|
| **Product Catalog** | Product definitions (config, not runtime account) | LoanProduct, SavingsProduct, Fund, Interest Chart (product) | Loan/Savings product packages, `fineract-rates` |
| **Charge Catalog** | Fee *definitions* | Charge Definition, Charge Time, Amount Rule | `fineract-charge` |
| **Tax** | Tax components and groups | Tax Component, Tax Group | `fineract-tax` |
| **Collateral** | Collateral management | Collateral, Valuation, Client/Loan Collateral Link | `portfolio/collateral*` |

> **Note:** An instantiated `LoanCharge` / `SavingsAccountCharge` belongs to the respective **account context** (entity under Loan/Savings), not to the Charge Catalog.

### 10.2.4 Finance & downstream

| Bounded context | Responsibility | Ubiquitous language (excerpt) | As-is artifacts |
|-----------------|---------------|------------------------------|---------------|
| **Accounting (GL)** | Chart of accounts, journal, closings, product→GL mapping | GL Account, Journal Entry, Closure, Provisioning, Accounting Rule | `fineract-accounting` |
| **Investor / Secondary Market** | Loan sale / ownership transfer | External Asset Owner, Loan Ownership Transfer | `fineract-investor` |
| **Reporting & Regulatory** | Reports and regulatory formats (primarily read) | Report, MIX, Trial Balance Export | `fineract-report`, `fineract-mix`, `adhocquery` |

### 10.2.5 Integration & platform

| Bounded context / system | Responsibility | As-is artifacts |
|--------------------------|---------------|---------------|
| **COB / Batch Operations** | Orchestration of periodic domain steps (driver, no product truth) | `fineract-cob` + domain COB steps |
| **Interop (Payments)** | External payment/identifier protocol → ACL in front of Savings/Client | `interoperation` (provider/savings) |
| **Document Management** | Attachments and metadata on entity IDs | `fineract-document` |
| **Identity & Access** | Users, roles, permissions, OIDC, 2FA | `fineract-security`, `useradministration` |
| **Platform / Shared Kernel** | Tenant, command pipeline, validation, event envelope, plus accepted hub / fund-style residual | `fineract-core` (**is** the SK; leftover floor), `fineract-command*`, `fineract-validation`, `fineract-avro-schemas` |

---

## 10.3 Core / supporting / generic subdomains

Classification steers **investment intensity** (model quality, ES priority, team focus) – not “whether needed”.

```text
                    STRATEGIC VALUE
                         ↑
     CORE                │  Loan Servicing
                         │  Savings & Deposits
                         │  Loan Origination (when underwriting/AI is differentiating)
                         │
     SUPPORTING          │  Client & Group
                         │  Accounting (GL)
                         │  Product Catalog / Charges / Tax
                         │  Organisation / Branch Cash
                         │  Account Transfer
                         │  Investor, Collateral, Share
                         │  COB, Reporting / MIX
                         │
     GENERIC             │  IAM / Security, Documents, Notifications
                         │  Multi-Tenancy, Command/Audit, Validation
                         │  Interop protocol adapters, Object Store
                         ↓
              IN-HOUSE DEVELOPMENT / MODEL DEPTH →
```

| Type | Contexts | Rationale |
|-----|----------|------------|
| **Core Domain** | Loan Servicing, Savings & Deposits, optional Loan Origination | Differentiation (schedule, recalc, progressive, WC, deposit interest); highest cost of failure; ES/CQRS benefit maximal |
| **Supporting Subdomain** | Client/Group, Accounting, Products/Charges/Tax, Organisation, Branch, Transfers, Investor, Collateral, Share, COB, Reporting | Essential for operations; Accounting is *critical* but regulatorily standardisable |
| **Generic Subdomain** | Security/IAM, Documents, Platform/Tenant, Command infra, Validation, Notifications, Interop ACL | Standardise, keep thin, swappable adapters |

### Shared kernel (`fineract-core`)

`fineract-core` **is** the shared kernel ([ADR-021](decisions/ADR-021-modul-kommunikation-nur-ueber-module-api.md), [core slices standing rule](15_osgi_bundle_refactoring_fineract-core-slices.md#standing-rule-fineract-core-is-the-shared-kernel)). After leftover peels 1–30, remaining `~802` types stay.

| In the kernel (as-is) | Do not add to the kernel |
|-----------------------|--------------------------|
| `Money` / `Currency` / monetary primitives, tenant / business-date context, `ExternalId` | New bounded-context REST, handlers, write services |
| Permission / command / batch metamodel, event envelope (`MessageV1`), platform exceptions | New business aggregates (put them in `*-api` / `*-impl`) |
| Hub residuals (`LoanStatus`, `AccountType`, `ChargeData`, …) | New module-api ports invented only to “thin” core |
| Fund-style entities (`Client`, `Group`, `PaymentType`, `Fund`, `Rate`, Office/Staff residual) | `Loan` / `SavingsAccount` write graphs — those belong in loan / savings modules |

**Growth stays narrow.** The leftover floor is accepted; it is not a license to dump new aggregates into core.

---

## 10.4 Context map

### 10.4.1 Overview (target picture)

```mermaid
flowchart TB
  subgraph Platform["Platform / Generic"]
    SK[Shared Kernel<br/>Money Tenant Command]
    IAM[Identity and Access]
    DOC[Documents]
  end

  subgraph Party["Party"]
    CLI[Client and Group]
    ORG[Organisation]
  end

  subgraph Config["Configuration"]
    PROD[Product Catalog]
    CHG[Charge Catalog]
    TAX[Tax]
  end

  subgraph CoreDom["Core Domain"]
    ORIG[Loan Origination]
    LOAN[Loan Servicing]
    SAV[Savings and Deposits]
  end

  subgraph Finance["Finance"]
    GL[Accounting GL]
    INV[Investor]
    XFER[Account Transfer]
  end

  subgraph Ops["Operations"]
    COB[COB Batch]
    REP[Reporting MIX]
    BR[Branch Teller]
  end

  subgraph Ext["External"]
    KI[AI Scoring]
    PAY[Interop Payments]
  end

  ORG -->|U/D OHS IDs| CLI
  CLI -->|U/D OHS ClientId| LOAN
  CLI -->|U/D OHS ClientId| SAV
  CLI -->|U/D| ORIG
  PROD -->|U/D C/S Product snapshot| LOAN
  PROD -->|U/D Product snapshot| SAV
  CHG -->|U/D Charge defs| LOAN
  CHG -->|U/D| SAV
  TAX -->|U/D| LOAN
  TAX -->|U/D| SAV

  ORIG -->|C/S ApplicationApproved| LOAN

  LOAN -->|U/D PL Events| GL
  SAV -->|U/D PL Events| GL
  INV -->|Events Journals| GL
  LOAN -->|OHS LoanOwnership| INV

  XFER -->|PROC orchestrates| LOAN
  XFER -->|PROC orchestrates| SAV

  COB -->|Batch Driver| LOAN
  COB -->|Batch Driver| SAV
  COB --> INV

  LOAN & SAV & GL & CLI -->|Read models| REP
  BR -->|Cash posts refs| SAV
  BR --> ORG

  KI -.->|ACL async fail-open| ORIG
  KI -.->|ACL| LOAN
  PAY -.->|ACL| SAV
  PAY -.->|ACL| CLI

  SK --- LOAN & SAV & CLI & GL
  IAM --- LOAN & SAV & CLI
  DOC -.->|by entity id| CLI & LOAN
```

### 10.4.2 Upstream / downstream relationships

| Upstream | Downstream | Style | Mechanism / published language |
|----------|------------|------|----------------------------------|
| **Organisation** | Client, Loan, Branch, COB | OHS | `OfficeId`, `StaffId`; working days for schedule/COB |
| **Client & Group** | Loan, Savings, Origination, Investor | OHS / PL | `ClientId` / `GroupId`; events `ClientActivated`, `ClientClosed`, `ClientTransferred` – **no** import of the `Client` entity into the loan domain |
| **Product Catalog** | Loan / Savings | C/S | Product **snapshot** at account creation (freeze terms) |
| **Charge Catalog / Tax** | Loan / Savings | CF at definition level | Catalog IDs; instances live in the account aggregate |
| **Loan Origination** | Loan Servicing | C/S | e.g. `LoanApplicationApproved` → servicing creates `Loan` |
| **Loan Servicing** | Accounting | U/D, PL | Business/domain events → journal projector |
| **Savings & Deposits** | Accounting | U/D, PL | analogous to loan |
| **Loan Servicing** | Investor | OHS | Ownership-transfer events |
| **Investor** | Accounting | U/D | Investor-specific journals |
| **Account Transfer** | Loan + Savings | PROC | Orchestration; each side keeps its own aggregate |
| **COB / Batch** | Loan / Savings / Investor | Downstream driver | Calls application ports; knows no entity internals |
| **Reporting** | (all business contexts) | pure downstream | Read models / event feeds |
| **AI / Interop** | Origination, Loan, Savings, Client | **ACL** | External models → internal commands; fail-open for async AI ([ADR-006](decisions/ADR-006-ki-default-asynchron-fail-open.md)) |
| **Identity & Access** | all write contexts | Generic OHS | Permissions before commands |

### 10.4.3 Dependency direction (target)

```text
Organisation ──► Client/Group ──► Loan / Savings ──► Accounting
     │                │                  │                ▲
     └──── COB ◄──────┴──────────────────┘                │
                    Events / Product snapshots ───────────┘
```

### 10.4.4 Known as-is deviations (technical debt)

| Deviation | Problem | Target |
|------------|---------|------|
| `Loan` holds JPA `@ManyToOne` on `Client` / `Group` / `LoanProduct` | Object-graph coupling across context boundaries | IDs only + ProductSnapshot / read projection |
| `Client` / `Group` / parts of Organisation in `fineract-core` | Fund-style residual after peels | **Stay** — owning modules exist (`fineract-clients` / `fineract-group` / `fineract-organisation`); entities remain kernel to avoid `core ↔ module-api` cycles |
| God aggregates (`Loan` ~2k LOC, `SavingsAccount` ~3k+ LOC) | Unclear invariants; ES streams unwieldy | Snapshot + events; optional root splits (e.g. RescheduleRequest) |
| Accounting mapping code under loan packages | Context leak | Mapping in accounting context; loan publishes business events |
| Account Transfer as implicit service coupling | Distributed transactions without clear orchestration | Process manager / saga via application ports |

---

## 10.5 Aggregate roots (core contexts)

Detailed canvases (invariants, commands, events, conflicts): **[11 Aggregate Canvas](11_aggregate_canvas.md)** for `Loan`, `SavingsAccount`, `Client`.

Here the **recommended roots** for reviews and ES streams.

### 10.5.1 Loan Servicing

| Aggregate root | Consistency boundary (excerpt) | Stream idea |
|----------------|---------------------------|-------------|
| **`Loan`** | Status/timeline, term, schedule installments, transactions (or critical state), disbursements, allocation rules, summary | `Loan-{id}` |
| **`LoanProduct`** | Product terms, recalc/delinquency config refs | `LoanProduct-{id}` |
| **`LoanRescheduleRequest`** | Request until approval; apply writes events on `Loan` | own root until approval |
| **`GLIM`** | Group Loan Individual Monitoring container | `GLIM-{id}` |
| **`DelinquencyBucket` / `Range`** | Config | Config streams |
| **WC Breach** (optional) | Working-capital breach lifecycle | `WcLoanBreach-{id}` or similar |

**Rules:** `Client` and `LoanProduct` in the loan write model only as **ID** (+ frozen product snapshot). Transaction history primarily as **event stream** / read model, not as a fully loaded JPA collection for every use case.

### 10.5.2 Savings & Deposits

| Aggregate root | Consistency boundary (excerpt) | Stream idea |
|----------------|---------------------------|-------------|
| **`SavingsAccount`** | Status, balance/summary, transactions, account charges, holds | `SavingsAccount-{id}` |
| **`FixedDepositAccount`** | Term, pre-closure, maturity, chart on the account | own stream type or specialisation |
| **`RecurringDepositAccount`** | Recurring schedule vs. actuals | analogous to FD |
| **`SavingsProduct` / FD/RD Product** | Product config | Product streams |
| **`GSIM`** | Group Savings Monitoring | `GSIM-{id}` |
| **`InterestRateChart`** | Slabs, incentives | Config root |

### 10.5.3 Client & Group

| Aggregate root | Consistency boundary (excerpt) | Stream idea |
|----------------|---------------------------|-------------|
| **`Client`** | Person/NonPerson, status, office, identifiers, family, addresses | `Client-{id}` |
| **`Group`** | Membership, roles, status, hierarchy | `Group-{id}` |
| **`ClientTransfer`** | Office-transfer workflow | Process aggregate |
| **`ClientCharge`** | optional entity under client or small root | — |

**Not** in the client aggregate: loan and savings accounts (only read model “account summary”).

### 10.5.4 Further roots (brief)

| Context | Roots (excerpt) |
|---------|----------------|
| Accounting | `GLAccount`, `JournalEntry` (header+lines atomic), `GLClosure`, `ProductToGLAccountMapping`, `AccountingRule` |
| Organisation | `Office`, `Staff`, `WorkingDays`, `Holiday` |
| Branch | `Teller`, `Cashier` |
| Investor | Ownership transfer / External Asset Owner |
| Charge Catalog | `Charge` (definition) |
| Tax | `TaxComponent`, `TaxGroup` |
| COB | `COBRun` / partition lock (processual-technical) |

---

## 10.6 Mapping: bounded context ↔ Gradle module (as-is)

| Bounded context | Primary modules / packages | Module-boundary maturity |
|-----------------|---------------------------|-------------------|
| Loan Servicing | `fineract-loan`, `fineract-progressive-loan`, `fineract-working-capital-loan` | high (modules exist; couplings remain) |
| Loan Origination | `fineract-loan-origination` | medium |
| Savings & Deposits | `fineract-savings` | high |
| Accounting | `fineract-accounting` | high |
| Charge / Tax / Rates | `fineract-charge`, `fineract-tax`, `fineract-rates` | high |
| Investor | `fineract-investor` | high |
| Branch | `fineract-branch` | high |
| Documents | `fineract-document` | high |
| Reporting / MIX | `fineract-report`, `fineract-mix` | medium |
| COB | `fineract-cob` | high (orchestration) |
| Client & Group | `fineract-clients`, `fineract-group` (+ Client/Group entity residual in core) | high (modules exist; entity residual is kernel) |
| Organisation | `fineract-organisation` (+ Office/Staff/Holiday residual in core) | high |
| Share Accounts | `fineract-shares` (+ ShareProduct JPA residual in core) | high |
| Account Transfer | `fineract-accounttransfer` | high |
| Interop | `fineract-interoperation` | medium (ACL candidate) |
| IAM | `fineract-security` | high |
| Platform / SK | `fineract-core`, `fineract-command*`, `fineract-validation` | accepted leftover floor — do not slim by leftover peels |

---

## 10.7 Migration order (strangler)

Aligned with [ADR-020](decisions/ADR-020-event-sourcing-writes-pflicht.md) (ES0→ES4) and ADR-019 (D1–D4).

### Phase 0 – foundation (parallel)

| Measure | Reference |
|----------|--------|
| Event-store port, envelope, tenant, optimistic concurrency | ES0 |
| This chapter + glossary terms | D1 |
| Dependency rule (domain without REST/broker APIs) | ADR-017 |
| Shared kernel leftover floor (`fineract-core` as-is) | [core slices rank 31](15_osgi_bundle_refactoring_fineract-core-slices.md) — do not peel leftovers |

### Business priority order

| Prio | Context | Rationale |
|:----:|---------|------------|
| 1 | **Charge Catalog + Tax + Rates** | Small; ideal ES/hexagon pilot |
| 2 | **Client & Group** | Upstream of portfolio; modules exist (`fineract-clients` / `fineract-group`); entity residual stays in the kernel |
| 3 | **Organisation** | Upstream for client/COB/schedule |
| 4 | **Accounting as projection context** | Module exists; event consumption before loan ES cutover |
| 5 | **Savings & Deposits** | Clearer than loan; second ES core |
| 6 | **Loan Origination** | Greenfield-friendly; AI ACL |
| 7 | **Loan Servicing (standard)** | Highest complexity – only once client/product/GL ports are in place |
| 8 | **Progressive / Working Capital** | Behind stable loan ports |
| 9 | **Account Transfer, Investor, Interop, Branch** | Orchestration/ACL on stable ports |
| 10 | **COB** | Refactor steps behind domain ports |
| 11 | **Reporting / MIX / Documents** | Feed read side from published language |

### Strangler tactic per context

1. Draw module/package boundary and public application ports.  
2. ACL at the edge to legacy `JsonCommand`.  
3. Dual-write or catch-up only for **one** aggregate.  
4. Cutover: event stream = write SoT; table = projection.  
5. OSGi `-impl` bundle + Service Registry registration only once the port is stable ([ADR-022](decisions/ADR-022-osgi-api-impl-test-bundles-services.md)).

### Why not loan first?

- Largest god aggregate and most cross-context joins.  
- Without client upstream and GL projector, monolith coupling is continued in events.  
- ADR-020 recommends a pilot on a lean aggregate before the portfolio core.

---

## 10.8 Review checklist (context boundaries)

For new or touched code:

1. **Which bounded context?** (name from 10.2)  
2. **Which aggregate root?** Is only one root changed per TX?  
3. **Upstream dependency:** ID / snapshot / event – or illegal entity import?  
4. **Published language:** command and event name in ubiquitous language?  
5. **Accounting:** journal only as consequence/projection, not as a hidden business rule in the wrong context?  
6. **Read model:** query does not inflate the write aggregate (CQRS)?  
7. **ES plan:** new state-changing feature has an event path or a documented exception until cutover?

---

## 10.9 Open items (D3 / D4)

| Topic | Next step |
|-------|------------------|
| Aggregate canvas Loan / Savings / Client | → done in [11](11_aggregate_canvas.md) |
| Event catalog as-is → ES | → done in [12](12_event_catalog.md) |
| ArchUnit cross-context entity imports | → done in [13](13_archunit_bounded_context_rules.md) / `:fineract-architecture` |
| Import audit `portfolio.client.domain.Client` in Loan/Savings | ACL backlog and ArchUnit rules |
| Share Accounts & Account Transfer as own modules | Extraction from provider |
| Interop/AI ACL standard | Ports + fail-open/closed policy per use case (D4) |
| Product snapshot schema | Versioned VO structure for Loan/Savings opening |

---

## 10.10 References

| Document | Role |
|----------|--------|
| [ADR-019 Domain-Driven Design](decisions/ADR-019-domain-driven-design.md) | Strategic/tactical DDD north star |
| [ADR-017 Hexagonal Architecture](decisions/ADR-017-hexagonale-architektur.md) | Ports & adapters per context |
| [ADR-020 Event Sourcing](decisions/ADR-020-event-sourcing-writes-pflicht.md) | Write SoT per aggregate stream |
| [ADR-004 CQRS](decisions/ADR-004-cqrs-und-command-pipeline-beibehalten-modernisieren.md) | Commands vs. queries |
| [03 Building Blocks](03_building_block_view.md) | Physical modules |
| [06.15 DDD](06_crosscutting_concepts.md) | Cross-cutting summary |
| [09 Glossary](09_glossary.md) | Terms (BC, OHS, ACL, …) |
| [11 Aggregate Canvas](11_aggregate_canvas.md) | Loan, Savings, Client tactical |
| [12 Event Catalog](12_event_catalog.md) | Business events → ES |

---

*Navigation:* [README](README.md) · [11 Aggregate Canvas](11_aggregate_canvas.md) · [12 Event Catalog](12_event_catalog.md) · [08 Design Decisions](08_design_decisions.md)
