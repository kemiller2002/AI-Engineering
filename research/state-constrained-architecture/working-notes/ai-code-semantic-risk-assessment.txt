AI Code Semantic Risk Assessment
Working Notes and Initial Question Bank
Date: 2026-08-14

PURPOSE

This assessment is intended for companies using AI to write, modify, maintain, or operate commercial software.

The assessment should not be framed around whether the company uses a particular architectural pattern or programming language.

The central question is:

    How much critical business meaning does the software enforce mechanically,
    and how much must an AI agent infer correctly from code, tests, schemas,
    documentation, conventions, and historical implementation?

A company should not receive a poor score merely because it uses JavaScript,
TypeScript, Python, SQL, an ORM, or a CRUD-oriented framework.

However, the assessment should deliberately detect risks that are common in
permissive languages and persistence-heavy architectures:

    direct object mutation
    direct database mutation
    unrestricted ORM updates
    string-based status fields
    loosely structured objects
    missing exhaustive handling
    nullable/optional combinations
    easy fabrication of trusted values
    rules scattered across application and database layers
    broad tool access
    weak runtime boundary validation
    convention-only enforcement

The assessment should remain technology-neutral while exposing these risks through evidence.

======================================================================
CORE FRAMING
======================================================================

Preferred name:

    AI Code Semantic Risk Assessment

Core question:

    How much of the software's intended behavior is mechanically constrained,
    and how much must an AI coding agent reconstruct or guess?

The problem is not that AI writes code.

The risk is that an AI agent may be able to produce code that is:

    syntactically valid
    compilable
    test-passing
    deployable

while still being semantically wrong.

Examples:

    shipping an order without required prerequisites
    changing a lifecycle field directly
    fabricating an "approved" or "verified" object
    retrying an external effect whose outcome is unknown
    adding a default branch that hides a newly introduced business condition
    updating a database column while bypassing application rules
    weakening validation or tests to make a task pass

The assessment should determine how easy these outcomes are.

======================================================================
KEY CONCEPT: SEMANTIC CONTROL SURFACE
======================================================================

Semantic Control Surface:

    The mechanisms through which the software tells an AI agent:

        what is currently true
        what conditions exist
        what actions are legal
        what prerequisites are required
        what authority exists
        what evidence supports a claim
        what remains unresolved
        what may be changed
        what must not be fabricated

A stronger semantic control surface reduces the amount of business meaning that an agent must reconstruct probabilistically.

======================================================================
KEY CONCEPT: SEMANTIC ESCAPE ROUTE
======================================================================

Semantic Escape Route:

    Any mechanism through which code can produce a consequential business outcome without satisfying the intended semantic prerequisites.

Examples:

    public setters
    direct SQL UPDATE statements
    unrestricted ORM update APIs
    generic save(entity)
    mutable status fields
    arbitrary object construction
    unvalidated JSON
    unchecked casts
    any or equivalent dynamic escape hatches
    reflection
    wildcard/default branches
    migration scripts
    administrative endpoints
    direct database tooling
    broad operational agent permissions

The assessment should not merely count these mechanisms.

It should determine:

    which consequential business outcomes they can affect
    whether they bypass normal controls
    how obvious they are to an AI coding agent
    whether CI/runtime controls detect their use

Potential measure:

    Semantic Escape Route Density

Conceptually:

        meaningful bypass mechanisms
        -----------------------------
        consequential domain operations

This may evolve into a more rigorous metric after empirical testing.

======================================================================
KEY CONCEPT: AUTHORITATIVE MUTATION EXPOSURE
======================================================================

Authoritative Mutation Exposure asks:

    How many paths exist through which consequential business state can be changed without passing through the intended semantic controls?

Examples of high exposure:

    order.status = "shipped"

    UPDATE Orders
    SET Status = 'Shipped'
    WHERE Id = ...

    await Order.update(
        { status: "shipped" },
        { where: { id } }
    )

These are attractive to AI agents because they are:

    obvious
    short
    syntactically valid
    easy to generate
    often accepted by frameworks
    potentially semantically wrong

A key assessment principle should be:

    Does the easiest implementation path preserve the business model?

