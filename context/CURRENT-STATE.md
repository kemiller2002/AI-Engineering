# ROS Current-State Entry Point

The authoritative repository state is [`../CURRENT-STATE.md`](../CURRENT-STATE.md).
This file is a compact ROS-oriented entry point and must not be maintained as a
second canonical project-state record.

## Current summary

- The repository is evaluating long-horizon repository agents through
  evidence-traceable pilots and grader validation.
- Evaluation Cycles 001–003 and the non-human comparative review are complete;
  independent review and frozen-grader unseen testing are next.
- Pre-ROS material history is reconstructed in
  [`../docs/repository/ros-migration/HISTORICAL-WORK-INDEX.md`](../docs/repository/ros-migration/HISTORICAL-WORK-INDEX.md).
- Live ROS workflow state is stored in `.ros/context/current.json`; live events
  and explicit historical attribution remain separate.

## Resume

Read root `CURRENT-STATE.md`, then run:

```bash
./ros status
./ros work context
```
