# MAOS — Companion Specification v5.8

**Version:** 5.8.0  
**Date:** March 31, 2026  
**Status:** Companion — Operational Reference  
**Normative status:** Mixed. This document operationalizes the minimum baselines defined in MAOS Technical Specification v5.8. It may provide defaults, runbooks, and deployment guidance, but it may not weaken the core.

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 1. Purpose and relationship to the core specification

This document provides deployment guidance, operator runbooks, reference configurations, and explanatory appendices for MAOS.

The following topics are now treated here as **derived operational baselines** because their minimum requirements are defined in the core:

- Core §5.2.2 — Standard Profile Security Boundaries
- Core §5.3 — Operational Governance Baselines
- Core §9.3 — Capability Token Lifecycle and TTL defaults
- Core §10.3 — Profile-Specific MAC Policy Content
- Core §14.1 — Reasoning-state loss note and micro-checkpoint recommendation
- Core §37.2 — Residual Risks
- Core §38.6, §38.11, §38.12 — ECS and resilience baselines
- Core §43a–§43b — Trusted Human Interface and Human Oversight
- Core §49.11 — Aggregate Monitoring and outbound A2A monitoring

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 2. How to read this document

Sections are tagged as:

- **Normative Procedure (derived):** directly operationalizes a core baseline
- **Recommended Practice:** strong recommendation, not a constitutional minimum
- **Deployment Example:** reference topology or profile example
- **Conceptual Reference:** explanatory material, not normative

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 3. Derived operational procedures

## 3.1 OP-1 Data lifecycle and deletion operations
**Type:** Normative Procedure (derived)  
**Core source:** §5.3.1

### 3.1.1 Operational rule

Core retention and deletion minimums are binding.  
Deployments may be stricter, but not weaker.

### 3.1.2 Operational data classes

For operational handling, retained information should be divided into:

1. **Source data** — original user inputs, task payloads, imported records  
2. **Execution records** — audit logs, checkpoints, confidence records, behavioral fingerprints  
3. **Derived insights** — summaries, patterns, Wisdom Pool entries  
4. **Forensic records** — quarantined agent state, incident packages, breach evidence

### 3.1.3 Wisdom Pool handling

v5.8 keeps the stricter handling logic introduced after v5.3:

- raw submissions inherit source retention and IFC class,
- reconstructable derived material follows the highest-source retention class,
- only irreversibly aggregated or anonymized insights may be retained longer,
- legal hold overrides scheduled deletion,
- deletion events are auditable even when deleted payloads are not retained.

### 3.1.4 DSAR / erasure workflow

A deployment processing personal data should publish a workflow for:

1. request intake,
2. identity verification,
3. scope identification,
4. legal-hold check,
5. deletion or lawful refusal,
6. audit recording,
7. downstream deletion propagation,
8. requester notification.

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 3.2 OP-2 Commander key ceremony, rotation, and recovery
**Type:** Normative Procedure (derived)  
**Core source:** §5.3.2

### 3.2.1 Minimum ceremony model

For Hardened and Isolated profiles, the recommended record includes:

- participants and roles,
- environment verification result,
- hardware token / HSM identifier,
- key generation time,
- witness signatures,
- escrow model if allowed,
- initial transparency entry,
- signed closure record.

### 3.2.2 Rotation runbook

1. generate replacement key,
2. register new public identity,
3. open grace window,
4. validate acceptance of the new signing chain,
5. revoke old key through the Revocation Epoch path,
6. verify command path with the new key,
7. close old-key acceptance.

### 3.2.3 Recovery and succession

Recovery is a high-risk operation.  
It should be treated as a governance event, not as an ordinary convenience operation.

For stronger profiles, recommended additional safeguards include:

- independent witness verification,
- separate recovery attestation,
- temporary narrowing of high-risk capabilities during grace windows,
- and explicit post-recovery review.

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 3.3 OP-3 Incident response and evidence handling
**Type:** Normative Procedure (derived)  
**Core source:** §5.3.3

### 3.3.1 Minimum runbook fields

Each incident record should include:

- incident identifier,
- severity,
- detection source,
- affected components,
- quarantine stage,
- trusted decision / display snapshot,
- current degraded mode,
- commander involvement status,
- evidence package location,
- and whether ECS or recovery controls were involved.

### 3.3.2 Minimum runbooks

Deployments should have explicit runbooks for at least:

- SSE outage,
- DSC integrity failure,
- suspected commander-key compromise,
- repeated quarantine cascade,
- partitioned distributed operation,
- replay from WAL / rollback after failed update,
- dashboard compromise with trusted-display divergence,
- repeated ECS cycling,
- outbound A2A leakage threshold breach.

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 3.4 OP-4 Standard profile boundary disclosure
**Type:** Normative Procedure (derived)  
**Core source:** §5.2.2

Every deployment or product surface exposing a Standard profile should present a short boundary notice covering at least:

- isolation is lighter than Hardened / Isolated,
- DSC runs without redundancy,
- commander ceremony controls are simplified,
- host hardening controls are optional or absent,
- and the profile is intended for development, experimentation, personal productivity, or low-assurance use cases.

This disclosure should appear:

- at first setup,
- when switching into Standard from a stronger profile,
- and in deployment documentation.

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 3.5 OP-5 Token TTL and renewal handling
**Type:** Normative Procedure (derived)  
**Core source:** §9.3

### 3.5.1 Recommended defaults

Operational defaults mirror the core baseline:

- Ring 2: 60 minutes
- Ring 3: 15 minutes
- External A2A: 5 minutes

### 3.5.2 Renewal guidance

Renewal should be transparent when permissions remain valid.  
Renewal must not be used to bypass revocation.

### 3.5.3 Distribution note

