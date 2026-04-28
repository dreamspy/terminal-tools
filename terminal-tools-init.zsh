# Helpers for the terminal-tools cheat sheet and the Claude zsh assistant.
# Source this from ~/.zshrc:  source ~/.terminal-tools/terminal-tools-init.zsh

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
# Zoxide
eval "$(zoxide init zsh)"

#### COMMAND: tti
# Resolve the directory this file lives in, so the helpers work regardless
# of where the repo is checked out.
TERMINAL_TOOLS_DIR="${${(%):-%N}:A:h}"

# Show the interactive cheat sheet.
terminal-tools-interactive() {
  bash "$TERMINAL_TOOLS_DIR/terminal-tools-interactive.sh"
}
alias tti='terminal-tools-interactive'

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
  local cheatsheet="$TERMINAL_TOOLS_DIR/terminal-tools-interactive.sh"
  if [[ -r "$cheatsheet" ]]; then
    context+=$'Cheat-sheet entries from terminal-tools-interactive (alias/tool, description):\n'
    context+="$(grep -E '^[[:space:]]*cmd ' "$cheatsheet")"$'\n'
  fi
  if [[ -t 1 ]] && command -v glow >/dev/null 2>&1; then
    claude -p --model haiku --append-system-prompt "$context" "$prompt" | glow -
  else
    claude -p --model haiku --append-system-prompt "$context" "$prompt"
  fi
}