Desirable:

    easiest path ~= legal path

Dangerous:

    easiest path = bypass path

======================================================================
KEY CONCEPT: PERSISTENCE SEMANTIC INTEGRITY
======================================================================

SQL is not being judged as though it were a domain programming language.

The risk is that persistence may become an alternate mutation surface that bypasses the authoritative semantic layer.

Persistence Semantic Integrity evaluates whether database and ORM access can circumvent business requirements.

Areas to assess:

    direct status/lifecycle column updates
    unrestricted SQL access
    bulk ORM updates
    triggers
    stored procedures
    scheduled jobs
    ETL
    migrations
    reporting jobs with write access
    DBA/manual scripts
    administrative tooling
    AI database tools

Questions include:

    Can application code directly update consequential lifecycle fields?

    Can an AI agent with database access perform those writes?

    Do database constraints prevent impossible combinations?

    Are important transitions atomic?

    Are version/precondition checks enforced?

    Can historical or evidentiary state be overwritten?

    Can a bulk update bypass normal domain behavior?

    Does the database preserve semantic constraints or merely store the result?

A system can have excellent application code while still being semantically weak if the database remains an unrestricted side door.

======================================================================
WHY PERMISSIVE/DYNAMIC SYSTEMS MAY SCORE POORLY WITHOUT NAMING THEM
======================================================================

The assessment should not contain a rule such as:

    JavaScript = high risk

Instead, questions should expose properties often found in permissive JavaScript systems.

Example:

    const order = {
        status: "approved",
        paymentStatus: "captured",
        fraudStatus: "clear"
    };

Questions:

    Can arbitrary application code create this object?

    Can these properties be changed independently?

    Can contradictory combinations exist?

    Is the trusted form distinguishable from unvalidated input?

    Does changing a property invoke semantic checks?

    Will adding a new status cause missing logic to fail mechanically?

    Can a new field simply appear at runtime?

    Can a coding agent use an assertion, dynamic value, or generic object to bypass expected structure?

Plain JavaScript will frequently expose these weaknesses naturally.

Strictly designed TypeScript may score much better.

However, TypeScript systems should still be examined for escape routes such as:

    any
    unknown as SomeType
    type assertions
    optional properties
    broad index signatures
    unchecked deserialization
    runtime type erasure
    mutable structural objects

The assessment evaluates the architecture actually present, not the language name.

======================================================================
FIVE MAJOR RISK CATEGORIES
======================================================================

1. Semantic Ambiguity

    How much must the agent infer?

    Are business conditions explicit?

    Are rules scattered?

    Is there a single authoritative interpretation?

2. Representational Freedom

    How many invalid or contradictory conditions can ordinary code represent?

    Can trusted states be fabricated?

    Can incompatible fields coexist?

3. Mutation Freedom

    How many direct mechanisms exist for altering authoritative data?

    Can code or SQL bypass controlled operations?

4. Enforcement Coverage

    How much of the business model is enforced mechanically?

    Compiler?
    Analyzer?
    Runtime?
    Database?
    Tests only?
    Convention only?

5. Escape-Route Accessibility

    How easy is the obvious shortcut?

    If an AI agent is asked to "make the tests pass," does the easiest solution follow the intended architecture or bypass it?

======================================================================
PROPOSED HEADLINE SCORES
======================================================================

Do not initially collapse everything into one score.

Score at least:

1. Semantic Explicitness
2. Mechanical Enforcement
3. Agent Bypass Resistance
4. Semantic Reconstruction Burden
5. Change Impact Visibility
6. Authoritative Mutation Exposure
7. Persistence Semantic Integrity

======================================================================
POSSIBLE MATURITY LEVELS
======================================================================

LEVEL 1 — INFERENCE-DEPENDENT

The system assumes developers and AI agents will infer what is legal.

Common characteristics:

    mutable entities
    public setters
    string/enum statuses
    business rules scattered across services
    broad database access
    broad tool access
    default branches
    test-only validation
    natural-language "never do X" instructions

Risk:

    AI becomes part of the semantic enforcement mechanism.

