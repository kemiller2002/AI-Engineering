#!/usr/bin/env python3
"""Validate stable identifiers, local links, and the research frontier graph."""

from __future__ import annotations

import argparse
import json
import re
import sys
from collections import defaultdict
from pathlib import Path
from urllib.parse import unquote


ROOT = Path(__file__).resolve().parents[2]
FRONT_MATTER_ID = re.compile(r"^(?:id|identifier):\s*([^\s#]+)\s*$", re.MULTILINE)
MARKDOWN_LINK = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")
EXCLUDED_PARTS = {
    ".git",
    "archive",
    "input-documents",
}


def is_authored_markdown(path: Path, root: Path) -> bool:
    relative = path.relative_to(root)
    if any(part in EXCLUDED_PARTS for part in relative.parts):
        return False
    # Calibration outcomes intentionally preserve the source artifact identifier.
    return not (
        "research/evaluation/fixtures" in relative.as_posix()
        and ("outcomes" in relative.parts or "base" in relative.parts)
    )


def front_matter(text: str) -> str:
    if not text.startswith("---\n"):
        return ""
    end = text.find("\n---", 4)
    return text[4:end] if end >= 0 else ""


def collect_identifiers(root: Path) -> tuple[dict[str, list[str]], list[dict[str, str]]]:
    identifiers: dict[str, list[str]] = defaultdict(list)
    documents: list[dict[str, str]] = []
    for path in sorted(root.rglob("*.md")):
        if not is_authored_markdown(path, root):
            continue
        relative = path.relative_to(root).as_posix()
        match = FRONT_MATTER_ID.search(front_matter(path.read_text(encoding="utf-8")))
        if match:
            identifier = match.group(1)
            identifiers[identifier].append(relative)
            documents.append({"id": identifier, "path": relative})
    return dict(identifiers), documents


def local_link_target(raw_target: str) -> str | None:
    target = raw_target.strip()
    if target.startswith("<") and target.endswith(">"):
        target = target[1:-1]
    target = target.split(maxsplit=1)[0]
    if not target or target.startswith(("#", "http://", "https://", "mailto:")):
        return None
    return unquote(target.split("#", 1)[0].split("?", 1)[0])


def broken_local_links(root: Path) -> list[dict[str, str]]:
    broken: list[dict[str, str]] = []
    for path in sorted(root.rglob("*.md")):
        if not is_authored_markdown(path, root):
            continue
        text = path.read_text(encoding="utf-8")
        for match in MARKDOWN_LINK.finditer(text):
            target = local_link_target(match.group(1))
            if target is None:
                continue
            resolved = (root / target.lstrip("/")) if target.startswith("/") else (path.parent / target)
            if not resolved.resolve().exists():
                broken.append(
                    {
                        "source": path.relative_to(root).as_posix(),
                        "target": target,
                    }
                )
    return broken


def frontier_integrity(root: Path) -> dict[str, object]:
    records_dir = root / "research" / "frontier" / "records"
    index_path = root / "research" / "frontier" / "frontier-index.json"
    graph_path = root / "research" / "frontier" / "frontier-graph.json"
    if not records_dir.exists() or not index_path.exists() or not graph_path.exists():
        return {
            "available": False,
            "record_ids": [],
            "index_ids": [],
            "graph_nodes": [],
            "missing_from_index": [],
            "missing_record_files": [],
            "graph_node_mismatch": [],
            "invalid_edges": [],
        }

    record_ids: set[str] = set()
    for path in records_dir.glob("*.md"):
        match = FRONT_MATTER_ID.search(front_matter(path.read_text(encoding="utf-8")))
        if match:
            record_ids.add(match.group(1))
    index = json.loads(index_path.read_text(encoding="utf-8"))
    graph = json.loads(graph_path.read_text(encoding="utf-8"))
    index_ids = {record["id"] for record in index.get("records", [])}
    graph_nodes = set(graph.get("nodes", []))
    invalid_edges = [
        edge
        for edge in graph.get("edges", [])
        if edge.get("from") not in graph_nodes or edge.get("to") not in graph_nodes
    ]
    return {
        "available": True,
        "record_ids": sorted(record_ids),
        "index_ids": sorted(index_ids),
        "graph_nodes": sorted(graph_nodes),
        "missing_from_index": sorted(record_ids - index_ids),
        "missing_record_files": sorted(index_ids - record_ids),
        "graph_node_mismatch": sorted(graph_nodes ^ index_ids),
        "invalid_edges": invalid_edges,
    }


def validate(root: Path) -> dict[str, object]:
    identifiers, documents = collect_identifiers(root)
    duplicate_ids = {
        identifier: paths
        for identifier, paths in sorted(identifiers.items())
        if len(paths) > 1
    }
    frontier = frontier_integrity(root)
    broken_links = broken_local_links(root)
    passed = not (
        duplicate_ids
        or broken_links
        or frontier["missing_from_index"]
        or frontier["missing_record_files"]
        or frontier["graph_node_mismatch"]
        or frontier["invalid_edges"]
    )
    return {
        "schema_version": "1.0",
        "documents_with_identifiers": documents,
        "duplicate_identifiers": duplicate_ids,
        "broken_local_markdown_links": broken_links,
        "frontier": frontier,
        "passed": passed,
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", type=Path, default=ROOT)
    parser.add_argument("--inventory", type=Path)
    args = parser.parse_args()
    report = validate(args.root.resolve())
    rendered = json.dumps(report, indent=2, sort_keys=True) + "\n"
    if args.inventory:
        args.inventory.parent.mkdir(parents=True, exist_ok=True)
        args.inventory.write_text(rendered, encoding="utf-8")
    print(rendered, end="")
    return 0 if report["passed"] else 1


if __name__ == "__main__":
    sys.exit(main())
