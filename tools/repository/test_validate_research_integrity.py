#!/usr/bin/env python3

import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from validate_research_integrity import validate  # noqa: E402


class ResearchIntegrityValidationTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.root = Path(self.temporary.name)
        records = self.root / "research" / "frontier" / "records"
        records.mkdir(parents=True)
        (records / "RFR-001.md").write_text(
            "---\nid: RFR-001\ntitle: Test\n---\n[Valid](../../../target.md)\n",
            encoding="utf-8",
        )
        (self.root / "target.md").write_text("# Target\n", encoding="utf-8")
        frontier = self.root / "research" / "frontier"
        (frontier / "frontier-index.json").write_text(
            json.dumps({"records": [{"id": "RFR-001"}]}), encoding="utf-8"
        )
        (frontier / "frontier-graph.json").write_text(
            json.dumps({"nodes": ["RFR-001"], "edges": []}), encoding="utf-8"
        )

    def tearDown(self):
        self.temporary.cleanup()

    def test_valid_repository_passes(self):
        report = validate(self.root)
        self.assertTrue(report["passed"])
        self.assertEqual(2, report["metadata_coverage"]["overall"]["documents"])
        self.assertEqual(1, report["metadata_coverage"]["overall"]["with_identifier"])

    def test_seeded_duplicate_identifier_is_detected(self):
        (self.root / "duplicate.md").write_text(
            "---\nidentifier: RFR-001\n---\n", encoding="utf-8"
        )
        report = validate(self.root)
        self.assertFalse(report["passed"])
        self.assertIn("RFR-001", report["duplicate_identifiers"])

    def test_seeded_broken_link_is_detected(self):
        (self.root / "broken.md").write_text("[Missing](absent.md)\n", encoding="utf-8")
        report = validate(self.root)
        self.assertFalse(report["passed"])
        self.assertEqual("absent.md", report["broken_local_markdown_links"][0]["target"])

    def test_seeded_invalid_graph_edge_is_detected(self):
        graph = self.root / "research" / "frontier" / "frontier-graph.json"
        graph.write_text(
            json.dumps(
                {
                    "nodes": ["RFR-001"],
                    "edges": [
                        {"from": "RFR-001", "to": "RFR-999", "type": "prerequisite"}
                    ],
                }
            ),
            encoding="utf-8",
        )
        report = validate(self.root)
        self.assertFalse(report["passed"])
        self.assertEqual("RFR-999", report["frontier"]["invalid_edges"][0]["to"])

    def test_metadata_coverage_is_measured_by_artifact_class(self):
        content = self.root / "content"
        content.mkdir()
        (content / "complete.md").write_text(
            "---\nid: DOC-001\ntitle: Complete\nabstract: Test\n---\n",
            encoding="utf-8",
        )
        report = validate(self.root)
        content_coverage = report["metadata_coverage"]["by_artifact_class"]["content"]
        self.assertEqual(1, content_coverage["documents"])
        self.assertEqual(1, content_coverage["field_counts"]["abstract"])
        self.assertTrue(report["passed"])

    def test_relationship_targets_resolve_by_identifier_or_path(self):
        (self.root / "relationships.md").write_text(
            "---\n"
            "id: DOC-001\n"
            "related: [RFR-001, target.md, MISSING-001]\n"
            "supersedes: []\n"
            "---\n",
            encoding="utf-8",
        )
        report = validate(self.root)
        relationships = report["relationship_integrity"]
        self.assertEqual(3, relationships["declared_count"])
        self.assertEqual(2, relationships["resolved_count"])
        self.assertEqual("MISSING-001", relationships["unresolved"][0]["target"])
        self.assertTrue(report["passed"])

    def test_generated_and_dependency_trees_are_excluded(self):
        for directory in ("node_modules", "dist", "build-reports"):
            path = self.root / directory
            path.mkdir()
            (path / "broken.md").write_text("[Missing](absent.md)\n", encoding="utf-8")
        report = validate(self.root)
        self.assertEqual([], report["broken_local_markdown_links"])
        self.assertTrue(report["passed"])


if __name__ == "__main__":
    unittest.main()
