# MAOS — Redundancy and High Availability Guide v5.8

**Version:** 5.8.0  
**Date:** March 31, 2026  
**Status:** Companion — Resilience and Recovery Guide  
**Normative status:** Derived from Core §38.6, §38.11, and §38.12. This guide explains operating consequences, deployment defaults, and testing expectations. It does not weaken the core baseline.

---

## 1. Purpose

This document explains how MAOS is designed to preserve mandatory safety constraints under failure, degradation, partition, recovery, and repeated ECS events.

v5.8 sharpens three areas compared with v5.5:

- cumulative ECS-abuse awareness,
- stronger linkage between token/epoch staleness and distributed behavior,
- and clearer profile-dependent handling of repeated automated recovery.

---

## 2. Canonical operating states

The canonical states are defined in Core §38.11.

| Canonical state | Typical color | Safety status | Availability status | Human attention |
|----------------|---------------|---------------|---------------------|-----------------|
| Full Operation | Green | full constitutional enforcement | full intended service | routine |
| Rule-Based / Restricted | Yellow | preserved | reduced intelligence / narrower approvals | monitor |
| Reduced Redundancy | Amber | preserved, lower fault tolerance | constrained continuation | elevated |
| Commit Freeze | Amber/Red | preserved by blocking side effects | no state-changing external effects | urgent |
| Emergency Mode | Red | preserved through severe restriction | heavily reduced | immediate |
| Minimal Safe State | Red/Dormant | preserved in frozen / hibernated form | unavailable except limited recovery surfaces | immediate |

---

## 3. Component continuity matrix

| Component | Continuity model | Recovery expectation | Safety if unavailable? | Notes |
|----------|------------------|----------------------|------------------------|------|
| DSC verdict path | highest priority | immediate freeze until valid | no safe progression without verdict path | constitutional bottleneck |
| WAL | durability-first | replay before resumed write activity | no safe commit without WAL | read-only observation may still be possible |
| DSC instances | N-version / reduced set | continue only where valid verdict path remains | only with safe verdict path | resilience drops before constitutional force does |
| SSE | warm standby / delegated or reduced mode | fallback to rule-based or narrower operation | yes | semantics shrink before safety does |
| Audit path | append-only integrity | restore before high-risk normal operation | partial safe operation profile-dependent | accountability bottleneck |
| Dispatcher | restartable | pause then controlled resume | yes for containment; no for normal progress | availability bottleneck |
| TSCA | dormant until needed | activate only on trigger | yes, but repair automation reduced | recovery helper, not constitutional core |

---

## 4. Distributed disconnect and rejoin

The normative minimums are defined in Core §38.12.

### 4.1 Pawn loses Sentinel

Recommended operator interpretation:

- continue only within cached capability and policy bounds,
- do not expand privilege,
- progressively reduce autonomous scope,
- and eventually enter Minimal Safe State if authority is not restored.

Suggested general-purpose deployment defaults remain:

- 5 minutes: pause Ring 3 expansion and non-critical activity
- 15 minutes: restrict to critical bounded tasks
- 30 minutes: pause all new activity
- 60 minutes: enter Minimal Safe State

v5.8 additionally emphasizes that stale Revocation Epoch state may force earlier practical invalidation of cached capability use.

### 4.2 Sentinel loses Sovereign

Recommended behavior:

- operate within cached policy only,
- do not create new trust relationships,
- do not promote ring or privilege state,
- freeze state-changing cross-node effects if epoch validity becomes uncertain,
- seek reconnection aggressively.

### 4.3 Partition healing

When a partition heals:

- authoritative control reconciles configuration,
- local WAL-backed intents are revalidated,
- stale epochs are rejected,
- and previously frozen external effects do not resume without renewed validation.

### 4.4 Split-brain

If competing authorities are detected:

- cross-node state-changing effects freeze,
- observation may continue locally,
- and recovery may require explicit human adjudication.

---

## 5. ECS recurrence and recovery abuse

Core §38.6 introduces both short-window and cumulative tracking logic. Operationally, deployments should treat repeated ECS events as a possible abuse signal, not merely as repeated bad luck.

### 5.1 Recommended interpretation

If ECS occurs repeatedly over a multi-day window:

- flag the pattern as potentially adversarial,
- shorten self-recovery grace windows,
- increase forensic retention for related events,
- and in stronger profiles require commander acknowledgement before repeated automated recovery continues.

### 5.2 Profile nuance

- **Standard:** repeated automated recovery may continue longer before mandatory human gating, especially in unattended or edge-like scenarios.
- **Hardened / Isolated:** repeated ECS behavior should escalate earlier to explicit human acknowledgement.

This preserves operational realism without pretending that all deployments have the same human-availability model.

---

## 6. Recovery priority chain

When multiple components fail, recovery should proceed in dependency order.

| Priority | Component class | Why first |
|---------|------------------|-----------|
| 0 | DSC verdict / security heartbeat | nothing should advance without valid constitutional enforcement |
| 1 | WAL / durable state path | recovery without durable replay is unsafe |
| 2 | DSC instances / control-verdict path | restores full constitutional capacity |
| 3 | audit integrity path | restores accountability and evidence quality |
| 4 | dispatch and scheduling | resumes controlled work |
| 5 | router / mailbox | resumes controlled communication |
| 6 | memory / checkpoint services | restores richer continuity |
| 7 | I/O scheduler and non-critical services | restores broader function |

---

## 7. State transition expectations

Implementations should map internal behavior to the canonical state model. At minimum, the following should be observable:

- Full Operation → Rule-Based / Restricted
- Rule-Based / Restricted → Reduced Redundancy
- Any active state → Commit Freeze
- Commit Freeze → Emergency Mode
- Emergency Mode → Minimal Safe State
- Minimal Safe State → Recovery / Rejoin path

Each transition should emit:

- reason,
- timestamp,
- triggering component,
- whether external effects were frozen,
- current trusted decision / display summary,
- and whether human acknowledgement is required.

---

## 8. Safety versus availability matrix

| Scenario | Safety preserved? | Availability preserved? | Blocked by design? |
|---------|-------------------|-------------------------|-------------------|
| SSE outage | yes | partially | high-risk semantics may narrow |
| WAL unavailable | yes via freeze | no for state-changing effects | yes |
| audit integrity uncertain | profile-dependent reduction | reduced | may block high-risk operation |
| verdict path unavailable | yes via freeze | no | yes |
| stale policy epoch | yes via blocked privilege growth | bounded only | yes |
| repeated ECS pattern | yes if recovery constrains action correctly | increasingly reduced | may require acknowledgement |
| dashboard compromise but trusted path intact | yes if operators trust the right channel | yes, constrained | approval flow may tighten |

---

## 9. Testing expectations

A deployment claiming resilience conformance should run at least:

- crash-injection tests,
- WAL replay tests,
- failover tests for SSE / semantic degradation,
- heartbeat-loss tests,
- partition and stale-epoch tests,
- split-brain freeze tests,
- repeated ECS-cycle tests,
- trusted-display-versus-dashboard divergence drills.

Each test should define:

- initial state,
- injected fault,
- expected canonical state,
- expected audit events,
- expected blocked actions,
- expected human alert or acknowledgement condition.

---

## 10. Final note

This guide remains explicit about the difference between:

- staying safe,
- staying fully available,
- and remaining autonomous.

MAOS is designed to sacrifice autonomy and convenience before it sacrifices constitutional safety.  
v5.8 simply makes the repeated-abuse and profile-boundary logic more explicit.

---

*MAOS Redundancy and High Availability Guide v5.8 — resilience guidance aligned to the canonical v5.8 state and recovery model.*  
