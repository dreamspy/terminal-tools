# terminal-tools

Personal terminal cheat sheet and a small Claude-powered zsh assistant.

## Install

Run these three commands:

```zsh
git clone https://github.com/dreamspy/terminal-tools.git ~/.terminal-tools

# Prepend the banner source (with comment) to the top of ~/.zshrc
{
  echo "# terminal-tools welcome banner - must be BEFORE p10k instant prompt so"
  echo "# its console output doesn't trigger p10k's console-output warning."
  echo 'source "$HOME/.terminal-tools/terminal-tools-banner.zsh"'
  echo
  cat ~/.zshrc
} > ~/.zshrc.new && mv ~/.zshrc.new ~/.zshrc

# Append the main init source (with comment) to the bottom of ~/.zshrc
{
  echo
  echo "# terminal-tools aliases, tti, czsh, zoxide (sourced after oh-my-zsh so"
  echo "# our aliases win against oh-my-zsh defaults)."
  echo 'source "$HOME/.terminal-tools/terminal-tools-init.zsh"'
} >> ~/.zshrc

source ~/.zshrc
```

Two lines are added to `~/.zshrc`:
- **`terminal-tools-banner.zsh`** at the **top** (before the Powerlevel10k instant-prompt block) so the welcome banner doesn't trip p10k's console-output warning.
- **`terminal-tools-init.zsh`** at the **bottom** (after oh-my-zsh) so our aliases win against oh-my-zsh defaults.

That's it. Run `tti` to browse the cheat sheet.

## Contents

- `tti` — interactive cheat sheet (bash script, run via the `tti` shell function).
- `terminal-tools-banner.zsh` — login welcome banner. Sourced from the **top** of `~/.zshrc` (before p10k instant prompt).
- `terminal-tools-init.zsh` — defines aliases, the `tti` and `czsh` functions, and zoxide. Sourced from the **bottom** of `~/.zshrc` (after oh-my-zsh).

## Commands

- `tti` — open the interactive cheat sheet. `j/k` to scroll, `h/l` between pages, `a` to ask Claude, `f` to filter the menu by label, `s` to search every page's contents (finds pages that mention a word even if it's not in the title), `q` to quit.
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
- `bash` — the `tti` script runs under bash.
