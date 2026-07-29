# Evaluation Architecture and Threat Model — Document Frontier

**Origins:** `research/evaluation/10-threat-model.md`; `11-system-architecture.md`

## Knowledge and limitations

The architecture separates task registry, runner, graders, evidence, results, and decisions while the threat model identifies leakage, unsafe actions, tampering, and overgeneralization. Both remain mostly design claims without exercised controls.

## Five highest-value opportunities

1. **RFR-008:** Fault-inject containment, monitoring, pause, and rollback.
2. **RFR-009:** Validate immutable identifiers and provenance.
3. **RFR-002:** Exercise canonical run contracts end to end.
4. **RFR-003:** Test grader separation and adjudication.
5. **RFR-006:** Verify that results store captures all-in cost.

**Challenge:** Low-risk local fixtures can create false confidence in controls intended for networked or consequential tasks; promotion must remain risk-tier-specific.

