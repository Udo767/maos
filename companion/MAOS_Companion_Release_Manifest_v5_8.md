# MAOS Companion Release Manifest v5.8

**Version:** 5.8.0  
**Date:** March 31, 2026  
**Purpose:** Release-level inventory for the companion subset aligned to MAOS Technical Specification v5.8 (Practical Convergence Edition).

---

## 1. Release policy

The rule for the v5.8 companion set is:

- the **core specification** defines constitutional and minimum normative baselines,
- **companion documents** explain, operationalize, visualize, assess, or contextualize those baselines,
- no companion document may silently weaken the core,
- and where v5.8 added defaults or clarified profile limits, companion documents must reflect that change explicitly.

---

## 2. Artifact inventory

| Document | Version | Role | Normative strength | Primary core anchors |
|---------|---------|------|--------------------|----------------------|
| Executive Summary | v5.8 | decision / overview | non-normative | §§5.2.2, 5.3, 9.3, 10.3, 37.2, 38.6/11/12, 43a–b, 49.11 |
| Companion Specification | v5.8 | operational reference | mixed, derived | §§5.2.2, 5.3, 9.3, 10.3, 14.1, 37.2, 38.6/11/12, 43a–b, 49.11 |
| Visual Architecture Guide | v5.8 | visual explanation | mostly non-normative | §§15, 26.1, 38.11–12, 43a–b, 49.11 |
| Redundancy & HA Guide | v5.8 | resilience companion | derived | §§38.6, 38.11–12, 51 |
| AI Security Study | v5.8 | assurance / comparison | companion assurance | §§37, 49.11, 51 |
| Agent and Human Views | v5.8 | governance / HMI perspective | mixed | §§43a–b, 50 |
| Adversarial Assurance Review | v5.8 | review / closure companion | non-normative review | cross-cutting |

---

## 3. Alignment checklist

| Check | Status target |
|------|---------------|
| core references updated to v5.8 | required |
| standard-profile boundary language aligned to core | required |
| token TTL defaults reflected operationally | required |
| aggregate-monitoring defaults and calibration reflected | required |
| A2A outbound leakage handling reflected | required |
| quarantine stage 4 profile logic aligned | required |
| reasoning-state-loss residual risk reflected | required |
| visual simplifications explicitly labeled | required |
| assurance and manifest lineage clarified | required |

---

## 4. Remaining future companion candidates

This release aligns the revised companion subset. Additional companion artifacts may still be desirable, such as:

- UPS reference,
- HACF operator guide,
- AEP deployment guide,
- distributed architecture guide,
- governance playbook,
- domain-extension guide.

---

*Release manifest for the MAOS v5.8 companion subset revised in this session.*  
