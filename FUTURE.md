# MAOS — Future Directions

Ideas for future versions. These are not commitments — they are directions that need validation through implementation experience.

## Needs implementation evidence first

These ideas are architecturally sound but untested. They should only enter the spec after someone has built and measured them.

- **Cross-Action Semantic Analysis (CASA):** Detecting harmful effects from sequences of individually legitimate actions. The concept was proposed and rejected for v5.8 because it requires semantic judgment (contradicting §15.1) and information-theoretic measures that are an open research problem. Revisit when aggregate monitoring data from a real deployment shows what patterns actually occur.

- **Adaptive immune thresholds:** Making the Fever Mode activation threshold dynamic based on false-positive rates. Rejected for v5.8 because an adaptive threshold is itself attackable (an attacker can train the system to raise the threshold, then attack). Revisit when operational data shows whether the static threshold is adequate.

- **Confidence Chain stratification:** Testing confidence calibration separately for read-only, internal-write, and external-write actions. Proposed for v5.7, simplified to the existing global calibration. Worth revisiting with real calibration data.

## Needs design work

These directions are promising but not yet specified.

- **Agent-to-Agent learning protocols:** Structured mechanisms for agents to share operational insights beyond the Wisdom Pool. How does one agent teach another without creating a knowledge-poisoning vector?

- **Domain extension framework:** The medical domain extension exists as a reference implementation. Other domains (legal, financial, logistics) need their own safety profiles, terminology, and HACF configurations.

- **Multi-tenant isolation:** Cloud deployment (Mode 4) requires full user isolation. The spec mentions it but doesn't detail the tenant boundary model.

## Needs community input

These are open questions where the right answer depends on perspectives beyond one author.

- **Agent rights scope:** The five Constitutional Rights (§49.5) are a starting point. As AI capabilities grow, should agents have additional rights? What are the ethical boundaries?

- **Formal verification priority:** Which invariants should be formally verified first? The eleven Mandatory Rules? The Quarantine state machine? The Revocation Epoch protocol? Community input on verification priorities would be valuable.

- **Standard profile scope:** Is Standard profile too weak or too strong? Developers want minimal friction. Security-conscious users want guarantees. Where is the right balance?

---

*These ideas are captured here so they don't get lost — and so they don't prematurely enter the spec. The spec grows through validated additions, not through ambition.*
