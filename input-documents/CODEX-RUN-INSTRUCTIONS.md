# Run AI-ROS Bootstrap with Codex

## Option A — New repository in Codespaces

1. Create an empty private GitHub repository.
2. Open a Codespace for it.
3. Upload `bootstrap-ai-ros.sh` to the Codespace.
4. Run:

```bash
chmod +x bootstrap-ai-ros.sh
./bootstrap-ai-ros.sh ai-research-os
cd ai-research-os
./setup.sh
```

5. If the bootstrap created a nested repository but you want the current repository root instead, run it from the parent directory or copy the generated files to the intended root before pushing.
6. Add the GitHub remote and push:

```bash
git remote add origin <YOUR_GITHUB_REPOSITORY_URL>
git push -u origin main
```

## Option B — Let Codex execute it

Give Codex this instruction:

```text
Run ./bootstrap-ai-ros.sh ai-research-os. Do not merely describe the result. Inspect every generated file, run ./setup.sh, run python3 tools/validate.py, and report actual command output. Then execute the iterative review in codex/tasks/TASK-001-FOUNDATION-REVIEW.md using prompts/bootstrap/CODEX-BOOTSTRAP-PROMPT.md as your operating instructions. Correct foundational issues before beginning TASK-002. Commit all validated changes with meaningful commit messages.
```

## What the bootstrap creates

- Seven canonical project documents
- REP v2 specification
- Artifact templates
- Codex task queue
- Iterative agent instructions
- Dependency-free Python validation
- Artifact generator
- GitHub Actions validation
- Codespaces configuration
- Mobile workflow documentation
- Initial Git commit
