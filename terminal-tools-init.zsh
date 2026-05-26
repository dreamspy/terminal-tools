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

#### COMMAND: goto
# goto <name> : cd to a directory under ~ whose name matches <name>, ordered
# most-recently-modified first, with the modified date shown in the picker.
# Must be a function, not an alias: aliases can't take positional arguments.
# One match -> jump straight there. Several matches -> pick one in an fzf list
# (most recent on top, date column on the left). No match -> a message. Excludes
# the huge versioning/library trees per the home-folder map (so fd never hangs).
#
# Each match becomes "<mtime-epoch> <tab> <date> <tab> <path>" via stat; sort -rn
# orders by the epoch, cut drops it, leaving "<date> <tab> <path>" for the list.
# fzf shows that whole line but matches only the path (--nth=2). On select the
# date column is stripped (${sel##*<tab>}) to recover the path. mtime tracks real
# content changes and, unlike atime (%a), isn't bumped by fd scanning the tree.
goto() {
  local -a fd_excludes=(
    -E Library
    -E 'Vaults-rsync-versioning'
    -E 'Vaults-syncthing-versioning'
    -E '*.photoslibrary'
    -E 'Lightroom'
  )
  local timefmt='%Y-%m-%d %H:%M'
  local fmt=$'%m\t%Sm\t%N'   # epoch (sort key) <tab> human date <tab> path
  local list sel

  list=$(fd -t d "$1" ~ "${fd_excludes[@]}" \
    --exec-batch stat -t "$timefmt" -f "$fmt" | sort -rn | cut -f2-)

  if [[ -z $list ]]; then
    echo "goto: no match for '$1'" >&2
    return 1
  fi

  if command -v fzf >/dev/null 2>&1; then
    # Show "date <tab> path"; --nth=2 searches only the path, not the date.
    # --select-1 auto-picks a lone match without showing the UI.
    sel=$(print -r -- "$list" | fzf --select-1 --reverse --height=40% \
            --delimiter='\t' --nth=2 \
            --prompt="goto > " --header="cd to which folder? (recent first)")
  else
    sel=${list%%$'\n'*}        # no fzf: most recently modified match
  fi

  [[ -n $sel ]] && cd "${sel##*$'\t'}"   # strip date column; empty = cancelled
}
