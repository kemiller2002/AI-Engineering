# Run AI-ROS Bootstrap with Codex

## Option A — New repository in Codespaces

1. Create an empty private GitHub repository.
2. Open a Codespace for it.
3. Upload `tools/bootstrap/bootstrap-ai-ros.sh` to the Codespace.
4. Run:

```bash
chmod +x tools/bootstrap/bootstrap-ai-ros.sh
./tools/bootstrap/bootstrap-ai-ros.sh ai-research-os
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
Run ./tools/bootstrap/bootstrap-ai-ros.sh ai-research-os. Do not merely describe the result. Inspect every generated file, run ./setup.sh, run python3 tools/validate.py, and report actual command output. Then review the generated repository using ai-prompts/bootstrap/AI-ROS-Bootstrap-Agent.md as the operating instructions and correct foundational issues before beginning follow-on work. Commit all validated changes with meaningful commit messages.
```

## What the bootstrap creates

- Seven canonical project documents
- REP v2 specification
- Artifact templates
- Bootstrap prompts
- Iterative agent instructions
- Dependency-free Python validation
- Artifact generator
- GitHub Actions validation
- Codespaces configuration
- Mobile workflow documentation
- Initial Git commit
