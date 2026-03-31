# MAOS — Adversarial Assurance Review v5.8

**Version:** 5.8.0  
**Date:** March 31, 2026  
**Status:** Companion — Assurance Review  
**Normative status:** Review and closure companion. This document does not define core guarantees; it evaluates how the architecture responds to adversarial concerns and where evidence is still needed.

---

## 1. Purpose

This review tracks how adversarial concerns map to the current MAOS architecture and where closure remains architectural, operational, or evidentiary rather than fully proven.

v5.8 is not a revolution in this document.  
It is an **assurance-cleanup step**:

- clearer profile boundaries,
- more normative defaults,
- more explicit residual risks,
- better articulation of repeated-ECS abuse,
- and better treatment of outbound A2A leakage.

---

## 2. Status vocabulary

| Status | Meaning |
|-------|---------|
| Open | no satisfactory architectural response yet |
| Architecturally mitigated | core design now contains a direct mitigation path |
| Implemented / evidence pending | design response exists, but deployment or test evidence is incomplete |
| Verified in deployment scope | evidence exists for the claimed deployment scope |
| Accepted residual risk | risk remains and is being consciously carried |

---

## 3. Updated finding-family closure table

| Finding family | v5.8 architectural response | Current status framing |
|---------------|-----------------------------|------------------------|
| commander compromise / approval spoofing | trusted display, trusted decision packets, signed commands, OOB confirmation, anti-fatigue controls | architecturally mitigated |
| dashboard deception | split observation surfaces, trusted minimal truth channel, trusted decision context | architecturally mitigated |
| common-cause failure in security path | diversity, fail-safe voter, explicit specification-integrity awareness | architecturally mitigated; evidence varies by implementation |
| startup / recovery-window weakness | stronger recovery baselines, ECS recurrence tracking, replay constraints | implemented / evidence pending |
| stale or partitioned distributed authority | explicit disconnect / rejoin rules, epoch checks, TTL defaults, freeze semantics | architecturally mitigated with residual risk |
| weakest-node in distributed worker class | bounded autonomy, TTLs, no privilege growth, MSS path | accepted residual risk unless deployment hardens further |
| semantic gap between deterministic and semantic layers | layered checks, aggregate monitoring, human escalation, confidence controls | accepted residual risk |
| outbound A2A information exposure | IFC checks plus aggregate monitoring of outbound A2A request volume | architecturally mitigated with residual risk |
| reasoning-state loss during security evaluation | explicit residual-risk treatment and restart discipline | accepted residual risk |
| immune abuse / quarantine-driven DoS | stronger residual-risk articulation, monitoring, and operational handling | accepted residual risk |
| host / physical compromise | profile-based isolation and hardware assumptions | accepted residual risk; strongly deployment-dependent |

---

## 4. What changed materially by v5.8

Compared with v5.5, the architecture story is now cleaner in these ways:

- Standard profile boundaries are stated more honestly.
- Aggregate-monitoring defaults are no longer purely illustrative.
- Capability TTL defaults make distributed revocation behavior easier to reason about.
- MAC profile content is more testable.
- Quarantine Stage 4 profile behavior is less ambiguous.
- Reasoning-state loss is treated more honestly as a security-relevant delay surface.
- A2A outbound requests are recognized as an information-exposure channel.
- Repeated ECS activity is treated less like isolated coincidence and more like a possible abuse pattern.

---

## 5. Remaining evidence gaps

The biggest remaining evidence gaps are still mostly implementation and operational proof gaps, not abstract design gaps:

- strong platform-specific isolation evidence,
- recovery-path validation under repeated stress,
- empirical verification of stale-epoch and token-TTL interaction,
- trustworthy operator use of trusted decision surfaces,
- and evidence that monitoring thresholds are tuned well enough to be useful without becoming noise.

---

## 6. Assurance posture

v5.8 supports a stronger assurance posture than v5.5, but the correct claim remains:

> the architecture is clearer,  
> the defaults are stronger,  
> the residual risks are stated more honestly,  
> but proof still requires implementation evidence.

---

## 7. Recommended next assurance steps

1. keep a finding-to-core-section traceability matrix,
2. keep a finding-to-test-evidence matrix,
3. validate repeated-ECS and recovery-abuse scenarios explicitly,
4. validate outbound A2A leakage monitoring under realistic workloads,
5. test trusted-decision-surface use with human factors in the loop,
6. continue red-teaming the specification, not only the code.

---

*MAOS Adversarial Assurance Review v5.8 — current assurance reference aligned to the more explicit defaults, profile boundaries, and residual-risk framing of Core v5.8.*  
