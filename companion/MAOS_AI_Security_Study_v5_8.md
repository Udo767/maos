# MAOS — AI Security Study v5.8

**Version:** 5.8.0  
**Date:** March 31, 2026  
**Status:** Companion — Assurance and Comparative Security Study  
**Normative status:** This document extends the concise baseline in Core §37 and the conformance scope in Core §51. It is not, by itself, a certification claim.

---

## 1. Purpose

This study has three goals:

1. explain how MAOS maps to major agentic-AI threat classes,
2. show where MAOS differs structurally from orchestration-only systems,
3. describe residual risk and assurance expectations honestly enough to guide implementation.

v5.8 adds more precision in four areas:

- profile-bounded guarantees,
- outbound A2A leakage risk,
- reasoning-state loss as a security concern,
- and immune-abuse / static-threshold residual risk.

---

## 2. Claim-status model

Every major claim in this document should be read using one of four statuses:

- **Addressed** — architecture contains a direct mitigation path
- **Partially addressed** — meaningful mitigation exists, but material residual risk remains
- **Mitigated with residual risk** — strong controls exist, but the class remains meaningfully attackable
- **Planned / evidence pending** — architectural intent exists, but implementation or validation evidence is incomplete

---

## 3. Method and scope

This study combines:

- architecture mapping from the MAOS core,
- assurance reasoning from companion documents,
- comparison with orchestration-focused agent systems,
- and alignment against widely used threat taxonomies and control families.

It is a **design-assurance companion**, not an external audit certificate.

---

## 4. Threat-to-control extension

| Threat class | Primary MAOS controls | Status | Notes |
|-------------|-----------------------|--------|------|
| prompt injection / semantic manipulation | deterministic pre-filtering, prompt anchoring, Cognitive Cell Barrier, semantic scanning, A2A boundary scanning | mitigated with residual risk | semantic attacks remain possible within allowed capability envelopes |
| unsafe side effects | Commit Layer, capability model, IFC, declassification gates | addressed | strongest on state-changing paths |
| excessive agency / privilege escalation | capabilities, rings, mandatory rules, HACF floors | addressed | stale-policy and distributed cases remain operationally sensitive |
| supply-chain compromise | signed identities, transparency logging, controlled onboarding, update protocol | partially addressed | maturity and operator discipline matter |
| model integrity degradation | integrity verification, behavioral baselines, provider separation | partially addressed | especially sensitive with remote model providers |
| data exfiltration | IFC, declassification, aggregate monitoring, A2A outbound leakage tracking, auditability | mitigated with residual risk | slow semantic exfiltration remains possible |
| operator / commander compromise | hardware-backed signing, OOB confirmation, trusted display, trusted decision packets, anti-fatigue controls | mitigated with residual risk | context deception and coercion remain real risks |
| distributed weakest-node / stale-epoch failure | TTL defaults, epoch checks, disconnect restrictions, revalidation, bounded autonomy | partially addressed | weakest-node effects still matter materially |
| dashboard or approval-surface deception | split observation surfaces, trusted path, signed approvals | addressed | depends on humans trusting the correct channel |
| reasoning-state loss during security evaluation | WAL + checkpointing + restart discipline + optional micro-checkpointing | partially addressed | evaluation delay remains possible after crash |
| immune abuse / quarantine-driven DoS | rate limits, audit, quarantine logic, operator review, static threshold awareness | mitigated with residual risk | static thresholds can still be gamed over time |

---

## 5. OWASP-style agentic risk coverage

