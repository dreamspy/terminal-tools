# terminal-tools

Personal terminal cheat sheet and a small Claude-powered zsh assistant.

## Contents

- `terminal-tools-interactive.sh` — interactive cheat sheet (run with `tti`).
- `terminal-tools-init.zsh` — defines the `tti` alias and the `czsh` function. Sourced from `~/.zshrc`.

## Setup

Clone the repo into `~/.terminal-tools` (or anywhere; the helpers resolve their own path), then add this line to `~/.zshrc`:

```zsh
source "$HOME/.terminal-tools/terminal-tools-init.zsh"
```

Reload your shell (`source ~/.zshrc` or open a new terminal) and run `tti` to browse the cheat sheet.

## Commands

- `tti` — open the interactive cheat sheet. `j/k` to scroll, `h/l` between pages, `a` to ask Claude, `f` to filter from the menu, `q` to quit.
- `czsh <question>` — ask Claude (Haiku 4.5) for a one-shot zsh/macOS command. Pipes through `glow` for nice markdown rendering when stdout is a terminal. Includes `~/.zshrc` and the cheat-sheet entries as context, so answers can reference your own aliases.

  **Privacy note:** `czsh` and the in-`tti` Ask Claude flow both send the contents of your `~/.zshrc` to Claude on every call as part of the system prompt. If your zshrc contains secrets (API keys, tokens), either remove them, move them to a separate file that isn't sourced, or edit `czsh` and `ask_claude_flow` to skip the zshrc context.

## Ask Claude inside `tti`

The last page of the cheat sheet is **Ask Claude**. From there (or from any page) press `a` to:

1. Type a zsh / terminal question.
2. See Claude's answer rendered with `glow`.
3. Choose `(n)` new page, `(e)` append to an existing saved page, or `(s)` skip.
4. Confirm with `y` before anything is written. Nothing is saved without an explicit yes.

Saved pages live as plain markdown under `~/.terminal-tools/user-pages/` (override with `TERMINAL_TOOLS_USER_PAGES_DIR`). They are picked up automatically on next launch and appear right after the built-in pages, just before the Ask Claude entry. Edit, rename, or delete them with any editor.

## Dependencies

- [`claude`](https://claude.com/claude-code) — for `czsh`.
- [`glow`](https://github.com/charmbracelet/glow) — optional, for rendered markdown in `czsh` output. Falls back to plain text if unavailable.
- `bash` — `terminal-tools-interactive.sh` runs under bash.
