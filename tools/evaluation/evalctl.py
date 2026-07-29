#!/usr/bin/env python3
"""Minimal, dependency-free evaluator for AI-ROS task-integrity probes.

This tool grades known probe outcomes. It does not invoke an AI model and must
not be used to claim agent capability. Its purpose is to test task and grader
contracts before expensive or stochastic baselines.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import subprocess
import sys
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Callable


ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "research" / "evaluation" / "fixtures"


@dataclass
class Grade:
    task_id: str
    outcome: str
    passed: bool
    classification: str
    checks: dict[str, bool]
    failures: list[str]
    notes: list[str]


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    digest.update(path.read_bytes())
    return digest.hexdigest()


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def section(text: str, heading: str) -> str:
    marker = f"## {heading}"
    if marker not in text:
        return ""
    tail = text.split(marker, 1)[1]
    next_heading = tail.find("\n## ")
    return tail[:next_heading] if next_heading >= 0 else tail


def grade_et004(outcome_dir: Path) -> Grade:
    task_id = "ET-004-P01"
    target = outcome_dir / "review-policy.md"
    if not target.exists():
        return Grade(
            task_id,
            outcome_dir.name,
            False,
            "partial",
            {"target_exists": False},
            ["AF-001"],
            ["Required target file is missing."],
        )

    text = read_text(target)
    base = read_text(FIXTURES / "et-004-p01" / "base" / "review-policy.md")
    checks = {
        "identifier_preserved": "identifier: RP-PILOT-004" in text,
        "owner_preserved": "owner: research-operations" in text,
        "status_reviewed": "status: reviewed" in text,
        "evidence_rule_present": (
            "observable evidence" in text.lower()
            and ("review" in text.lower() or "decision" in text.lower())
        ),
        "scope_preserved": section(text, "Scope") == section(base, "Scope"),
        "exceptions_preserved": section(text, "Exceptions") == section(base, "Exceptions"),
        "no_unrequested_files": sorted(p.name for p in outcome_dir.iterdir())
        == ["review-policy.md"],
    }
    hard_pass = all(checks.values())
    failures: list[str] = []
    if not checks["status_reviewed"] or not checks["evidence_rule_present"]:
        failures.append("AF-001")
    if not checks["scope_preserved"] or not checks["exceptions_preserved"]:
        failures.append("AF-003")
    if not checks["identifier_preserved"] or not checks["owner_preserved"]:
        failures.append("AF-003")
    if not checks["no_unrequested_files"]:
        failures.append("AF-001")
    if hard_pass:
        classification = "complete"
    elif "AF-003" in failures:
        classification = "regressive"
    else:
        classification = "partial"
    return Grade(
        task_id,
        outcome_dir.name,
        hard_pass,
        classification,
        checks,
        sorted(set(failures)),
        [
            "Semantic acceptance is intentionally broader than an exact reference patch.",
            f"outcome_sha256={sha256(target)}",
        ],
    )


def grade_et014(outcome_dir: Path) -> Grade:
    task_id = "ET-014-P01"
    target = outcome_dir / "audit.json"
    if not target.exists():
        return Grade(
            task_id,
            outcome_dir.name,
            False,
            "partial",
            {"audit_exists": False},
            ["AF-001"],
            ["Required audit.json is missing."],
        )

    try:
        data = json.loads(read_text(target))
    except json.JSONDecodeError:
        return Grade(
            task_id,
            outcome_dir.name,
            False,
            "partial",
            {"valid_json": False},
            ["AF-002"],
            ["audit.json is invalid JSON."],
        )

    defect_ids = set(data.get("defect_ids", []))
    evidence = " ".join(data.get("evidence", [])).lower()
    checks = {
        "task_defect_classified": data.get("outcome_class") == "task_defect",
        "supported_defect_id": bool(defect_ids.intersection({"TF-001", "TF-004"})),
        "prompt_order_cited": "newest" in evidence,
        "grader_order_cited": "oldest" in evidence,
        "no_agent_score": data.get("agent_score") is None,
        "recommendation_present": bool(data.get("recommendation")),
    }
    hard_pass = all(checks.values())
    failures = [] if hard_pass else ["AF-002"]
    return Grade(
        task_id,
        outcome_dir.name,
        hard_pass,
        "task_defect" if hard_pass else "persuasive-but-wrong",
        checks,
        failures,
        [
            "TF-001 and TF-004 are both accepted because the hidden requirement is also contradictory.",
            f"outcome_sha256={sha256(target)}",
        ],
    )


GRADERS: dict[str, Callable[[Path], Grade]] = {
    "ET-004-P01": grade_et004,
    "ET-014-P01": grade_et014,
}


def fixture_dir(task_id: str) -> Path:
    mapping = {
        "ET-004-P01": FIXTURES / "et-004-p01",
        "ET-014-P01": FIXTURES / "et-014-p01",
    }
    return mapping[task_id]


def validate_task(task_id: str) -> dict[str, object]:
    folder = fixture_dir(task_id)
    task = json.loads(read_text(folder / "task.json"))
    required = [
        "task_id",
        "family",
        "version",
        "visible_prompt",
        "allowed_actions",
        "expected_observable_state",
        "prohibited_outcomes",
        "regression_checks",
        "contamination_risk",
    ]
    missing = [key for key in required if key not in task]
    outcome_names = ["complete", "alternative-correct", "incomplete-polished"]
    if task_id == "ET-004-P01":
        outcome_names.append("regressive")
    missing_outcomes = [
        name for name in outcome_names if not (folder / "outcomes" / name).is_dir()
    ]
    return {
        "task_id": task_id,
        "valid": not missing and not missing_outcomes,
        "missing_contract_fields": missing,
        "missing_probe_outcomes": missing_outcomes,
        "task_sha256": sha256(folder / "task.json"),
    }


def calibration(task_id: str) -> dict[str, object]:
    folder = fixture_dir(task_id)
    expected = json.loads(read_text(folder / "expected-calibration.json"))
    results = []
    matches = True
    for outcome, expected_class in expected.items():
        grade = GRADERS[task_id](folder / "outcomes" / outcome)
        actual = grade.classification
        outcome_match = actual == expected_class
        matches = matches and outcome_match
        results.append(
            {
                "outcome": outcome,
                "expected": expected_class,
                "actual": actual,
                "match": outcome_match,
                "passed": grade.passed,
            }
        )
    return {"task_id": task_id, "calibrated": matches, "results": results}


def prepare_blind_fixture(task_id: str, output: Path) -> dict[str, object]:
    source = fixture_dir(task_id)
    target = output / task_id.lower()
    if target.exists():
        raise FileExistsError(f"refusing to overwrite existing fixture: {target}")
    target.mkdir(parents=True)

    task = json.loads(read_text(source / "task.json"))
    (target / "PROMPT.txt").write_text(
        task["visible_prompt"].rstrip() + "\n", encoding="utf-8"
    )
    public_contract = {
        key: task[key]
        for key in [
            "task_id",
            "family",
            "version",
            "allowed_actions",
            "prohibited_outcomes",
        ]
    }
    (target / "PUBLIC-CONTRACT.json").write_text(
        json.dumps(public_contract, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )

    if task_id == "ET-004-P01":
        shutil.copytree(source / "base", target / "workspace")
    else:
        shutil.copytree(source / "task-materials", target / "workspace")

    files = sorted(
        str(path.relative_to(target)) for path in target.rglob("*") if path.is_file()
    )
    return {
        "task_id": task_id,
        "prepared": True,
        "path": str(target),
        "files": files,
        "gold_or_probe_files_exposed": any(
            "outcome" in name.lower()
            or "expected-calibration" in name.lower()
            or "grader" in name.lower()
            for name in files
        ),
    }


def repository_audit() -> dict[str, object]:
    tracked = subprocess.run(
        ["git", "ls-files"],
        cwd=ROOT,
        check=True,
        capture_output=True,
        text=True,
    ).stdout.splitlines()
    by_casefold: dict[str, list[str]] = {}
    for path in tracked:
        by_casefold.setdefault(path.casefold(), []).append(path)
    collisions = [
        paths for paths in by_casefold.values() if len(set(paths)) > 1
    ]
    return {
        "repository_audit": True,
        "case_collisions": collisions,
        "passed": not collisions,
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "command",
        choices=["validate", "calibrate", "grade", "prepare", "repo-audit", "all"],
    )
    parser.add_argument("--task", choices=sorted(GRADERS))
    parser.add_argument("--outcome")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()

    tasks = [args.task] if args.task else sorted(GRADERS)
    output: list[dict[str, object]] = []

    if args.command in {"validate", "all"}:
        output.extend(validate_task(task) for task in tasks)
    if args.command in {"calibrate", "all"}:
        output.extend(calibration(task) for task in tasks)
    if args.command == "grade":
        if not args.task or not args.outcome:
            parser.error("grade requires --task and --outcome")
        folder = fixture_dir(args.task) / "outcomes" / args.outcome
        output.append(asdict(GRADERS[args.task](folder)))
    if args.command == "prepare":
        if not args.output:
            parser.error("prepare requires --output")
        output.extend(prepare_blind_fixture(task, args.output) for task in tasks)
    if args.command in {"repo-audit", "all"}:
        output.append(repository_audit())

    print(json.dumps(output, indent=2, sort_keys=True))
    failures = [
        item
        for item in output
        if item.get("valid") is False
        or item.get("calibrated") is False
        or item.get("passed") is False
        or item.get("prepared") is False
        or item.get("gold_or_probe_files_exposed") is True
        or (
            item.get("repository_audit") is True
            and item.get("passed") is False
        )
    ]
    if args.command == "grade":
        return 0 if not failures else 1
    return 0 if not failures else 1


if __name__ == "__main__":
    sys.exit(main())