| Risk family | MAOS mechanisms | Status | Scope note |
|------------|-----------------|--------|-----------|
| prompt injection | deterministic filters, anchors, boundary scanning, semantic review | mitigated with residual risk | not a proof of semantic invulnerability |
| insecure output handling | IFC + Commit controls | addressed | strongest on side-effecting actions |
| training / model poisoning | integrity checks and behavioral baselines | partially addressed | provider and supply-chain dependent |
| denial of service | rate limiting, budgets, quarantine controls, recovery gating | partially addressed | broader infrastructure DoS remains bigger than MAOS alone |
| supply chain | PKI, transparency, signed updates, manifest review | partially addressed | depends on operational discipline |
| sensitive info disclosure | IFC, declassification, logging, aggregate monitoring, human oversight | mitigated with residual risk | long-horizon semantic leakage still matters |
| insecure plugin / tool design | onboarding controls, workspace isolation, policy mediation | addressed | strongest with tightly scoped tool surfaces |
| excessive agency | capabilities, mandatory rules, HACF floors | addressed | governance still matters |
| overreliance | confidence propagation, HACF, human oversight | partially addressed | human misuse cannot be engineered away completely |
| model theft / misuse | pod isolation, mediated access, separation of control paths | partially addressed | deployment realities remain important |

---

## 6. Comparison with orchestration-focused systems

| Capability family | Typical orchestration frameworks | MAOS position |
|------------------|----------------------------------|---------------|
| multi-agent coordination | often strong | strong |
| graph / workflow logic | often strong | compatible but not the main differentiator |
| tool integration | common | common |
| protection rings | uncommon | core differentiator |
| capability-based privilege model | uncommon | core differentiator |
| deterministic pre-execution enforcement | uncommon | core differentiator |
| IFC / declassification | uncommon | core differentiator |
| explicit degradation and safe-freeze model | uncommon | strong differentiator |
| trusted human approval path | uncommon | strong differentiator |
| distributed stale-policy semantics | usually weakly specified | explicitly modeled |

---

## 7. A2A boundary analysis

MAOS treats A2A as a first-class security boundary.

| A2A risk pattern | MAOS control family | Status |
|------------------|---------------------|--------|
| forged or spoofed remote identity | signed identity + admission / trust decision | addressed |
| unbounded external token scope or lifetime | narrow scopes + TTL defaults | addressed |
| implicit consent bypass | HACF floors + policy mediation | addressed |
| cascading semantic corruption | confidence propagation + boundary scanning | mitigated with residual risk |
| prompt injection via chains | gateway scanning + deterministic checks | mitigated with residual risk |
| coarse-grained external trust | per-operation capabilities | addressed |
| query leakage to external agents | outbound IFC checks + aggregate monitoring | mitigated with residual risk |
| registry flooding or registry abuse | admission control + rate limiting + registry policy | partially addressed |

---

## 8. Standards and control-family alignment

The core provides the concise baseline. This companion expands interpretation without claiming automatic certification.

| Standard / control family | MAOS alignment type | What that means in v5.8 |
|---------------------------|--------------------|--------------------------|
| safety-critical design discipline | design alignment target | redundancy, fail-safe defaults, explicit degraded operation |
| high-assurance software discipline | design alignment target | traceability, configuration control, and reviewability are goals, not a certification claim |
| PQC migration families | design alignment target | crypto and identity design aim at post-quantum-ready operation |
| AI governance / risk frameworks | design alignment target | oversight, logging, and controllability are architectural concerns |
| agentic-AI attack taxonomies | coverage mapping | useful for threat reasoning, not proof of immunity |

---

## 9. Residual-risk register

The following residual risks remain important:

- semantically harmful behavior within granted authority,
- slow exfiltration through allowed channels,
- context manipulation of authorized humans,
- weakest-node effects in large distributed systems,
- implementation gaps between architecture and deployment,
- reasoning-state loss delaying security decisions after crash,
- and immune-threshold abuse or quarantine-driven denial patterns.

---

## 10. Evidence posture

v5.8 improves claim precision, but the strongest remaining challenge is still evidence.

The critical question is not only “does the architecture mention a control?”  
It is:

- is it implemented,
- is it tested,
- is it conformance-checkable,
- and does it work under stress?

That is why v5.8 should be read as a stronger architecture-and-assurance baseline, not as a finished proof artifact.

---

*MAOS AI Security Study v5.8 — assurance companion, comparative study, and residual-risk explanation aligned to Core v5.8.*  
