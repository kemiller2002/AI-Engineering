# Apple Shortcuts Setup

## Important Limitation

This kit contains human-readable shortcut specifications, not signed `.shortcut` packages. Modern Apple Shortcuts exports are signed and are not safely reproducible as ordinary text files. Build the first versions manually, export them from the Shortcuts app, and store documentation plus screenshots in Git.

## Recommended Order

1. Build `Capture Research`.
2. Test saving into `research/inbox/` through Working Copy.
3. Build `AI-ROS Launcher`.
4. Run the workflow for several days.
5. Automate additional steps only after repeated friction is clear.

## Variable Insertion in the Current UI

When a `Text` action follows `Ask for Input`, tap inside the Text field. Above the keyboard, choose the output token named **Provided Input** or **Ask for Input**. On some iOS versions, tap the variable/magic-wand control first. The visible token name may differ, but it represents the output of the preceding action.
