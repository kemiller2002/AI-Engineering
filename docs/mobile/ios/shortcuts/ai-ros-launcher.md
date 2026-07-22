# Shortcut Specification: AI-ROS Launcher

**Version:** 1.0  
**Goal:** Provide one entry point to the mobile AI-ROS workspace.

## First Version

Keep this version simple. It should launch tools, not attempt to orchestrate Git or edit repository state.

## Build Actions

### 1. Choose from Menu

Prompt: `AI-ROS`

Menu items:

- Capture Research
- Open ChatGPT
- Open Repository
- Open GitHub
- Open Current State
- Exit

### 2. Capture Research Branch

- Action: `Run Shortcut`
- Shortcut: `Capture Research`

### 3. Open ChatGPT Branch

- Action: `Open App`
- App: ChatGPT

### 4. Open Repository Branch

- Action: `Open App`
- App: Working Copy

### 5. Open GitHub Branch

Use `Open URLs` with the repository URL after it exists.

### 6. Open Current State Branch

For the first version, open Working Copy and navigate manually to `CURRENT-STATE.md`. A direct deep link MAY be added later only after a stable URL is confirmed on the device.

### 7. Exit Branch

- Action: `Stop This Shortcut`

## Acceptance Test

Every menu item opens the expected application or runs the expected shortcut. No branch should fail because an optional deep link was guessed.