In distributed deployments, cached tokens should be treated as invalid once the local Revocation Epoch becomes stale beyond the permitted delta, regardless of nominal TTL.

### 3.5.4 Operator alerts

Alert when:

- TTLs exceed the recommended baseline by more than 4x,
- renewal failure rates rise,
- token refresh continues during stale-epoch conditions,
- or an external A2A token is renewed excessively without corresponding workload justification.

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 3.6 OP-6 Aggregate monitoring and calibration
**Type:** Normative Procedure (derived)  
**Core source:** §49.11

### 3.6.1 Baseline thresholds

The following are the v5.8 normative default thresholds unless deployments override them:

- 100 MB total outbound data volume in 24 hours
- 50 unique external recipients in 7 days
- 500 external API calls in 24 hours
- 10 IFC declassification events in 24 hours

For any single external A2A agent, the recommended default threshold is 50% of the general outbound threshold.

### 3.6.2 Calibration method

Before production tuning, deployments should perform a 30-day observation period:

1. monitoring only,
2. record threshold crossings,
3. measure natural baseline,
4. calculate the 95th percentile,
5. set production thresholds near 3x that percentile unless policy or regulation requires stricter values.

### 3.6.3 What aggregate monitoring does *not* solve

Aggregate monitoring is good at finding **volume-based** or **pattern-based** exfiltration.  
It does not close the full semantic gap.  
That remains a residual risk and should be documented as such for operators.

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 3.7 OP-7 Reasoning-state loss handling
**Type:** Recommended Practice  
**Core source:** §14.1, §37.2

The core now states explicitly that loss of uncommitted reasoning state can have security consequences when the lost state includes in-progress security evaluation.

Operational guidance:

- security-sensitive evaluators should persist resumable markers more often than the general checkpoint cadence,
- Hardened and Isolated deployments should prefer a 60-second micro-checkpoint target for security-critical evaluation state where the platform supports it,
- after crash recovery, any previously in-progress security decision should be restarted from a known-valid state rather than assumed complete.

This is a recommendation, not a separate constitutional mechanism.

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 4. Profile-specific MAC policy interpretation
**Type:** Recommended Practice  
**Core source:** §10.3

The core now defines minimum MAC content per profile. This companion translates that into operator expectations.

| Profile | Minimum MAC meaning in operations |
|--------|-----------------------------------|
| Standard | workspace-bounded file writes, domain-whitelist network access, limited host-strength assumptions |
| Hardened | stricter cross-ring IFC enforcement, message/content scrutiny, audited writes, tighter outbound network controls |
| Isolated | strongest message protection, explicit gateway routing between domains, strong path authentication, code-signing and host hardening expectations |

Deployments may add stricter domain-specific rules, but should never describe a weaker policy as the same declared profile.

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 5. Resilience and ECS operations
**Type:** Recommended Practice  
**Core source:** §38.6, §38.11, §38.12

### 5.1 ECS cumulative tracking

v5.8 adds longer-window ECS-abuse awareness. Operators should monitor not only 24-hour frequency but also cumulative 7-day recurrence.

Recommended response:

- flag repeated ECS patterns in audit and monitoring systems,
- shorten self-recovery wait windows for repeated events,
- and in stronger profiles require commander acknowledgement before repeated automated recovery continues.

### 5.2 Recovery-path discipline

Recovery windows should be treated as constrained states:

- no casual policy broadening,
- no silent privilege growth,
- no unreviewed override of stale state,
- and no assumption that in-progress semantic evaluation survives crash unless explicitly persisted.

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 6. Deployment blueprints

## 6.1 Developer desktop
**Type:** Deployment Example

Use when iteration speed is primary.

- profile: Standard
- isolation: lightweight
- commander auth: strong local user auth
- note: boundary disclosure should be prominent
- recommended additions: local backup, signed manifests, dev/test separation

## 6.2 Hardened enterprise node
**Type:** Deployment Example

Use when safety, auditability, and recoverability matter materially.

- profile: Hardened
- isolation: process sandbox or stronger
- commander auth: hardware-backed signing strongly recommended
- monitoring: aggregate monitoring enabled and calibrated
- additional controls: SIEM integration, backup verification, recovery drills

## 6.3 Isolated critical deployment
**Type:** Deployment Example

Use for high-consequence domains.

- profile: Isolated
- isolation: strong boundary, preferably microVM or equivalent
- commander auth: formal ceremony, hardware-backed, OOB approval
- monitoring: strongest thresholds and manual review of exceptional events
- additional controls: physical trusted indicator, drill-based recovery validation

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 7. Conceptual appendix — MAOS as a living organism
**Type:** Conceptual Reference

The biological metaphor is still useful for explanation, but it is not the source of normative guarantees.

| Organ / system | MAOS component |
|---------------|----------------|
| Heart | Deterministic Security Core + fail-safe verdict path |
| Immune system | SSE + Quarantine + Danger Signals + Vaccination |
| Skeleton | Commit Layer + Audit Trail + structural runtime |
| Skin | Sentry + Gateways + A2A Security Gateway |
| Nerves | Message Router + signals + event flow |
| Emergency room | TSCA + recovery and ECS workflows |
| Conscious collaboration | Commander + HACF + trusted decision path |

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


## 8. Document map

The role split in v5.8 is now clearer:

- **Core** defines minimums, defaults where necessary, and constitutional boundaries.
- **This document** explains how to operate them.
- **Other companions** visualize, assess, critique, or contextualize them.

---

## Publication Note

MAOS is a living reference architecture for secure multi-agent systems. It is published as a public discussion base, architectural framework, and development substrate. The project welcomes critique, adversarial review, implementation feedback, and conformance work. See the core specification for the full publication note.


*MAOS Companion Specification v5.8 — operationalization of core baselines, defaults, and profile boundaries.*  
