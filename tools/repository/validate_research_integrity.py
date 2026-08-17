#!/usr/bin/env python3
"""Validate repository research integrity and measure metadata adoption."""

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
    ".research-publisher",
    "archive",
    "build-reports",
    "dist",
    "input-documents",
    "node_modules",
}
REQUIRED_METADATA_FIELDS = (
    "id",
    "title",
    "abstract",
    "author",
    "date",
    "discipline",
    "project",
    "research_area",
    "document_type",
    "status",
    "confidence",
    "evidence_level",
    "canonical",
    "tags",
    "keywords",
    "related",
    "supersedes",
    "superseded_by",
    "reading_time_minutes",
)
RELATIONSHIP_FIELDS = ("related", "related_documents", "supersedes", "superseded_by")


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


def parse_front_matter(text: str) -> dict[str, object]:
    """Parse the simple top-level YAML forms used by repository metadata."""
    parsed: dict[str, object] = {}
    current_list: str | None = None
    for raw_line in front_matter(text).splitlines():
        if raw_line.startswith("  - ") and current_list:
            value = raw_line[4:].strip().strip("'\"")
            cast = parsed.setdefault(current_list, [])
            if isinstance(cast, list) and value:
                cast.append(value)
            continue
        match = re.match(r"^([A-Za-z_][A-Za-z0-9_]*):(?:\s*(.*))?$", raw_line)
        if not match:
            current_list = None
            continue
        key, raw_value = match.group(1), (match.group(2) or "").strip()
        current_list = key if not raw_value else None
        if not raw_value:
            parsed[key] = []
        elif raw_value in {"null", "~"}:
            parsed[key] = None
        elif raw_value.startswith("[") and raw_value.endswith("]"):
            body = raw_value[1:-1].strip()
            parsed[key] = (
                [item.strip().strip("'\"") for item in body.split(",") if item.strip()]
                if body
                else []
            )
        else:
            parsed[key] = raw_value.strip("'\"")
    if "identifier" in parsed and "id" not in parsed:
        parsed["id"] = parsed["identifier"]
    return parsed


def authored_markdown_paths(root: Path) -> list[Path]:
    return [
        path
        for path in sorted(root.rglob("*.md"))
        if is_authored_markdown(path, root)
    ]


def artifact_class(path: Path, root: Path) -> str:
    relative = path.relative_to(root)
    return relative.parts[0] if len(relative.parts) > 1 else "repository-root"


def metadata_coverage(root: Path) -> dict[str, object]:
    paths = authored_markdown_paths(root)
    grouped: dict[str, list[dict[str, object]]] = defaultdict(list)
    all_documents: list[dict[str, object]] = []
    for path in paths:
        metadata = parse_front_matter(path.read_text(encoding="utf-8"))
        item = {
            "path": path.relative_to(root).as_posix(),
            "has_front_matter": bool(front_matter(path.read_text(encoding="utf-8"))),
            "fields": sorted(metadata),
        }
        grouped[artifact_class(path, root)].append(item)
        all_documents.append(item)

    def summarize(documents: list[dict[str, object]]) -> dict[str, object]:
        total = len(documents)
        counts = {
            field: sum(field in document["fields"] for document in documents)
            for field in REQUIRED_METADATA_FIELDS
        }
        return {
            "documents": total,
            "with_front_matter": sum(bool(document["has_front_matter"]) for document in documents),
            "with_identifier": counts["id"],
            "field_counts": counts,
            "field_percentages": {
                field: round((count / total * 100), 1) if total else 0.0
                for field, count in counts.items()
            },
        }

    return {
        "policy": "measurement-only; missing metadata does not fail validation",
        "required_fields": list(REQUIRED_METADATA_FIELDS),
        "overall": summarize(all_documents),
        "by_artifact_class": {
            name: summarize(documents) for name, documents in sorted(grouped.items())
        },
    }


def declared_relationships(root: Path, identifiers: dict[str, list[str]]) -> dict[str, object]:
    relationships: list[dict[str, object]] = []
    unresolved: list[dict[str, str]] = []
    known_ids = set(identifiers)
    for path in authored_markdown_paths(root):
        relative = path.relative_to(root).as_posix()
        metadata = parse_front_matter(path.read_text(encoding="utf-8"))
        for field in RELATIONSHIP_FIELDS:
            raw_values = metadata.get(field)
            if raw_values in (None, "", []):
                continue
            values = raw_values if isinstance(raw_values, list) else [raw_values]
            for value in values:
                target = str(value)
                by_id = target in known_ids
                candidate = root / target.lstrip("/")
                by_path = candidate.exists()
                resolved = by_id or by_path
                item = {
                    "source": relative,
                    "field": field,
                    "target": target,
                    "resolved": resolved,
                    "resolution": "id" if by_id else ("path" if by_path else None),
                }
                relationships.append(item)
                if not resolved:
                    unresolved.append({"source": relative, "field": field, "target": target})
    return {
        "policy": "diagnostic-only until identifier adoption and migration policy are approved",
        "declared_count": len(relationships),
        "resolved_count": len(relationships) - len(unresolved),
        "unresolved_count": len(unresolved),
        "relationships": relationships,
        "unresolved": unresolved,
    }


def collect_identifiers(root: Path) -> tuple[dict[str, list[str]], list[dict[str, str]]]:
    identifiers: dict[str, list[str]] = defaultdict(list)
    documents: list[dict[str, str]] = []
    for path in authored_markdown_paths(root):
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
    for path in authored_markdown_paths(root):
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
    coverage = metadata_coverage(root)
    relationships = declared_relationships(root, identifiers)
    passed = not (
        duplicate_ids
        or broken_links
        or frontier["missing_from_index"]
        or frontier["missing_record_files"]
        or frontier["graph_node_mismatch"]
        or frontier["invalid_edges"]
    )
    return {
        "schema_version": "1.1",
        "documents_with_identifiers": documents,
        "duplicate_identifiers": duplicate_ids,
        "broken_local_markdown_links": broken_links,
        "metadata_coverage": coverage,
        "relationship_integrity": relationships,
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
