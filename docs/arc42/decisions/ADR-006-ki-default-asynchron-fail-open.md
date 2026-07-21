# ADR-006 – AI default asynchronous & fail-open

| | |
|--|--|
| **Status** | accepted |
| **Qualities** | Performance, Reliability; trade-off vs. strict auto-decision |

### Context

External inference can take 100 ms to several seconds and can fail. Sync on the default write path endangers p95 and availability ([Q-PERF-1](../07_quality_attributes.md), [Q-REL-2](../07_quality_attributes.md)).

### Decision

| Aspect | Default | Exception |
|--------|---------|-----------|
| Invocation time | **Async** after domain event / after commit | Sync only as a configured **policy gate** |
| On timeout/5xx | **Fail-open** (write remains successful) | **Fail-closed** only when product/regulatory rules force it |
| Postings | AI **never silently** changes balances | Enrichment only, or explicit business rule |

### Alternatives

| Option | Assessment |
|--------|------------|
| Always sync before persistence | High correctness of the “AI decision”, poor latency/availability |
| Always fail-closed | Safe for auto-reject products, risky for ops |
| Fire-and-forget without persisting the score | Insufficient auditability |

### Consequences

- **+** Write SLO and COB decoupled from vendor latency  
- **+** Clear policy matrix per product possible  
- **−** Score may only appear with delay (eventual enrichment)  
- **−** Product teams must deliberately enable fail-closed  

---

*Back to overview:* [08 Design Decisions](../08_design_decisions.md)
