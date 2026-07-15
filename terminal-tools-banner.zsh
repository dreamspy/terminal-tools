# Welcome banner shown when a new shell starts.
# Sourced from the TOP of ~/.zshrc, BEFORE the Powerlevel10k instant-prompt
# block — printing to the console after p10k's instant prompt has started would
# trigger its console-output warning.
#
# The rest of terminal-tools (aliases, tti, czsh, zoxide) is in
# terminal-tools-init.zsh, sourced from the BOTTOM of ~/.zshrc so its aliases
# win against oh-my-zsh defaults.

terminal-help() {
  printf "tti - Show terminal tools help \n"
  printf "czsh - Ask Claude about how to do stuff in zsh \n"
  printf "goto <name> - Jump to a folder under ~ (recent first) \n"
}
terminal-help
