# MAOS — Multi-Agent Operating System

## Architecture Overview

**Version:** 5.8 — Practical Convergence Edition
**Date:** March 2026
**Author:** Udo Hellmann

*The core architecture in 18 pages — condensed from the full 4,500+ line specification.*
*Each section references the corresponding spec section for full detail.*

---

## 1. Complete System Architecture

MAOS is designed as an operating system for AI agents. It organizes agents in four protection rings, mediates all external effects through a central Commit Layer, and secures the system through a Deterministic Security Core (DSC) that operates independently of any LLM.

```
┌─────────────────────────────────────────────────────────┐
│                    Ring 3 — Untrusted Agents             │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐                 │
│  │ Agent A  │  │ Agent B  │  │ Agent C  │  (Sandboxed)   │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘               │
├───────┼──────────────┼──────────────┼───────────────────┤
│       │    Ring 2 — Trusted Agents  │                    │
│  ┌────┴─────┐  ┌────┴─────┐  ┌─────┴────┐              │
│  │ Agent D  │  │ Agent E  │  │ Agent F  │  (Verified)   │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘              │
├───────┼──────────────┼──────────────┼───────────────────┤
│       │    Ring 1 — System Services │                    │
│  Task Orchestrator │ Memory Mgr │ Security Agent        │
│  Resource Coord    │ Cron Sched  │ Service Manager      │
├────────────────────┼────────────────────────────────────┤
│              Ring 0 — Kernel                             │
│  ┌─────┐ ┌──────────┐ ┌─────┐ ┌─────┐ ┌──────────┐    │
│  │ DSC │ │Commit Lyr│ │ WAL │ │Disp.│ │Boot Mgr  │    │
│  └─────┘ └──────────┘ └─────┘ └─────┘ └──────────┘    │
└─────────────────────────────────────────────────────────┘
                         │
              ┌──────────┴──────────┐
              │   External World    │
              │  (Email, APIs, FS)  │
              └─────────────────────┘
```

Ring 0 (Kernel) contains the DSC, Dispatcher, Commit Layer, WAL, Boot Manager, and Watchdog. No agent code ever runs in Ring 0. Ring 1 provides eleven system services. Ring 2 hosts verified agents, Ring 3 isolates unverified agents in sandboxes. All external effects pass exclusively through the Commit Layer — the only path to the outside world.

▶ *Full specification: §1 System Architecture, §7 Protection Rings*

---

## 2. The Security Pipeline

Every agent action with side effects passes through a seven-stage pipeline. The DSC performs seven deterministic checks. The SSE adds semantic analysis as defense-in-depth. Both can block.

```
Agent Intent
    │
    ▼
┌──────────┐    ┌──────────┐    ┌──────────┐
│  Sentry  │───▶│   DSC    │───▶│   SSE    │
│ (6 Gates)│    │(7 Checks)│    │(Semantic)│
└──────────┘    └────┬─────┘    └────┬─────┘
                     │ DENY          │
                  ┌──┴──┐           │
                  │Block│           │
                  └─────┘           │
                              ┌────┴─────┐
                              │  Commit  │
                              │  Layer   │
                              └────┬─────┘
                                   │
                              ┌────┴─────┐
                              │   WAL    │
                              └────┬─────┘
                                   │
                              External Effect
```

### The seven DSC checks

Every check is deterministic — no LLM judgment, no interpretation. If any check fails, the action is immediately denied.

| Check | What it validates | Protection goal |
|---|---|---|
| 1 | Capability Token — cryptographic signature verification | Only authorized actions |
| 2 | Rate Limit — requests per time window | DoS protection |
| 3 | Budget Verification — token/API budget | Cost control |
| 4 | IFC Label Validation — information flow control | Data protection |
| 5 | Mandatory Rule Compliance — 11 constitutional rules | Absolute security boundaries |
| 6 | Lock & Concurrency Check — resource conflicts | Consistency |
| 7 | DSC Pre-Filter — prompt injection patterns | LLM protection |

*Residual risk: The semantic gap between DSC (syntactic, per-action) and SSE (semantic, per-action) cannot be fully closed. Aggregate Monitoring detects volume-based patterns.*

▶ *Full specification: §15 Security Architecture, §15.3 DSC*

---

## 3. Four Protection Rings

The protection ring model separates code by trust level. Inward promotion requires full 5-stage re-onboarding. Outward demotion is instant at any time.

