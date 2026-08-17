# ROS Historical Attribution

This directory contains explicit historical backfill. Its JSONL records describe
work observed before ROS was installed; they are not live ROS events and do not
assert that the original work followed ROS.

## Format

- Schema: `schemas/historical-work.schema.json`
- Current schema version: `1.0.0`
- Records: `historical-work.jsonl`, one JSON object per line
- Human index: `docs/repository/ros-migration/HISTORICAL-WORK-INDEX.md`

`occurredAt` uses Git author timestamps when a record is reconstructed from
commits. Those timestamps are exact observations from Git, not proof of the
actual beginning or end of the underlying human work. `migratedAt` is the time
the backfill was recorded.

Historical records may attribute paths for validation, but they cannot contain
live transition fields such as `eventId`, `type`, `transition`, `targetState`,
or `publication`. Live transitions remain exclusively in
`.ros/events/events.jsonl`.

Run `./ros validate` to validate syntax, unique migration IDs, semantic states,
commit existence, and the live/historical authority boundary.
