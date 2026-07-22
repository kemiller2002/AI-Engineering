# Working Copy Setup

## Purpose

Working Copy is the Git-aware mobile layer. It stores a local clone in its iOS app container and exposes supported repositories through the Files document-provider interface.

## Setup

1. Create a private GitHub repository named `ai-research-os`.
2. Open Working Copy and add your GitHub account.
3. Clone the repository.
4. Copy the contents of this bootstrap kit into the repository.
5. In Working Copy, review all changed files.
6. Commit with `chore: bootstrap AI-ROS repository`.
7. Push to GitHub.

## Files Access

In Apple Files, look under:

`Browse → Locations → Working Copy → ai-research-os`

The exact display may vary by iOS version. The repository remains controlled by Working Copy even when another app edits a file through Files.

## Operating Rules

- Pull before beginning work on another device.
- Review diffs before every commit.
- Use branches for large or risky changes.
- Do not keep uncommitted changes indefinitely.
- Push accepted work so the mobile clone is not the only copy.
