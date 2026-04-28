# terminal-tools

Personal terminal cheat sheet and a small Claude-powered zsh assistant.

## Contents

- `terminal-tools-interactive` — interactive cheat sheet (run with `tti`).
- `terminal-tools.zsh` — defines the `tti` alias and the `czsh` function. Sourced from `~/.zshrc`.

## Setup

Clone the repo into `~/terminal-tools` (or anywhere; the helpers resolve their own path), then add this line to `~/.zshrc`:

```zsh
source "$HOME/terminal-tools/terminal-tools.zsh"
```

Reload your shell (`source ~/.zshrc` or open a new terminal) and run `tti` to browse the cheat sheet.

## Commands

- `tti` — open the interactive cheat sheet. `j/k` to scroll, `h/l` between pages, `f` to filter from the menu, `q` to quit.
- `czsh <question>` — ask Claude (Haiku 4.5) for a one-shot zsh/macOS command. Pipes through `glow` for nice markdown rendering when stdout is a terminal. Includes `~/.zshrc` and the cheat-sheet entries as context, so answers can reference your own aliases.

## Dependencies

- [`claude`](https://claude.com/claude-code) — for `czsh`.
- [`glow`](https://github.com/charmbracelet/glow) — optional, for rendered markdown in `czsh` output. Falls back to plain text if unavailable.
- `bash` — `terminal-tools-interactive` runs under bash.
