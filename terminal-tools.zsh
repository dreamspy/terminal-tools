# Helpers for the terminal-tools cheat sheet and the Claude zsh assistant.
# Source this from ~/.zshrc:  source ~/terminal-tools/terminal-tools.zsh

# Resolve the directory this file lives in, so the helpers work regardless
# of where the repo is checked out.
TERMINAL_TOOLS_DIR="${${(%):-%N}:A:h}"

# Show the interactive cheat sheet.
terminal-tools-interactive() {
  bash "$TERMINAL_TOOLS_DIR/terminal-tools-interactive"
}
alias tti='terminal-tools-interactive'

# Ask Claude a quick zsh / terminal question (Haiku for speed, glow for rendering).
# Context-aware: passes ~/.zshrc and the cheat-sheet entries so suggestions can
# reference the user's own aliases and functions.
czsh() {
  local prompt="You are helping me in zsh on macOS. Give concise, safe terminal commands. Explain briefly. Prefer using the user's existing aliases and functions when relevant. Question: $*"
  local context=""
  if [[ -r ~/.zshrc ]]; then
    context+=$'My ~/.zshrc:\n'"$(<~/.zshrc)"$'\n\n'
  fi
  local cheatsheet="$TERMINAL_TOOLS_DIR/terminal-tools-interactive"
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