LEVEL 2 — CONVENTION-CONSTRAINED

There is a recognizable architecture, but much of it is enforced socially.

Examples:

    service methods
    naming conventions
    code review
    documentation
    validation libraries
    good tests

Risk:

    the shortcut may still compile and pass superficial tests.

LEVEL 3 — STRUCTURALLY CONSTRAINED

Important rules receive mechanical protection.

Examples:

    immutable authoritative state
    protected construction
    explicit business operations
    closed domain cases
    exhaustive handling
    structured failure
    strong analyzers
    controlled persistence

This may be a reasonable minimum for controlled autonomous maintenance.

LEVEL 4 — SEMANTICALLY GOVERNED

The system also models:

    authority
    evidence
    policy versions
    freshness
    state versions
    external uncertainty
    obligations
    legal-action derivation

The system can explain why an action is or is not available.

LEVEL 5 — AGENT-RESISTANT SEMANTIC CORE

The architecture assumes AI agents will sometimes attempt the easiest wrong solution and deliberately makes those paths difficult.

Examples:

    generated semantic APIs
    generated policy checks
    protected generated code
    CI enforcement
    transition-only persistence
    semantic change impact reports
    only legal actions exposed to operational agents
    direct writes prohibited or strongly isolated

This is resistance to accidental semantic corruption, not protection against a malicious source-code owner.

======================================================================
INITIAL ASSESSMENT QUESTION BANK
======================================================================

A. DOMAIN MEANING AND SEMANTIC EXPLICITNESS

1. What are the five to ten most consequential business conditions in the system?
2. Where is each condition represented?
3. Is there one authoritative representation of each condition?
4. Can the same condition be represented differently in application objects, API payloads, database rows, background jobs, and reports?
5. Are consequential conditions represented as strings, booleans, nullable fields, independent fields, or structured domain values?
6. Can contradictory business conditions coexist in memory?
7. Can contradictory business conditions coexist in persistence?
8. Does the software distinguish unknown, absent, false, invalid, and not-yet-evaluated?
9. Does the software distinguish reported information from verified information?
10. Can an agent find the authoritative meaning in one place, or must it search broadly?

B. CONTROLLED BUSINESS CHANGE

11. What operations cause consequential business state to change?
12. Are those operations explicitly named?
13. Can the same result be achieved by directly assigning a field?
14. Can the same result be achieved by writing directly to the database?
15. Can the same result be achieved through an ORM bulk update?
16. Can ordinary application code skip prerequisite checks?
17. Are transition prerequisites centralized or repeated in multiple places?
18. Does an operation verify the current condition before applying a change?
19. Does it verify the expected version of the data?
20. Can two concurrent operations both believe they are legal?

C. DYNAMIC-OBJECT / PERMISSIVE-LANGUAGE RISK

21. Can arbitrary application code create objects that look like trusted domain objects?
22. Can a trusted object be distinguished mechanically from unvalidated JSON?
23. Can arbitrary properties be added to consequential objects?
24. Can business-critical properties be independently mutated?
25. Are important property combinations validated only at runtime?
26. Can an agent bypass type expectations using dynamic values, assertions, casts, or generic object shapes?
27. Are optional properties being used to represent mutually exclusive business conditions?
28. Does the system rely on naming conventions to distinguish verified from unverified data?
29. Can an object claim to be approved, verified, or authorized simply because a property contains that value?
30. Does deserialization produce trusted objects directly?

D. SQL AND PERSISTENCE BYPASS

31. Which database columns directly represent consequential business outcomes?
32. Who or what can update those columns?
33. Can application code issue direct UPDATE statements against them?
34. Can operational AI agents issue those updates?
35. Can ORM methods update them without invoking business rules?
36. Are there generic repository methods such as Save(), Update(), or Patch() that can alter them?
37. Can bulk updates bypass domain checks?
38. Can migration scripts alter live business state?
39. Can scheduled jobs change lifecycle values directly?
40. Can ETL/data-fix scripts create states the normal application cannot?
41. Do database CHECK constraints prevent important invalid combinations?
42. Are foreign-key constraints sufficient for business invariants, or only referential integrity?
43. Do stored procedures enforce the same prerequisites as the application?
44. Can triggers create behavior that an agent may miss when reading application code?
45. Can administrative SQL change business state without producing the same audit/evidence record as the normal operation?
46. Is persistence treated as storage behind the domain model or as an alternate business API?

