import test from "node:test";
import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { execFileSync } from "node:child_process";
import { validate, validateHistoricalRecords } from "./ros_cli.mjs";

function repository() {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "ros-history-test-"));
  execFileSync("git", ["init", "-q", root]);
  execFileSync("git", ["-C", root, "config", "user.name", "ROS Test"]);
  execFileSync("git", ["-C", root, "config", "user.email", "ros-test@example.invalid"]);
  fs.writeFileSync(path.join(root, "seed.txt"), "seed\n");
  execFileSync("git", ["-C", root, "add", "seed.txt"]);
  execFileSync("git", ["-C", root, "commit", "-q", "-m", "seed"]);
  const commit = execFileSync("git", ["-C", root, "rev-parse", "HEAD"], { encoding: "utf8" }).trim();
  fs.mkdirSync(path.join(root, ".ros", "history"), { recursive: true });
  return { root, commit };
}

function record(commit, fields = {}) {
  return {
    schemaVersion: "1.0.0",
    migrationId: "HWM-001",
    workItem: "HIST-TEST-WORK",
    originalWorkItem: "LEGACY-42",
    title: "Historical test work",
    workType: "maintenance",
    semanticState: "complete",
    historical: true,
    reconstructionMethod: "compatibility-preserved",
    confidence: "high",
    commits: [commit],
    paths: ["seed.txt"],
    evidence: ["seed.txt"],
    decisions: [],
    occurredAt: {
      start: "2026-01-01T00:00:00Z",
      end: "2026-01-01T00:00:00Z",
      timeConfidence: "exact"
    },
    migratedAt: "2026-08-17T00:00:00Z",
    notes: "Test fixture",
    ...fields
  };
}

function write(root, records) {
  fs.writeFileSync(
    path.join(root, ".ros", "history", "historical-work.jsonl"),
    `${records.map((item) => JSON.stringify(item)).join("\n")}\n`
  );
}

test("valid historical records parse and preserve legacy compatibility metadata", () => {
  const { root, commit } = repository();
  write(root, [record(commit)]);
  const result = validateHistoricalRecords(root);
  assert.deepEqual(result.findings, []);
  assert.equal(result.records[0].originalWorkItem, "LEGACY-42");
});

test("duplicate migration IDs fail", () => {
  const { root, commit } = repository();
  write(root, [record(commit), record(commit)]);
  const result = validateHistoricalRecords(root);
  assert.ok(result.findings.some((item) => item.field === "migrationId" && item.message.includes("duplicate")));
});

test("malformed and unknown commits fail when Git history is available", () => {
  const malformed = repository();
  write(malformed.root, [record(malformed.commit, { commits: ["not-a-hash"] })]);
  assert.ok(validateHistoricalRecords(malformed.root).findings.some((item) => item.message.includes("malformed commit")));

  const unknown = repository();
  write(unknown.root, [record(unknown.commit, { commits: ["0".repeat(40)] })]);
  assert.ok(validateHistoricalRecords(unknown.root).findings.some((item) => item.message.includes("unknown commit")));
});

test("invalid semantic states fail", () => {
  const { root, commit } = repository();
  write(root, [record(commit, { semanticState: "historical-complete" })]);
  assert.ok(validateHistoricalRecords(root).findings.some((item) => item.field === "semanticState"));
});

test("historical records cannot claim live transition authority", () => {
  const { root, commit } = repository();
  write(root, [record(commit, { type: "work.completed", eventId: "synthetic" })]);
  const findings = validateHistoricalRecords(root).findings;
  assert.ok(findings.some((item) => item.field === "type" && item.message.includes("live transition")));
  assert.ok(findings.some((item) => item.field === "eventId" && item.message.includes("live transition")));
});

test("only valid history can satisfy dirty-path attribution", () => {
  const valid = repository();
  fs.writeFileSync(path.join(valid.root, "ros.json"), JSON.stringify({
    repository: { id: "history-test" },
    workProtocol: {
      enforceAttribution: true,
      meaningfulPaths: ["**"],
      ignoredPaths: [".git/**", ".ros/**", "ros.json"]
    }
  }));
  execFileSync("git", ["-C", valid.root, "add", "ros.json"]);
  execFileSync("git", ["-C", valid.root, "commit", "-q", "-m", "add ros config"]);
  const attributedCommit = execFileSync("git", ["-C", valid.root, "rev-parse", "HEAD"], { encoding: "utf8" }).trim();
  write(valid.root, [record(attributedCommit)]);
  fs.writeFileSync(path.join(valid.root, "seed.txt"), "changed\n");
  assert.deepEqual(validate(valid.root, { checkRegistries: false }), []);

  write(valid.root, [record(attributedCommit, { semanticState: "invalid" })]);
  const invalidFindings = validate(valid.root, { checkRegistries: false });
  assert.ok(invalidFindings.some((item) => item.field === "semanticState"));
  assert.ok(invalidFindings.some((item) => item.field === "work_items" && item.path === "seed.txt"));
});