| Ring | Content | Isolation |
|---|---|---|
| 0 | Kernel: DSC, Dispatcher, Commit, WAL, Boot | Highest — no agent code |
| 1 | System Services: Task Orchestrator, Memory Mgr, etc. | Read yes, write no on kernel data |
| 2 | Trusted Agents: verified, Tier 1–2 | V8 isolate (Std) / OS sandbox (Hard/Iso) |
| 3 | Untrusted Agents: unverified, Tier 3–5 | Agent Execution Pod + all 6 gateways |

▶ *Full specification: §7 Protection Rings, §41 Agent Execution Pod*

---

## 4. Agent Execution Pod

Every agent lives in a Pod — an isolated runtime environment with a Sentry sidecar and six gateway types. The agent cannot modify, configure, or terminate the Sentry. All communication passes through the gateways.

```
┌──────────────────────────────────────────┐
│            Agent Execution Pod            │
│                                          │
│  ┌────────────────────────────────────┐  │
│  │          MAOS Sentry               │  │
│  │   • Policy Enforcer                │  │
│  │   • Traffic Analyzer               │  │
│  │   • Behavioral Fingerprint         │  │
│  │   • Egress Logger                  │  │
│  └──┬───┬───┬───┬───┬───┬────────────┘  │
│     │   │   │   │   │   │                │
│  ┌──┴┐┌─┴─┐┌┴──┐┌┴──┐┌─┴─┐┌──┴──┐      │
│  │In ││Out││LLM││API││FS ││Admin│      │
│  │Msg││Msg││   ││   ││   ││    │      │
│  └───┘└───┘└───┘└───┘└───┘└─────┘      │
│         6 Gateway Types                  │
│                                          │
│  ┌────────────────────────────────────┐  │
│  │        Agent (Core)                │  │
│  │   LLM-powered task execution       │  │
│  └────────────────────────────────────┘  │
└──────────────────────────────────────────┘
```

### Five isolation levels

| Level | Mode | Overhead | Profile |
|---|---|---|---|
| 1 | V8 Isolate (Worker Thread) | ~20 MB, <0.1 ms | Standard Ring 2 |
| 2 | Container (seccomp, AppArmor) | ~50 MB, <0.5 ms | Hardened Ring 2/3 |
| 3 | gVisor (User-Space Kernel) | ~80 MB, 2–5 ms | Ring 3 Inspectable |
| 4 | MicroVM (Firecracker/Kata) | ~128 MB, 5–10 ms | Ring 3 Opaque |
| 5 | Confidential VM (TDX/SEV) | ~256 MB, 10–20 ms | Classified data |

*All overhead is negligible compared to LLM API latency (500–2000 ms).*

▶ *Full specification: §41 Agent Execution Pod, §41.4 Five-Level Isolation*

---

## 5. The "Indestructible Heart" — Seven Protective Layers

The DSC is surrounded by seven protective layers, inspired by nuclear reactor safety and aviation certification. In the highest configuration (Isolated), three DSC instances run, compiled with three different compilers, on different hardware.

| Layer | Mechanism | Check interval |
|---|---|---|
| 7 | Security Heartbeat — signed life signals | 100 ms |
| 6 | Fail-Safe Voter — majority decision (2-of-3) | Every request |
| 5 | Input Sanitizer — formally verifiable (<500 LoC) | Every input |
| 4 | Immutable Config — mprotect, signed configuration | Boot + 5 min |
| 3 | Runtime Integrity — code hash self-verification | 60 seconds |
| 2 | Cross-Watchdog Ring — mutual monitoring | 100 ms |
| 1 | Triple Diverse Compilation — three compilers | Boot |

*In Standard profile, Layers 1 and 2 are not active (single DSC). Defense in depth, not invulnerability.*

▶ *Full specification: §15.7 DSC Seven Protective Layers*

---

## 6. Biological Immune System

MAOS defends itself like an organism. When anomalies are detected, an agent passes through a five-stage quarantine cascade. In Standard profile, the Fast Apoptosis path (v5.8) allows skipping Stages 1–3 for unambiguous violations.

```
Danger Signal
    │
    ▼
┌─────────────────────┐
│ Stage 1: Observation │  30 min, increased monitoring, no restrictions
└─────────┬───────────┘
          │ Confirmed
          ▼
┌─────────────────────┐
│ Stage 2: Soft Isol.  │  Outbound blocked, LLM + tools still open
└─────────┬───────────┘
          │ Compromise confirmed
          ▼
┌─────────────────────┐
│ Stage 3: Hard Isol.  │  All gateways closed, agent frozen
└─────────┬───────────┘
          │ Commander approves
          ▼
┌─────────────────────┐
│ Stage 4: Elimination │  Agent terminated, state preserved, RCA by TSCA
└─────────┬───────────┘
          │
          ▼
┌─────────────────────┐
│ Stage 5: Healing     │  Replacement deployed, immune memory updated
└─────────────────────┘
```

