# MAOS — Multi-Agent Operating System
## Executive Summary v5.8

**Version:** 5.8.0  
**Date:** March 31, 2026  
**Status:** Companion — Decision Document  
**Normative status:** Non-normative summary. Normative guarantees and minimum requirements are defined in the MAOS Technical Specification v5.8.

---

## Purpose of this document

This document explains MAOS for decision-makers, architects, implementers, and reviewers.  
It is intended to be readable and concise. It does not define independent guarantees.

The most relevant core anchors for this summary are now:

- Core §5.2.2 — Standard Profile Security Boundaries
- Core §5.3 — Operational Governance Baselines
- Core §9.3 — Capability Token Lifecycle and TTL defaults
- Core §10.3 — Profile-Specific MAC Policy Content
- Core §37.2 — Known Residual Risks
- Core §38.6, §38.11, §38.12 — ECS, degradation, disconnect, and recovery
- Core §43a–§43b — Trusted Human Interface and Human Oversight
- Core §49.11 — Aggregate Monitoring and A2A outbound leakage monitoring

---

## The problem

Most agent frameworks solve orchestration.  
They do not solve operating-system-grade safety, privilege control, recovery, and human-governed action in real environments.

As agentic systems gain autonomy, the core risks become:

- unauthorized side effects,
- privilege escalation,
- unsafe cross-agent influence,
- hidden data exfiltration,
- stale or partitioned distributed behavior,
- recovery-path abuse,
- and manipulated approval surfaces.

---

## The MAOS approach

MAOS treats agents like processes inside a secure operating environment:

- they run in bounded execution contexts,
- receive explicit capabilities,
- operate across trust rings,
- and cannot perform state-changing external actions without passing through controlled enforcement paths.

MAOS separates **reasoning** from **side effects**:

- agents may reason in parallel,
- observation and read paths remain controlled,
- but state-changing effects pass through the Commit Layer and associated controls,
- and high-risk decisions may require human review through HACF.

---

## What matters most in v5.8

v5.8 is not a feature-expansion release.  
It is a **precision, defaults, and conformance-hardening release**.

The most important clarifications are:

### 1. Standard profile is now explicitly bounded

Standard remains useful and meaningful. It still provides:

- constitutional Mandatory Rules,
- capability-based access control,
- Commit Layer protection,
- and Write-Ahead Logging.

But v5.8 states much more clearly that Standard does **not** provide the same assurance class as Hardened or Isolated. In particular, it does not imply strong isolation, DSC redundancy, formal commander ceremony, or mandatory host hardening.

### 2. Defaults are now more implementable

v5.8 adds clearer defaults for:

- aggregate monitoring,
- capability token TTLs,
- profile-specific MAC policy minima,
- and outbound A2A query monitoring.

This matters because secure architecture without default values is often difficult to implement consistently.

### 3. Residual risks are stated more honestly

v5.8 keeps a strong security posture but states more clearly that some risks remain materially real, including:

- semantically wrong but formally allowed actions,
- reasoning-state loss between checkpoints,
- static-threshold immune abuse risks,
- weakest-node effects in distributed deployments,
- and implementation gaps between architecture and deployment.

### 4. Human oversight is more precisely bounded

The commander remains the highest operational authority within the system’s mandatory constraints.  
v5.8 preserves that principle while sharpening the relationship between approval, Quarantine Stage 4 behavior, profile rules, and trusted decision surfaces.

---

## Guarantee-scope snapshot

| Topic | Core baseline exists? | Profile-dependent? | Companion role |
|------|------------------------|-------------------|----------------|
| constitutional mandatory rules | yes | no | explain implications |
| standard profile security limits | yes | yes | clarify what is *not* provided |
| token TTL defaults | yes | yes | operationalize renewal and logging |
| profile-specific MAC minimum content | yes | yes | deployment guidance |
| ECS and recovery abuse handling | yes | yes | runbooks and testing |
| A2A outbound leakage monitoring | yes | yes | explain operational thresholds |
| human oversight and trusted decision path | yes | yes | governance explanation |

---

## Residual-risk snapshot

MAOS is designed to reduce, contain, and govern agentic risk.  
It does not eliminate all risk.

The most important residual risks remain:

- semantically harmful behavior within granted authority,
- operator or governance failure,
- compromise or manipulation of human approval context,
- weakest-node effects in distributed environments,
- slow data exposure through allowed channels,
- and the difference between specified architecture and verified implementation.

---

## Why publish MAOS at all

MAOS is intended as a **living reference architecture**.

It is not published merely to inspire.  
It is published to help secure agentic systems become:

- more discussable,
- more criticizable,
- more testable,
- and eventually more buildable.

That means MAOS should be read in three layers:

1. **architectural direction**
2. **normative baseline**
3. **implementation pathway**

---

## Philosophical note

MAOS still uses the “living organism” metaphor because it is useful for explanation.  
But v5.8 keeps the distinction clearer than ever:

- metaphor explains,
- the core specifies,
- companion documents operationalize,
- assurance documents evaluate.

---

*MAOS Executive Summary v5.8 — concise, non-normative overview aligned to Core v5.8.*  