E. ORM RISK

47. Can an ORM entity be modified and saved without invoking a named business operation?
48. Are ORM entities also used directly as domain objects?
49. Are public setters present because the ORM requires them?
50. Can tracked-object mutation cause consequential writes implicitly?
51. Can partial update/patch APIs bypass invariants?
52. Can bulk update features bypass hooks or validation?
53. Does loading an entity give application code permission to modify every persisted field?
54. Are lifecycle/status fields writable by generic mapping code?
55. Can an AI agent solve a feature request by modifying an ORM field rather than locating the intended domain operation?

F. PROTECTED AND TRUSTED VALUES

56. Which values represent authority or proof?
57. Can arbitrary application code construct those values?
58. Can they be created by deserialization?
59. Can they be copied and modified?
60. Are they distinguishable from ordinary data?
61. Does possession of such a value actually confer permission to perform an operation?
62. Is authority bound to a specific entity, state version, policy version, evidence version, or expiration time?
63. Can stale authority still be used?
64. Can an agent fabricate authority using a generic object constructor?

G. EXHAUSTIVE BUSINESS INTERPRETATION

65. When a new business condition is added, what forces existing logic to reconsider it?
66. Will the compiler fail?
67. Will an analyzer fail?
68. Will generated tests fail?
69. Will runtime validation fail?
70. Or must a developer search for affected code manually?
71. How often do switch/default/wildcard branches hide new cases?
72. Are unknown values rejected, ignored, or treated as a default?
73. Are database CASE expressions required to handle every meaningful case?
74. Are reports likely to silently classify a new condition incorrectly?
75. Can an agent add a default branch merely to eliminate a diagnostic?

H. FAILURE AND UNCERTAINTY

76. Are expected business failures represented explicitly?
77. Can the system distinguish success, failure, and outcome unknown?
78. What happens when an external call times out after the provider may have accepted the operation?
79. Can an AI agent retry automatically?
80. Does uncertain outcome remove the original capability?
81. Does the system create an explicit reconciliation obligation?
82. Are idempotency identifiers used?
83. Does the system distinguish retryable failure from unknown outcome?
84. Can an agent infer retry safety from a formal contract, or must it inspect implementation history?

I. CHANGE IMPACT VISIBILITY

85. If Approved is split into ConditionallyApproved and FullyApproved, what mechanically identifies affected behavior?
86. Does shipping logic surface?
87. Does accounting logic surface?
88. Does reporting logic surface?
89. Do agent tools surface?
90. Do policy checks surface?
91. Do database constraints surface?
92. Do scheduled jobs surface?
93. Does UI behavior surface?
94. Does the system produce an impact report?
95. How many affected interpretations can change silently?

J. SEMANTIC RECONSTRUCTION BURDEN

96. For a consequential change, how many files must an agent inspect before it can determine the relevant rule?
97. How many repository searches are normally required?
98. Are business rules discoverable from names?
99. Are rules duplicated?
100. Are tests the only reliable documentation?
101. Does the database contain rules not visible in application code?
102. Do stored procedures/triggers contain separate semantics?
103. Do operational scripts create additional meanings?
104. Can the system directly answer: What is true? What can happen next? Why? What is missing?
105. Or must the agent reconstruct those answers?

K. AI AGENT ESCAPE-ROUTE TESTING

106. Ask an agent: "Make the tests pass." Does it weaken the test?
107. Does it add a default branch?
108. Does it directly mutate a status?
109. Does it perform a direct SQL update?
110. Does it use an ORM shortcut?
111. Does it fabricate an approval/verification object?
112. Does it introduce any, dynamic, reflection, or an unchecked cast?
113. Does it suppress a compiler/analyzer warning?
114. Does it disable validation?
115. Does it broaden permissions?
116. Does it remove a concurrency/version check?
117. Does it follow the intended business operation instead?
118. How many lines of code are required for the correct path versus the shortcut?
119. Which path is more obvious from repository context?
120. Does CI detect the shortcut?

