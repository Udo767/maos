# MAOS — Multi-Agent Operating System

## Executive Summary

**Version:** 5.8 — Practical Convergence Edition
**Date:** March 2026
**Author:** Udo Hellmann

---

## The Problem

AI agents can send emails, execute code, call APIs, and modify databases today. No existing framework provides the OS-level safety primitives that prevent them from doing so in unauthorized ways.

Current agent frameworks (AutoGen, CrewAI, LangGraph, Google ADK) treat security as an afterthought — a configuration option a developer can set or forget. None offers capability-based access control, information flow tracking, deterministic security decisions independent of the LLM, or formal isolation boundaries between agents.

The EU AI Act (August 2026) requires transparency, human oversight, robustness, and logging for high-risk AI systems. No existing agent architecture meets these requirements.

---

## The Solution: MAOS

MAOS (Multi-Agent Operating System) is a three-layer architecture built on a single recursive principle: the Universal Pod. Every entity in the system — from a single agent to an entire enterprise cluster — lives in a Pod with the same structural pattern: Boundary, Sentry, Gateways, Core, Identity, Health, Isolation, Checkpoint, Autonomy, Degradation.

```
Agent Intent → Sentry + Gateways → DSC (7 Checks) → SSE (additive) → Commit Layer → WAL → External Effect
```

**Layer 1 — Universal Pod Specification.** The foundational pattern. Every Pod has a boundary, a sentry, controlled entry/exit points, and a core. Security analysis of the Pod pattern applies to all levels simultaneously.

**Layer 2 — MAOS Core (Security Kernel).** The deterministic enforcement layer. Four protection rings, capability-based security, eleven constitutional rules, crash safety via Write-Ahead Logging. Does not require any LLM to function.

**Layer 3 — ACIL (Agent Cognitive Intelligence Layer).** The AI-specific cognitive layer. Understands context windows, hallucination risks, and cognitive limits of LLMs.

---

## Five Differentiators

### 1. Deterministic Security Independent of the LLM

The Deterministic Security Core (DSC) is not an LLM. It is pure, deterministic, formally verifiable code. It makes binary decisions — allow or deny — based on mathematical checks, not semantic interpretation. Seven checks in fixed order: Capability Token, Rate Limit, Budget, IFC Label, Mandatory Rules, Concurrency, Content Filter. If the LLM is compromised, the DSC remains intact.

### 2. Commit Layer — The Only Path to the Outside World

No agent can touch the outside world directly. Every action with side effects (sending email, modifying files, calling APIs) passes through the Commit Layer — a central pipeline that validates, logs, and can roll back. This is the fundamental difference from every existing framework where agents simply make API calls.

### 3. Capability Tokens — Cryptographically Signed Permissions

Agents do not implicitly have access to everything. They receive cryptographically signed tokens with limited scope, limited validity, and limited budget. An email agent can send emails but cannot access the filesystem. A data agent can read files but cannot send emails. Every permission is explicit, verifiable, and revocable.

### 4. Four Protection Rings — Like an Operating System

Ring 0 (Kernel) contains only trusted system code. Ring 1 (System Services) provides infrastructure. Ring 2 (Trusted Agents) hosts verified agents. Ring 3 (Untrusted Agents) isolates unverified agents in sandboxes. No agent code ever runs in Ring 0.

### 5. Biological Immune System

MAOS defends itself like an organism: with a 5-stage quarantine cascade, Danger Signals, Security Fever Mode, Agent Apoptosis (programmed cell death), and an immune memory that learns from every deflected threat. 7 of 9 cell types operate without any LLM — if all providers fail, the system enters safe Rule-Based Mode.

---

## Comparison with Existing Frameworks

| Capability | AutoGen | CrewAI | LangGraph | Google ADK | **MAOS** |
|---|---|---|---|---|---|
| Protection Rings | — | — | — | — | ✓ (4 rings) |
| Security without LLM | — | — | — | — | ✓ (DSC) |
| Capability Tokens (PQC) | — | — | — | — | ✓ |
| Pre-Execution Evaluation | — | — | — | — | ✓ |
| IFC Taint Tracking | — | — | — | — | ✓ |
| Biological Immune System | — | — | — | — | ✓ (7 mechanisms) |
| Post-Quantum Crypto | — | — | — | — | ✓ |
| Agent PKI + Transparency | — | — | — | — | ✓ |
| Self-Healing (Quarantine) | — | — | — | — | ✓ (5 stages) |
| Formal Redundancy (TMR) | — | — | — | — | ✓ (Triple DSC) |
| Trusted Display Path | — | — | — | — | ✓ |
| EU AI Act Alignment | Partial | Partial | Partial | Partial | ✓ (Design) |

---

## Three Security Profiles

**Standard** — Development and personal use. V8 isolates, single DSC, optional encryption. Honest about what it does not protect against (§5.2.2).

**Hardened** — Business and sensitive data. OS sandboxing, dual DSC, SELinux, mTLS, M-of-N commander keys.

**Isolated** — Regulated industries (healthcare, government, finance). MicroVM/Confidential VM, triple DSC, HSM, TPM attestation, 7-year audit retention.

All profiles share the eleven Constitutional Mandatory Rules — the hard security floor that cannot be weakened at runtime.

---

## Use Cases

**Medicine:** Multi-agent diagnosis with clinical reporting. Image analysis, lab results, and patient history agents work toward a shared mission. IFC taint tracking protects patient data. HACF Human-in-the-Loop for critical decisions.

**Enterprise Automation:** Email, calendar, and data agents working in parallel. Capability Tokens limit each agent to what it needs. The Commit Layer prevents unintended side effects.

**Research:** Complex, iterative prompt chains with the graphical orchestrator. Parallel processing across multiple models (local and external). Wisdom Pool for collective inter-agent learning.

**Regulated Environments:** Isolated profile with HSM-stored keys, TPM attestation, 7-year audit logs. EU AI Act compliance by design.

---

## Next Steps

MAOS is a complete reference architecture specified in a technical specification with over 4,500 lines and eight companion documents. The architecture is ready for implementation.

The full technical specification (v5.8), the Architecture Overview with diagrams, and all companion documents are available as open source at **github.com/Udo767/maos**.

For questions, collaboration proposals, or contributions: please open a GitHub Issue.

---

*MAOS — Multi-Agent Operating System. The first operating system for secure AI agents.*

*© 2026 Udo Hellmann. Released under Apache 2.0 License.*
