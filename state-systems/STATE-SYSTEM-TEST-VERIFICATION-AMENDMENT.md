STATE-SYSTEM-TEST — VERIFICATION EVIDENCE AMENDMENT

PURPOSE

This is an amendment to STATE-SYSTEM-TEST.txt, not the entire test document.

Insert this section after "1. Operating Rules" and before "2. Required Repository Discovery".

Also apply the Final Verdict wording change at the end of this file.


======================================================================
VERIFICATION EVIDENCE STANDARD
======================================================================

The state-system test is not complete unless findings and passes are supported by explicit evidence.

Do not mark a property PASS merely because the implementation appears correct on inspection.

When a property can reasonably be executed, exercise it.

For every tested property, record:

Verification Method:
    Executed
    Static / Type-Level Proof
    Direct Structural Inspection
    Reasoned Inference
    Not Verified

Evidence:
    command, test, code location, transition table, type constraint,
    generated counterexample, or other concrete artifact used

Result:
    PASS
    FAIL
    UNKNOWN

Use the following evidence hierarchy:

Executed Evidence
    >
Static / Type-Level Proof
    >
Direct Structural Inspection
    >
Reasoned Inference
    >
Assumption


1. PREFER EXECUTION WHEN EXECUTION IS PRACTICAL

If a property can reasonably be tested by running:

- unit tests;
- property tests;
- integration tests;
- transition tests;
- serialization tests;
- command-sequence tests;
- validation tools;

then execute the test rather than relying only on inspection.

Example:

Do not mark:

    Recorded entries reject invalid 5-minute durations.

PASS merely because the guard appears to exist.

Attempt the invalid transition or execute the relevant test.


2. TYPE-LEVEL IMPOSSIBILITY MAY COUNT AS STRONG EVIDENCE

If the type system makes an invalid configuration unconstructable through the supported domain API, record:

    Verification Method:
    Static / Type-Level Proof

Explain exactly what prevents construction.

Still test external boundaries such as:

- deserialization;
- persistence hydration;
- API decoding;
- WASM decoding;
- migrations;

because those may bypass normal constructors.


3. INSPECTION IS NOT EXECUTION

Code inspection may establish that:

- a guard exists;
- a state is represented;
- a transition handler appears present;
- an invariant appears checked.

It does not by itself prove that the complete runtime path behaves correctly.

Use:

    Verification Method:
    Direct Structural Inspection

rather than "Executed".


4. INFERENCE MUST REMAIN VISIBLY UNCERTAIN

If a conclusion is based on reasoning rather than direct evidence, mark:

    Verification Method:
    Reasoned Inference

and explain the reasoning.

Do not convert inferred correctness into PASS unless the test explicitly permits reasoning-only verification for that property.


5. UNKNOWN IS NOT PASS

If evidence is missing, contradictory, inaccessible, or insufficient:

    Result:
    UNKNOWN

An UNKNOWN result must appear in:

- residual unknowns;
- final findings where material;
- recommended follow-up work.

Do not treat lack of discovered failure as evidence of correctness.


6. FAILED EXECUTION OVERRIDES OPTIMISTIC INSPECTION

If code appears correct but an executable test produces a counterexample, the executable result controls.

Record the discrepancy.


7. PRESERVE COUNTEREXAMPLES

Whenever a test discovers an invalid state or transition, preserve:

    Initial configuration
    Input / command sequence
    Effect results if relevant
    Observed result
    Expected result
    Exact failure
    Reproduction command/test

A minimal reproducible counterexample is stronger evidence than a prose description.


8. VERIFICATION MUST COVER CORRECTIONS

When the state-system test produces corrective work and that work is implemented, rerun the relevant portions of the test.

Do not close the finding based solely on the presence of a code change.

Required correction lifecycle:

    Finding
        ↓
    Correction implemented
        ↓
    Original counterexample rerun
        ↓
    Relevant regression tests run
        ↓
    State-system property retested
        ↓
    PASS / FAIL / UNKNOWN

A correction is complete only when the original defect can no longer be reproduced and the surrounding state-system properties still hold.


======================================================================
REQUIRED VERIFICATION RECORD
======================================================================

For every major test category in the final report, include:

    Property:
    Verification Method:
    Evidence:
    Result:
    Confidence:

Example:

    Property:
    A Recorded time entry cannot contain a duration outside 6-minute increments.

    Verification Method:
    Executed

    Evidence:
    dotnet test --filter DurationInvariant
    Adversarial construction attempt using 5-minute duration rejected
    with InvalidDuration.

    Result:
    PASS

    Confidence:
    High

Another example:

    Property:
    Every OutcomeUnknown state has a reconciliation path.

    Verification Method:
    Direct Structural Inspection

    Evidence:
    Reconcile command exists for payment effect state, but no executable
    test currently exercises it.

    Result:
    UNKNOWN

    Confidence:
    Medium


======================================================================
GOVERNING VERIFICATION RULES
======================================================================

A state-system property is not verified merely because no defect was noticed.

When a property can reasonably be executed, execution is required before claiming it passes.


======================================================================
FINAL VERDICT AMENDMENT
======================================================================

In the existing "39. Final Verdict" section, replace:

    Use PASS only when no material state-system defect remains within the
    tested boundary.

with:

    Use PASS only when no material state-system defect remains within the
    tested boundary and all material properties have sufficient verification
    evidence. UNKNOWN material properties prevent PASS.