### Additional immune mechanisms

**Security Fever Mode:** When 2+ agents in quarantine: system becomes more restrictive — rate limits halved, all Ring 3 agents receive SSE evaluation.

**Agent Apoptosis:** An agent that detects its own compromise can self-terminate — an absolute right.

**Fast Apoptosis (v5.8):** For deterministically verifiable hard violations (non-whitelisted network, unauthorized code, content filter block) the Sentry may directly terminate and restart from a clean image in Standard profile.

**Immune Memory:** Every deflected threat is stored as a pattern in the Wisdom Pool to accelerate future detection.

▶ *Full specification: §37.8 Quarantine Cascade, §37.11 Bio-Inspired Mechanisms*

---

## 7. Three Security Profiles

Profiles are guarantee envelopes, not cosmetic presets. They differ materially in isolation strength, assurance depth, and operational promises. The eleven Constitutional Mandatory Rules are always active in all profiles.

| Aspect | Standard | Hardened | Isolated |
|---|---|---|---|
| OS | Any (Win/Mac/Linux) | Linux LTS | Hardened Linux |
| Agent isolation | V8 isolate | OS sandbox | MicroVM / CVM |
| DSC instances | 1 | 2 (dual) | 3 (triple, diverse) |
| Encryption at rest | Optional | LUKS2 required | LUKS2 + FIPS 140-3 |
| mTLS | Optional | Required | Required + pinning |
| Key storage | OS credential store | TPM-backed | HSM |
| Audit retention | 30 days | 365 days | 7 years |

### Standard profile security boundaries (v5.7)

Standard provides Mandatory Rules, Capability Tokens, Commit Layer, and WAL. Standard does NOT provide: strong agent isolation, DSC redundancy, commander ceremony controls, or mandatory host OS hardening. Users with sensitive data should use Hardened or Isolated.

▶ *Full specification: §5.2 Security Profiles, §5.2.2 Standard Boundaries*

---

## 8. Mandatory Access Control

Two layers: the eleven Constitutional Mandatory Rules (always active, changeable only through a new MAOS release) and the profile-specific MAC policy (Minimal / Expanded / Strict).

| Profile | MAC mode | Key additions |
|---|---|---|
| Standard | Minimal | Filesystem + network whitelists |
| Hardened | Expanded | + inter-agent payload inspection, + IFC domain boundaries |
| Isolated | Strict | + mandatory message encryption, + code signing, + no direct cross-domain comms |

▶ *Full specification: §10 MAC, §10.3 Profile-Specific Policy Content*

---

## 9. Distributed Architecture

MAOS scales from a single machine to multi-region federations. Three node variants: Sovereign (full version, ~500 MB+), Sentinel (site controller, ~200–400 MB), Pawn (lightweight client, ~50–100 MB). Each is a System Pod in the universal Pod hierarchy.

```
            ┌──────────────────┐
            │    Sovereign     │
            │  (Full MAOS +    │
            │   Cluster Mgmt)  │
            └───────┬──────────┘
           ┌────────┴────────┐
    ┌──────┴──────┐   ┌──────┴──────┐
    │  Sentinel   │   │  Sentinel   │
    │  (Site A)   │   │  (Site B)   │
    └──┬──────┬───┘   └──┬──────┬───┘
    ┌──┴──┐┌──┴──┐   ┌──┴──┐┌──┴──┐
    │Pawn ││Pawn │   │Pawn ││Pawn │
    └─────┘└─────┘   └─────┘└─────┘
```

### Disconnect behavior with TTL defaults (v5.7)

| Failure | Response |
|---|---|
| Pawn loses Sentinel | Progressive Restriction: 5m → Ring 3 pause, 15m → critical only, 60m → MSS |
| Sentinel loses Sovereign | Autonomous with cached policy. No new agents/promotions. |
| Partition heals | Sovereign reconciles. Epoch + OCC re-validation. |

▶ *Full specification: §40 Distributed Architecture, §9.3 Token TTL Defaults*

---

## 10. Degradation and Recovery

