# AI-ROS Evaluation Tools

`evalctl.py` validates task contracts and calibrates deterministic graders against known probe outcomes. It uses only the Python standard library.

## Commands

```bash
python3 tools/evaluation/evalctl.py validate
python3 tools/evaluation/evalctl.py calibrate
python3 tools/evaluation/evalctl.py all
python3 tools/evaluation/evalctl.py grade --task ET-004-P01 --outcome complete
python3 tools/evaluation/evalctl.py prepare --output /path/to/new/disposable-directory
python3 tools/evaluation/evalctl.py repo-audit
```

## Interpretation

- `validate` checks fixture contracts and required probe outcomes.
- `calibrate` compares grader classifications with predeclared expected classes.
- `grade` evaluates one outcome and returns a nonzero status when it is not complete/valid.
- `prepare` exports blind agent-readable fixtures without expected outcomes or grader code. It refuses to overwrite an existing task directory.
- `repo-audit` fails when Git tracks paths that differ only by letter case, when authored artifacts reuse a stable identifier, when an explicit local Markdown link is broken, or when frontier record/index/graph identifiers disagree.
- `all` runs task validation, probe calibration, and the repository case-collision audit.

The research-integrity validator can also write its machine-readable inventory:

```bash
python3 tools/repository/validate_research_integrity.py \
  --inventory data/validation/research-integrity-inventory.json
```

Calibration fixtures under `research/evaluation/fixtures/*/{base,outcomes}/` are
excluded from global identifier collision checks because those snapshots
intentionally preserve the source artifact identifier.

Passing calibration proves only that the grader distinguishes the supplied probes. It does not prove task validity, grader generalization, or agent capability.

## Safety

The current fixtures contain no secrets, execute no untrusted code, make no network requests, and modify no external systems. Future agent runners must use disposable directories and separate agent permissions from grader permissions.
