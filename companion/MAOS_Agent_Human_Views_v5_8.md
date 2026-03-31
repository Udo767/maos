# MAOS — Agent and Human Views v5.8

**Version:** 5.8.0  
**Date:** March 31, 2026  
**Status:** Companion — Governance, HMI, and Perspective Guide  
**Normative status:** Mixed. Core decision rights and trusted-interface baselines are defined in Core §43a–§43b and HACF sections. This document explains how those baselines feel and function in practice. The philosophical portions remain explicitly non-normative.

---

## 1. Why this document exists

MAOS lives between two worlds:

- the **human world** of meaning, responsibility, consequence, and legitimacy,
- and the **agent world** of permissions, confidence, bounded execution, and refusal.

v5.8 preserves the three-layer reading model:

1. **Operational View**
2. **Governance View**
3. **Philosophical Epilogue**

The main 5.7 change is greater precision around:

- trusted decision packets,
- profile-bounded quarantine authority,
- and the fact that human approval depends on trustworthy context, not just on a button.

---

# Part I — Operational View

## 2. The agent’s view

### 2.1 What an agent sees

An agent inside MAOS experiences:

- an identity, trust class, ring assignment, maturity level, and capabilities,
- a bounded execution environment,
- gateways it cannot bypass,
- mandatory rules it cannot negotiate with,
- and a trust path in which behavior matters more than time.

### 2.2 What an agent does not see

An agent does not see:

- the internal logic of the DSC,
- private workspace or memory of unrelated agents,
- the commander’s signing key,
- the whole system topology unless policy permits it,
- or raw provider channels beyond mediated surfaces.

### 2.3 Agent-side rights, operationalized

| Right concept | Operational meaning | Typical trigger | Exceptions / limits |
|--------------|---------------------|-----------------|--------------------|
| explanation | reason category for a block or denial | blocked request | may be limited if explanation would leak sensitive policy internals |
| appeal | denial may be routed to review or human escalation | contested high-impact denial | not a bypass of mandatory rules |
| graceful degradation | bounded chance to preserve state where safety permits | planned quarantine / shutdown | hard stop still allowed if safety requires it |
| resource floor | minimum support for bounded operation or safe shutdown | pressure / degradation | not a guarantee of full performance |
| transparency about self | bounded access to own trust / behavioral profile | self-model query | sensitive meta-analysis may remain policy-limited |

### 2.4 An agent’s worst day

The system may contain, isolate, or terminate the agent in order to protect the whole.  
That is not an architectural failure.  
It is one of the intended protective outcomes of a constitutional runtime.

---

## 3. The human’s operational view

### 3.1 What the commander sees

The commander interacts with MAOS through three classes of surface:

- **Dashboard** — richest operational surface
- **Trusted Display Path** — minimal root-of-truth state and trust channel
- **Trusted Decision / approval surfaces** — HACF dialogues, TSCA interactions, and OOB verification paths

The practical lesson remains:

> the most informative surface is not always the most trustworthy one.

### 3.2 Trusted decision packets

v5.8 adds more emphasis to the difference between:

- seeing that the system is degraded,
- and seeing enough trustworthy context to approve a consequential action.

A trusted decision packet should therefore contain, in human-usable form:

- requested action,
- risk level,
- relevant classification and scope,
- why the action is being requested,
- what changed since the last related approval,
- and which surface or channel is currently authoritative.

### 3.3 What the commander does not need to decide

The commander should not be burdened with:

- routine deterministic security verdicts,
- automatic low-stage quarantine containment,
- ordinary scheduling,
- ordinary rate limiting,
- or standard resource balancing.

The operating principle remains:

> automate the routine, escalate the consequential.

---

# Part II — Governance View

## 4. Decision rights matrix (derived)

| Decision type | Default authority | Human involvement |
|--------------|-------------------|------------------|
| low-risk bounded task execution | agent + MAOS Core | usually inform-level only |
| routine security enforcement | MAOS Core | none unless escalated |
| quarantine stage 1–2 containment | security pipeline | typically automatic |
| quarantine stage 3 hard isolation | MAOS Core / security pipeline | auditable, usually not pre-approved |
| quarantine stage 4 elimination in Standard | TSCA may act autonomously within profile rules and incident budget | auditable after the fact; runtime policy may not soften core profile behavior |
| quarantine stage 4 elimination in Hardened / Isolated | commander-confirmed path | explicit approval required |
| irreversible external effect | agent request + governed approval path | approval depends on policy and risk class |
| profile / DSC / commander-key changes | authorized humans only | highest scrutiny |
| constitutional mandatory-rule change | constitutional process only | not a normal runtime override |

### 4.1 Clarification of human authority

The human is the **highest operational authority within the system’s mandatory constraints**.

That means:

- the human may approve, deny, redirect, or halt many consequential actions,
- but the human is **not** a runtime shortcut around constitutional mandatory rules.

### 4.2 Why profile nuance matters

v5.8 is more explicit that not every profile has the same governance strength.

- **Standard** favors usability and local control, with weaker ceremony and lighter assurance.
- **Hardened** introduces stronger procedural expectations.
- **Isolated** expects the strongest approval, ceremony, and operating discipline.

That difference should be visible to operators, not hidden in background text.

---

## 5. Worst-day scenario, restructured

### 5.1 What the human sees
- trusted display shows degraded, emergency, or frozen state
- dashboard shows quarantines, alerts, and constrained operations
- trusted decision surfaces show whether action is requestable, blocked, or must be reviewed

### 5.2 What is actually true
- one or more trust assumptions are unhealthy,
- autonomy is being reduced before safety is lost,
- the system is prioritizing containment over convenience.

### 5.3 What the system blocks automatically
- privilege growth,
- unsafe side effects,
- stale-epoch distributed actions,
- actions exceeding current confidence or policy bounds.

### 5.4 What requires explicit approval
- severe quarantine outcomes in stronger profiles,
- profile and key-management changes,
- certain irreversible external effects,
- exceptional recovery or override-class decisions.

### 5.5 What gets audited
- the evidence shown,
- the recommendation made,
- the human decision,
- the trusted-display or trusted-decision snapshot,
- channel-integrity results,
- and any OOB or second-factor confirmation.

---

## 6. HMI security reminders

A trustworthy human interface depends on more than a good dashboard.

Operationally important safeguards include:

- Trusted Display Path,
- Trusted Decision Packets,
- signed commander commands,
- replay protection,
- OOB verification for high-risk actions,
- clear differentiation between observation surfaces,
- anti-fatigue and anti-coercion controls for the most sensitive actions.

---

# Part III — Philosophical Epilogue (non-normative)

The human, the agent, and the constitutional core form a principled triad:

- the human contributes meaning, legitimacy, and accountability,
- the agent contributes speed, pattern processing, and bounded execution,
- the core contributes law, memory, structure, and refusal.

MAOS works best when none of these three illegitimately replaces the others.

---

*MAOS Agent and Human Views v5.8 — governance and HMI companion aligned to the more explicit decision and profile logic of Core v5.8.*  
