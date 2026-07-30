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
        self.assertTrue(validate(self.root)["passed"])

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


if __name__ == "__main__":
    unittest.main()
