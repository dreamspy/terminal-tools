# Aliases, the `tti` and `czsh` functions, and zoxide init.
# Source this from the BOTTOM of ~/.zshrc (after oh-my-zsh) so our aliases
# override oh-my-zsh defaults. The login welcome banner is in a separate file,
# terminal-tools-banner.zsh, sourced from the TOP of ~/.zshrc.

#### ALIASES
alias ll='ls -lah'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias h='history'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'
alias cc='claude'
alias ccd='claude --dangerously-skip-permissions'
alias obsidian-gui='open -a Obsidian'
alias tree='eza --tree --icons'
# Zoxide (skip cleanly if not installed)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

#### COMMAND: tti
# Resolve the directory this file lives in, so the helpers work regardless
# of where the repo is checked out.
TERMINAL_TOOLS_DIR="${${(%):-%N}:A:h}"

# Show the interactive cheat sheet.
tti() {
  bash "$TERMINAL_TOOLS_DIR/tti"
}

### COMMAND: czsh
# Ask Claude a quick zsh / terminal question (Haiku for speed, glow for rendering).
# Context-aware: passes ~/.zshrc and the cheat-sheet entries so suggestions can
# reference the user's own aliases and functions.
czsh() {
  local prompt="You are helping me in zsh on macOS. Give concise, safe terminal commands. Explain briefly. Prefer using the user's existing aliases and functions when relevant. Question: $*"
  local context=""
  if [[ -r ~/.zshrc ]]; then
    context+=$'My ~/.zshrc:\n'"$(<~/.zshrc)"$'\n\n'
  fi
  local cheatsheet="$TERMINAL_TOOLS_DIR/tti"
  if [[ -r "$cheatsheet" ]]; then
    context+=$'Cheat-sheet entries from tti (alias/tool, description):\n'
    context+="$(grep -E '^[[:space:]]*cmd ' "$cheatsheet")"$'\n'
  fi
  if [[ -t 1 ]] && command -v glow >/dev/null 2>&1; then
    claude -p --model haiku --append-system-prompt "$context" "$prompt" | glow -
  else
    claude -p --model haiku --append-system-prompt "$context" "$prompt"
  fi
}