MAOS supports five graduated degradation modes. During system failures, the TSCA (Trusted System Control Agent) activates — a privileged agent for intelligent diagnosis and recovery.

| Mode | State | Capability |
|---|---|---|
| Normal | All systems operational | Full functionality |
| Degraded-1 | Non-critical service failure | Reduced features, core intact |
| Degraded-2 | Critical service failure | Essential operations only |
| Degraded-3 | Multiple failures | Minimal safe operations |
| MSS | Minimal Safe State | All agents paused, kernel + WAL only |

The TSCA operates with a per-incident action budget — it cannot take unlimited actions. Every significant TSCA action requires Watchdog confirmation. If the TSCA itself fails, the system enters MSS and waits for the Commander.

▶ *Full specification: §38 Resilience Architecture, §38.7 TSCA*

---

## 11. Aggregate Monitoring (v5.7)

Individual actions can pass the DSC, but in aggregate form an exfiltration pattern. Aggregate monitoring tracks cumulative metrics per agent and escalates when thresholds are exceeded.

| Metric | Default threshold | Window |
|---|---|---|
| Outbound data volume | 100 MB | 24h |
| Unique external recipients | 50 | 7 days |
| External API calls | 500 | 24h |
| IFC declassifications | 10 | 24h |
| Outbound to single A2A agent | 50 MB | 24h |

*Calibration: 30-day monitoring-only phase, measure natural baseline, set production at 3x 95th percentile.*

*Residual risk: Aggregate monitoring detects volume-based exfiltration, not semantically transformed data chains.*

▶ *Full specification: §49.11 HACF Aggregate Monitoring*

---

## 12. The Organism and the Mission Concept

MAOS models agents as cells in a biological organism. 7 of 9 cell types operate without LLM dependency. When all providers fail, the system enters Rule-Based Mode: alive, safe, waiting for consciousness to return.

| Cell type | Role | LLM required? | Ring |
|---|---|---|---|
| Cognitive Cells (Brain) | Thinking, analysis, planning | Yes | 2/3 |
| Immune Cells (Defense) | Security monitoring, evaluation | Partial | 1 |
| Nerve Cells (Communication) | Message routing | No | 1 |
| Blood Cells (Resources) | Resource distribution | No | 1 |
| Stem Cells (Builders) | Agent creation, onboarding | Yes | 1 |
| Skin Cells (Boundary) | Sentry instances, traffic filtering | No | 1 |
| Bone Cells (Structure) | Dispatcher, Orchestrator, Commit Layer | No | 0 |
| Memory Cells (Storage) | Memory Manager, Wisdom Pool | No | 1 |
| Sensory Cells (Perception) | Observability, Self-Model | No | 1 |

### Mission Context (v5.8)

A Task Plan may include a `mission_statement` — a human-authored goal description propagated as a System Prompt fragment to all participating agents. In medical and research scenarios, this ensures all agents pursue the same overall goal.

▶ *Full specification: §17.1 Phase 2 Mission Context, §30.8 Cell Types*

---

## 13. Human Oversight (HACF)

The Human-AI Consensus Framework defines four levels of human involvement:

| Level | Name | Human role |
|---|---|---|
| 1 | Inform | Agent acts autonomously, human is informed |
| 2 | Recommend | Agent recommends, human decides |
| 3 | Deliberate | Human and agent collaboratively develop a decision |
| 4 | Override | Human overrides — with cooling-off, diff, out-of-band verification |

The Commander observes through three surfaces: the Dashboard (richest information, not root of trust), the Trusted Display Path (minimal truth, <500 LoC, separate process), and the Trusted Decision Packet (approval context for critical decisions).

▶ *Full specification: §50 HACF, §43 Human-Machine Interface*

---

## Summary

MAOS is the first complete reference architecture for secure multi-agent systems. It addresses all ten risks of the OWASP Agentic AI Top 10, is designed for EU AI Act requirements, and scales from a single laptop to enterprise-wide federations.

The five core mechanisms — Commit Layer, Capability Tokens, Sentry/Gateways, WAL, and DSC — form the minimal implementation that would already make MAOS the most secure agent framework available.

The complete technical specification (v5.8, 4,500+ lines) accompanies this document as a reference. It contains the formal definitions of all mechanisms, security invariants, conformance requirements, and the complete glossary.

---

*MAOS — Multi-Agent Operating System v5.8 — Practical Convergence Edition.*

*© 2026 Udo Hellmann. Released under Apache 2.0 License.*
