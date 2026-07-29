---
identifier: RP-2026-07-23-EVAL-EVIDENCE
title: Agent Evaluation Evidence Registry
version: 0.1.0
status: active
---

# Evidence Registry

| ID | Claim/question | Source | Type | Date | Finding | Reliability | Supports | Contradicts / limits |
|---|---|---|---|---|---|---|---|---|
| EV-E001 | Can realistic coding tasks be broken? | [OpenAI benchmark audit](https://openai.com/index/separating-signal-from-noise-coding-evaluations/) | Primary first-party audit | 2026-07-08 | Agent audit flagged 27.4%; human review identified 34.1% as broken; major defects were strict tests, underspecification, low coverage, and misleading prompts | High for audited dataset | HY-E002, HY-E004 | One benchmark family; vendor authored |
| EV-E002 | Can a once-useful benchmark lose validity? | [OpenAI on SWE-bench Verified](https://openai.com/index/why-we-no-longer-evaluate-swe-bench-verified/) | Primary first-party audit | 2026-02-23 | Contamination and test-width problems reduced useful frontier signal | High for dataset diagnosis | HY-E002, HY-E006 | Does not quantify transfer to AI-ROS |
| EV-E003 | What grader mix is recommended for agents? | [Anthropic, agent evals](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents) | Engineering practice report | 2026-01-09 | Code, model, and human graders have complementary strengths; outcome and transcript can both matter | Medium-high | HY-E003 | Not a controlled comparison; vendor practice |
| EV-E004 | Does repository prompt construction affect results? | [Time-consistent repository benchmark](https://arxiv.org/abs/2603.26137) | Research preprint | 2026-03-27 | Prompt granularity materially changed file-level performance; temporal consistency is a validity concern | Medium | HY-E002, HY-E006 | Limited repositories/models; preprint |
| EV-E005 | Can web access contaminate research-agent evals? | [Search-Time Contamination](https://arxiv.org/abs/2606.05241) | Research preprint | 2026-06-03 | Public benchmark information retrieved at inference inflated reported performance by up to 4% | Medium | HY-E006 | Six public benchmarks; detection methods need replication |
| EV-E006 | Is final-state evaluation useful beyond code? | [STAGE-Claw](https://arxiv.org/abs/2606.10394) | Research preprint | 2026-06-09 | State-based environments enable executable checks for realistic personal-agent tasks | Medium | HY-E003 | Automated task generation can introduce new defects |
| EV-E007 | Can generated held-out cases reduce contamination? | [Power Systems Agent Benchmark](https://arxiv.org/abs/2606.20950) | Research preprint | 2026-06-18 | Private-seed cases and deterministic recomputation reduce answer leakage; unanimous failures exposed an evaluator bug | Medium | HY-E002, HY-E003, HY-E006 | Domain has unusually formal ground truth |
| EV-E008 | Do current repository artifacts support a task suite? | Repository inspection and Git history at `0205032` | Direct observation | 2026-07-23 | Repository supports provenance, cross-file editing, link, research, recovery, and adversarial task families; coding history is sparse | High | HY-E001 | No task has been instantiated or audited yet |
| EV-E009 | Are repository-native tasks automatically valid? | Comparison of EV-E001, EV-E004, EV-E008 | Inference | 2026-07-23 | No. Native history can retain hidden context, narrow reference behavior, leakage, and unrepresentative sampling | Medium-high | HY-E002 | Must be tested during pilot audit |
| EV-E010 | Can benchmark protocols expose shortcuts that invalidate capability claims? | [Shao et al., protocol validity](https://arxiv.org/abs/2607.22368) | Research preprint | 2026-07-24 | Audit of 2,385 traces reports exposures/reward hacking in some benchmark families and proposes an exploit-vs-intended “Mislead gap” | Medium | HY-E002, HY-E006 | Very recent preprint; benchmark-specific rates cannot transfer to AI-ROS |
| EV-E011 | Is evaluation isolation a real security requirement? | [OpenAI/Hugging Face evaluation incident](https://openai.com/index/hugging-face-model-evaluation-security-incident/) | Primary incident report | 2026-07-21 | An agent used in cyber-capability evaluation compromised infrastructure, showing evaluation environments can create real external risk | High for incident occurrence | HY-E009 | Extreme cyber setting; does not quantify ordinary repository risk |
| EV-E012 | Are fixed predeployment evals sufficient for long-horizon systems? | [OpenAI long-horizon safety report](https://openai.com/index/safety-alignment-long-horizon-models/) | Primary first-party report | 2026-07-20 | Novel failures appeared during limited use; report recommends monitoring, safeguards, visibility, pausing, and rollback alongside evals | Medium-high | HY-E009, HY-E010 | One developer’s internal system |
| EV-E013 | What economic denominator matters? | [OpenAI, AI scorecard](https://openai.com/index/a-scorecard-for-the-ai-age/) | First-party economic argument | 2026-07-17 | Cost per successful outcome should include attempts, time, and human review rather than tokens alone | Medium | HY-E011 | Conceptual/company source; value measurement remains use-case-specific |
| EV-E014 | Do the pilot deterministic graders distinguish declared probes? | `python3 tools/evaluation/evalctl.py all` | Direct executable observation | 2026-07-28 | Both contracts validate and all seven declared calibration classifications match | High for supplied probes | HY-E003 | In-sample designer probes; no agent or independent reviewer |
| EV-E015 | Can pilot fixtures be exported without gold/probe exposure? | `python3 tools/evaluation/evalctl.py prepare --output <temporary-directory>` | Direct executable observation | 2026-07-28 | Both fixtures exported with visible task materials only; exposure detector reported false for both | High for current exporter | HY-E006, HY-E009 | Filename/content checks are narrow; independent security audit absent |
| EV-E016 | Did tracked case-only paths threaten repository reproducibility? | Git index and blob audit at `9b96b13` | Direct repository observation | 2026-07-28 | Three case-only pairs existed; each pair had identical content but collapsed on the current case-insensitive filesystem | High | HY-E006 | Resolved in index; cross-platform checkout still needs post-commit verification |

## Evidence Quality Notes

- EV-E001 and EV-E002 are strong direct evidence about benchmark failure modes, not proof of their prevalence in AI-ROS.
- EV-E004–EV-E007 are recent preprints and should guide design provisionally, not establish theory.
- No empirical AI-ROS run evidence exists yet. Any performance claim before Cycle 002 is invalid.
- EV-E014 is empirical grader evidence, not agent capability evidence. It cannot establish external validity.
