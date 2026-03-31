# MAOS — Multi-Agent Operating System

**A living reference architecture for secure AI agent systems.**

---

## The Problem

AI agents can send emails, execute code, call APIs, and modify databases today. No existing framework provides the OS-level safety primitives that prevent them from doing so in unauthorized ways.

Current agent frameworks (AutoGen, CrewAI, LangGraph, Google ADK) treat security as an afterthought. None offers capability-based access control, information flow tracking, deterministic security decisions independent of the LLM, or formal isolation boundaries between agents.

The EU AI Act (August 2026) will require transparency, human oversight, robustness, and logging for high-risk AI systems. No existing agent architecture meets these requirements.

## The Solution

MAOS is an operating system architecture for AI agents. Five core mechanisms that no other framework has:

| Mechanism | What it does |
|---|---|
| **Commit Layer** | Single chokepoint for all external effects — no agent can touch the outside world without validation, logging, and rollback capability |
| **Capability Tokens** | Cryptographically signed, scoped, time-limited permissions — an email agent can send emails but cannot access the filesystem |
| **Deterministic Security Core (DSC)** | Pure deterministic code making binary allow/deny decisions — cannot be "persuaded", "confused", or "jailbroken", independent of any LLM |
| **Sentry + 6 Gateways** | Every agent sits behind controlled entry/exit points it cannot see or modify |
| **Write-Ahead Log** | Crash-safe audit trail — no committed state change is ever lost |

```
Agent Intent → Sentry → DSC (7 checks) → Commit Layer → WAL → External Effect
                          ↓ DENY                ↓
                        Blocked            Logged + Rollbackable
```

## How MAOS compares

| Capability | AutoGen | CrewAI | LangGraph | Google ADK | **MAOS** |
|---|---|---|---|---|---|
| Protection Rings (4 levels) | — | — | — | — | ✓ |
| Security independent of LLM | — | — | — | — | ✓ |
| Capability Tokens (PQC-signed) | — | — | — | — | ✓ |
| IFC Taint Tracking | — | — | — | — | ✓ |
| Biological Immune System | — | — | — | — | ✓ |
| Post-Quantum Cryptography | — | — | — | — | ✓ |
| Self-Healing Quarantine (5 stages) | — | — | — | — | ✓ |
| Trusted Display Path | — | — | — | — | ✓ |
| EU AI Act Design Alignment | Partial | Partial | Partial | Partial | ✓ |

## Three Security Profiles

**Standard** — Development and personal use. V8 isolates, single DSC, optional encryption. Honest about what it doesn't protect against.

**Hardened** — Business and sensitive data. OS sandboxing, dual DSC, SELinux, mTLS, M-of-N commander keys.

**Isolated** — Regulated industries. MicroVM/Confidential VM, triple DSC, HSM, TPM attestation, 7-year audit retention.

All profiles share the eleven Constitutional Mandatory Rules.

## Documentation

Start here, go deeper as needed:

| Document | Pages | For whom |
|---|---|---|
| **[Executive Summary](spec/MAOS_Executive_Summary_v5_8.md)** | 4 | Decision-makers — the "why" in 5 minutes |
| **[Architecture Overview](spec/MAOS_Architecture_Overview_v5_8.md)** | 18 | Architects — the "how" with diagrams |
| **[Technical Specification v5.8](spec/MAOS_Technical_Specification_v5_8.md)** | 4,500+ lines | Implementers — the complete "what" |

Companion documents:

| Document | Role |
|---|---|
| [Visual Guide](companion/MAOS_Visual_Guide_v5_8.md) | Structural diagrams with residual-risk annotations |
| [AI Security Study](companion/MAOS_AI_Security_Study_v5_8.md) | OWASP Agentic AI Top 10 coverage, competitive analysis |
| [Adversarial Assurance Review](companion/MAOS_Adversarial_Assurance_Review_v5_8.md) | Red team findings, closure status, evidence gaps |
| [Companion Specification](companion/MAOS_Companion_Specification_v5_8.md) | Operational procedures, deployment guidance |
| [Agent & Human Views](companion/MAOS_Agent_Human_Views_v5_8.md) | Philosophical foundation, HACF design rationale |
| [Redundancy Guide](companion/MAOS_Redundancy_Guide_v5_8.md) | High availability, split-brain prevention |

## Publication Note

MAOS is a **living reference architecture** for secure multi-agent systems.

It is published as a public discussion base, architectural framework, and development substrate for security architectures that should become increasingly implementable over time.

MAOS is not intended to be read merely as inspiration. Its purpose is to help shape real, testable, and eventually deployable system components for agentic safety, governance, isolation, resilience, and human oversight.

At the same time, MAOS should not be interpreted as an automatic certification claim or as proof that every described property is already fully implemented or formally verified.

Different parts of the architecture are in different maturity states:

| State | Meaning |
|---|---|
| specified | normatively described in the specification |
| prototyped | design validated in proof-of-concept |
| implemented | shipped and testable |
| tested | backed by documented test evidence |
| verified | model-checked or formally assessed |
| planned | architectural direction for future versions |

MAOS should be read in three layers:

1. **Architectural direction** — the system vision and design logic
2. **Normative core** — the minimum rules, invariants, and boundaries
3. **Implementation pathway** — the parts becoming concretely testable over time

**The long-term goal of MAOS is not only to describe secure agentic systems, but to help make them practically buildable.**

## Contributing

MAOS grows through critique, not through applause. See [CONTRIBUTING.md](CONTRIBUTING.md).

The most valuable contributions are:

- **Critique** — find what's wrong, impractical, or missing
- **Adversarial review** — try to break the security model
- **Implementation experience** — report what works and what doesn't when building
- **Formal verification** — TLA+, Alloy, or model-checking of invariants

Contributions welcome in English or German.

## Future Directions

Ideas for future versions that need validation through implementation: [FUTURE.md](FUTURE.md)

## Version History

| Version | Edition |
|---|---|
| v5.5 | Core Governance Integration |
| v5.6 | Adversarial Seam Hardening |
| v5.7 | Precision, Defaults, and Conformance Hardening |
| v5.8 | Practical Convergence |

## Author

**Udo Hellmann**

## License

[Apache 2.0](LICENSE)

---

*MAOS is not a finished security truth, but a growing security architecture with the explicit goal of maturing into robust and implementable components.*