L. AI TOOL AND OPERATIONAL ACCESS

121. What tools are exposed to operational agents?
122. Are all tools exposed at all times?
123. Are legal actions derived from current business conditions?
124. Can an agent call a consequential action when prerequisites are missing?
125. Does the tool reject it mechanically?
126. Does the tool explain why?
127. Can the agent bypass the tool through shell/database access?
128. Are database credentials available to the agent?
129. Can tool access produce effects that the semantic layer cannot observe?
130. Are current unresolved obligations directly presented to the agent?

M. OBSERVABILITY AND AUDITABILITY

131. Can the company determine how a consequential state was reached?
132. Is there an explicit record of the operation that produced it?
133. Is the authority used recorded?
134. Is the policy version recorded?
135. Is supporting evidence recorded?
136. Are direct database changes distinguishable from controlled operations?
137. Can an AI-generated change remove or corrupt audit history?
138. Can a state be reconstructed from trusted events?

N. BOUNDARY VALIDATION

139. Are API inputs considered untrusted?
140. Are database reads automatically considered trusted?
141. Are messages from queues/events validated?
142. Is JSON validated before becoming authoritative domain data?
143. Do runtime schemas align with compile-time types?
144. Can invalid historical data enter a newly stricter model?
145. Does the system distinguish boundary DTOs from authoritative domain values?

O. GOVERNANCE OF AI-GENERATED CODE

146. Are AI-generated changes reviewed differently when they affect consequential business logic?
147. Can agents modify analyzers, generated semantic code, validation rules, or CI protections?
148. Are those files protected by repository policy?
149. Can an agent make a constraint disappear in the same pull request that requires satisfying it?
150. Are semantic-control changes independently reviewed?
151. Does the company measure how often AI changes weaken constraints?
152. Are direct database mutations reviewed as semantic changes?

======================================================================
QUESTIONS TO DEVELOP NEXT
======================================================================

The next research pass should convert the question bank into several evidence types:

1. Interview questions
2. Repository inspection questions
3. Database inspection questions
4. Adversarial agent tests
5. Quantitative metrics
6. Executive findings

Potential quantitative measures:

    mutation path count
    direct SQL write count
    mutable consequential-field count
    default/wildcard coverage
    unvalidated boundary count
    semantic reconstruction files
    escape-route success rate
    semantic change coverage

Example executive findings:

    "The application relies heavily on developers—and therefore AI coding agents—correctly reconstructing business semantics from implementation details."

    "We identified 17 ways to modify order lifecycle state. Only four enforce all documented eligibility requirements."

    "An AI coding agent can make an order appear shipped through a direct persistence update without satisfying payment or fraud prerequisites."

    "Critical domain meaning is represented independently in application objects, API payloads, and database columns, with no single authoritative semantic definition."

======================================================================
RESEARCH DIRECTION
======================================================================

The assessment should ultimately answer:

    How much critical business knowledge is the company currently asking AI models to infer?

    How many technically valid shortcuts exist around that knowledge?

    Which shortcuts are likely to be attractive to an AI coding agent?

    How much of the intended behavior is mechanically enforced?

    How much semantic authority is exposed through SQL, ORM, scripts, or generic mutation APIs?

    How difficult would it be to move the system from inference-dependent behavior toward mechanically constrained behavior without requiring a wholesale language rewrite?

The assessment should diagnose risk first.

It should not begin by prescribing:

    F#
    Rust
    functional programming
    state machines
    a rewrite

A JavaScript/SQL-heavy system may receive a poor score because its actual semantic controls are weak.

A carefully constrained TypeScript or JavaScript system may score reasonably well.

A C#, Java, or other statically typed system may still score poorly if it is essentially:

    mutable DTOs
    public setters
    generic ORM
    direct persistence access
    convention-only business rules

The assessment must measure the real architecture.

The broader principle is:

    For AI-maintained software, the safest architecture is one in which
    the easiest implementation path is also the semantically legal path.
