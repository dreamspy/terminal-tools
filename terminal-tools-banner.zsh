# Welcome banner shown when a new shell starts.
# Sourced from the TOP of ~/.zshrc, BEFORE the Powerlevel10k instant-prompt
# block — printing to the console after p10k's instant prompt has started would
# trigger its console-output warning.
#
# The rest of terminal-tools (aliases, tti, czsh, zoxide) is in
# terminal-tools-init.zsh, sourced from the BOTTOM of ~/.zshrc so its aliases
# win against oh-my-zsh defaults.

terminal-help() {
  # Only color when writing to an actual terminal, so redirected/non-tty
  # output (e.g. a tool sourcing .zshrc to scrape env vars) stays clean.
  local BOLD='' RESET='' GREEN=''
  if [[ -t 1 ]]; then
    BOLD=$'\033[1m'
    RESET=$'\033[0m'
    GREEN=$'\033[1;32m'
  fi

  printf '%sterminal-tools%s\n' "$BOLD" "$RESET"
  printf '  %s%-20s%s %s\n' "$GREEN" "tti" "$RESET" "Show terminal tools help"
  printf '  %s%-20s%s %s\n' "$GREEN" "czsh <question>" "$RESET" "Ask Claude about how to do stuff in zsh"
  printf '  %s%-20s%s %s\n' "$GREEN" "goto <name>" "$RESET" "Jump to a folder under ~ (recent first)"

  # cheatsheet is a separate pipx-installed tool (dreamspy/cheatSheetSearch),
  # not part of this repo, so only advertise it if it's actually installed.
  # Checked directly (not just `command -v`) because this banner sources
  # before ~/.zshrc adds ~/.local/bin, pipx's default install dir, to PATH.
  if command -v cheatsheet >/dev/null 2>&1 || [[ -x "$HOME/.local/bin/cheatsheet" ]]; then
    printf '  %s%-20s%s %s\n' "$GREEN" "cheatsheet <query>" "$RESET" "Search your personal cheat-sheet / how-to notes"
  fi
}
terminal-help
