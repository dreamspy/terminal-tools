#!/usr/bin/env bash

# ~/.terminal-tools/terminal-tools-interactive.sh
# Interactive terminal tools helper.
#
# Normally invoked via the `tti` alias defined in
# ~/.terminal-tools/terminal-tools-init.zsh, which is sourced from ~/.zshrc.

# Direct ANSI colors, known to work if:
# printf '\033[1;32mGREEN TEXT\033[0m\n'
# works in your terminal.
BOLD="$(printf '\033[1m')"
DIM="$(printf '\033[2m')"
RESET="$(printf '\033[0m')"
CYAN="$(printf '\033[1;36m')"
YELLOW="$(printf '\033[1;33m')"
GREEN="$(printf '\033[1;32m')"
MAGENTA="$(printf '\033[1;35m')"
RED="$(printf '\033[1;31m')"

title() {
  printf '%s%s%s%s\n\n' "$CYAN" "$BOLD" "$1" "$RESET"
}

heading() {
  printf '\n%s%s%s%s\n' "$YELLOW" "$BOLD" "$1" "$RESET"
}

cmd() {
  printf '  %s%-34s%s %s\n' "$GREEN" "$1" "$RESET" "$2"
}

warn() {
  printf '  %s%s%s\n' "$RED" "$1" "$RESET"
}

note() {
  printf '  %s%s%s\n' "$MAGENTA" "$1" "$RESET"
}

show_general() {
  clear
  title "GENERAL TOOLS"

  printf '  Everyday command-line helpers: viewing files, parsing JSON, monitoring processes.\n\n'

  cmd "bat" "- cat with syntax highlighting and git integration"
  cmd "glow" "- render Markdown in the terminal"
  cmd "fx" "- JSON / JSONL viewer"
  cmd "jq" "- JSON processor and filter"
  cmd "htop" "- process viewer"
  cmd "ncdu" "- disk usage explorer"
  cmd "tldr" "- simple command examples"
  cmd "entr" "- run commands automatically when files change"

  heading "Examples"
  cmd "bat file.txt" "- view a file with highlighting"
  cmd "glow README.md" "- render Markdown nicely"
  cmd "jq '.name' package.json" "- extract a JSON field"
  cmd "ncdu ." "- inspect disk usage from current folder"
  cmd "tldr tar" "- show simple examples for tar"
  cmd "fd '\\.py$' | entr python main.py" "- rerun script when Python files change"
}

show_navigation() {
  clear
  title "NAVIGATION"

  printf '  Shortcuts for moving around the filesystem and listing what is in it.\n\n'

  cmd "ll" "- list files with details, including hidden files"
  cmd "la" "- list hidden files compactly"
  cmd ".." "- go up one folder"
  cmd "..." "- go up two folders"
  cmd "c" "- clear terminal"
  cmd "h" "- show command history"
  cmd "z" "- smart folder jumping with zoxide"
  cmd "tree" "- tree view of current directory"

  heading "Examples"
  cmd "z projectname" "- jump to a folder you use often"
  cmd "z patbot" "- jump to a remembered patbot folder"
  cmd "tree" "- show folder tree"
  cmd "tree --level=2" "- show shallow folder tree if using eza alias"
}

show_git() {
  clear
  title "GIT"

  printf '  Aliases and a safe workflow for the most common git operations.\n\n'

  cmd "gs" "- git status"
  cmd "ga" "- git add"
  cmd "gc" "- git commit"
  cmd "gp" "- git push"
  cmd "gl" "- compact visual git log"
  cmd "gd" "- show unstaged git changes"
  cmd "gds" "- show staged git changes"
  cmd "delta" "- prettier git diff"

  heading "Common flow"
  cmd "gs" "- see current repo state"
  cmd "gd" "- inspect unstaged changes"
  cmd "ga ." "- stage current folder"
  cmd "gds" "- inspect staged changes"
  cmd "gc -m \"message\"" "- commit with message"
  cmd "gp" "- push"

  heading "Safe Claude habit"
  cmd "git add -A && git commit -m \"checkpoint before Claude\"" "- checkpoint before AI edits"
  cmd "git diff" "- inspect what changed"
  cmd "git restore ." "- discard tracked file changes"
  cmd "git clean -fd" "- remove untracked files, careful"
}

show_claude() {
  clear
  title "CLAUDE CODE"

  printf '  Run Claude Code on your projects with sensible safety defaults.\n\n'

  cmd "cc" "- start Claude Code"
  cmd "ccd" "- start Claude Code without permission prompts, use carefully"
  cmd "czsh" "- ask Claude for a zsh/terminal command, one-shot"

  heading "Quick zsh question (czsh)"
  printf '  Ask Claude for a one-shot zsh/macOS command, no interactive session.\n'
  printf '  Use when you forget a flag, want a one-liner, or need to check what a snippet does.\n\n'

  printf '  %sExamples%s\n' "$DIM" "$RESET"
  printf '    %sczsh how do I find files larger than 100MB%s\n' "$GREEN" "$RESET"
  printf '    %sczsh unzip only one file from archive.zip%s\n' "$GREEN" "$RESET"
  printf '    %sczsh what does "set -euo pipefail" do%s\n' "$GREEN" "$RESET"
  printf '    %sczsh rename all .jpeg files to .jpg%s\n\n' "$GREEN" "$RESET"

  printf '  %sNotes%s\n' "$DIM" "$RESET"
  printf '    Defined in %s~/.terminal-tools/terminal-tools-init.zsh%s, sourced from ~/.zshrc.\n' "$GREEN" "$RESET"
  printf '    Uses Haiku 4.5 for speed, renders through %sglow%s.\n' "$GREEN" "$RESET"
  printf '    Context-aware: passes ~/.zshrc and this cheat sheet via --append-system-prompt,\n'
  printf '    so answers can reference your own aliases (e.g. it knows about %sgs%s, %scc%s, %stti%s).\n' "$GREEN" "$RESET" "$GREEN" "$RESET" "$GREEN" "$RESET"
  printf '    For multi-step work or editing files, use %scc%s instead.\n' "$GREEN" "$RESET"

  heading "Safer workflow"
  cmd "git status" "- check current repo state"
  cmd "git switch -c ai-work" "- create a disposable branch"
  cmd "git add -A && git commit -m \"checkpoint before Claude\"" "- make a safe checkpoint"
  cmd "claude" "- start Claude normally"

  heading "Good instruction to paste into Claude"
  note "Work freely on code edits, but ask before destructive, network,"
  note "install, sudo, git push, git reset, or secret-related commands."

  heading "Be careful with"
  cmd "ccd" "- skips permission prompts"
  cmd "rm -rf" "- destructive delete"
  cmd "sudo" "- system-level changes"
  cmd "git reset --hard" "- destroys local changes"
  cmd "git push" "- affects remote repo"
  cmd "curl | sh" "- runs downloaded code"
}

show_tmux() {
  clear
  title "TMUX QUICKSHEET"

  printf '  Persistent terminal sessions: keep work running across detaches, split panes, juggle windows.\n\n'

  heading "Prefix"
  cmd "Ctrl-b" "- prefix key, press before tmux shortcuts"

  heading "Sessions"
  cmd "tmux" "- start tmux"
  cmd "tmux ls" "- list sessions"
  cmd "tmux new -s work" "- new session named work"
  cmd "tmux new -A -s work" "- attach to work, or create it"
  cmd "tmux attach -t work" "- attach to session"
  cmd "Ctrl-b d" "- detach, session keeps running"

  heading "Windows"
  cmd "Ctrl-b c" "- new window"
  cmd "Ctrl-b n" "- next window"
  cmd "Ctrl-b p" "- previous window"
  cmd "Ctrl-b 0..9" "- jump to window number"
  cmd "Ctrl-b ," "- rename window"
  cmd "Ctrl-b &" "- kill window"

  heading "Panes"
  cmd "Ctrl-b %" "- split vertically, left/right"
  cmd "Ctrl-b \"" "- split horizontally, top/bottom"
  cmd "Ctrl-b arrows" "- move between panes"
  cmd "Ctrl-b x" "- kill pane"
  cmd "Ctrl-b z" "- zoom/unzoom pane"
  cmd "Ctrl-b Space" "- cycle pane layouts"

  heading "Scroll / Copy"
  cmd "Ctrl-b [" "- scroll mode"
  cmd "arrows" "- move in scroll mode"
  cmd "PageUp/PageDown" "- scroll faster"
  cmd "q" "- exit scroll mode"

  heading "Useful"
  cmd "Ctrl-b ?" "- show all tmux shortcuts"
  cmd "Ctrl-b :" "- tmux command prompt"

  heading "Good pattern"
  cmd "tmux new -A -s projectname" "- one persistent workspace per project"
  cmd "ssh myserver -t 'tmux new -A -s work'" "- SSH straight into persistent session"
}

show_fd() {
  clear
  title "FD"

  cmd "fd" "- fast, friendly file finder"
  printf '  Finds files and folders by name. Simpler and nicer than classic find.\n'

  heading "Examples"
  cmd "fd config" "- find files/folders named config"
  cmd "fd .md" "- find Markdown files"
  cmd "fd package.json" "- find package.json"
  cmd "fd test src" "- find test inside src"
  cmd "fd -t f" "- files only"
  cmd "fd -t d" "- directories only"
  cmd "fd -H" "- include hidden files"
  cmd "fd -e ts" "- only .ts files"

  heading "Mental model"
  cmd "fd" "- where is the file?"
}

show_rg() {
  clear
  title "RIPGREP / RG"

  cmd "rg" "- fast text search inside files"
  printf '  Searches file contents. Usually the best replacement for grep.\n'

  heading "Examples"
  cmd "rg \"TODO\"" "- find TODO anywhere"
  cmd "rg \"function login\"" "- find exact text"
  cmd "rg \"apiKey\"" "- find API key references"
  cmd "rg \"useState\" -g \"*.tsx\"" "- search only TSX files"
  cmd "rg \"database\" -g '!node_modules'" "- exclude node_modules"

  heading "Useful options"
  cmd "rg -i \"login\"" "- case-insensitive search"
  cmd "rg -n \"login\"" "- show line numbers"
  cmd "rg -l \"login\"" "- show only filenames with matches"
  cmd "rg -c \"login\"" "- show match counts per file"
  cmd "rg -A 3 \"login\"" "- show 3 lines after match"
  cmd "rg -B 3 \"login\"" "- show 3 lines before match"
  cmd "rg -C 3 \"login\"" "- show 3 lines before and after"
  cmd "rg --hidden \"text\"" "- include hidden files"
  cmd "rg -uuu \"text\"" "- search everything, including ignored files"

  heading "Mental model"
  cmd "rg" "- where is this text used?"
}

show_fzf() {
  clear
  title "FZF"

  cmd "fzf" "- fuzzy finder / interactive picker"
  printf '  Lets you quickly choose from lists using fuzzy search.\n'

  heading "Common uses"
  cmd "Ctrl-r" "- search command history"
  cmd "fd | fzf" "- pick a file/folder interactively"
  cmd "vim \$(fd | fzf)" "- open selected file in vim"
  cmd "nvim \$(fd | fzf)" "- open selected file in nvim"
  cmd "code \$(fd | fzf)" "- open selected file in Cursor / VS Code"

  heading "Useful combinations"
  cmd "fd .md | fzf" "- pick a Markdown file"
  cmd "rg \"search text\" -l | fzf" "- pick a file containing text"
  cmd "cd \"\$(fd -t d | fzf)\"" "- jump to selected folder"
  cmd "nvim \"\$(fd -t f | fzf)\"" "- open selected file in nvim"

  heading "Mental model"
  cmd "fzf" "- let me choose from the results"
}

show_fd_rg_fzf() {
  clear
  title "FD / RG / FZF"

  printf '  The search trio: find files, search inside them, pick interactively.\n\n'

  heading "Core idea"
  cmd "fd" "- find files and folders by name"
  cmd "rg" "- search inside files"
  cmd "fzf" "- choose interactively from results"

  heading "Examples"
  cmd "fd config" "- find files/folders named config"
  cmd "fd .md" "- find Markdown files"
  cmd "rg \"TODO\"" "- search for TODO in files"
  cmd "rg \"apiKey\" -g \"*.ts\"" "- search only TypeScript files"
  cmd "fd | fzf" "- pick a file/folder"
  cmd "rg \"search text\" -l | fzf" "- pick a matching file"
  cmd "cd \"\$(fd -t d | fzf)\"" "- jump to selected folder"
  cmd "code \"\$(fd -t f | fzf)\"" "- open selected file in Cursor / VS Code"

  heading "General tips"
  printf '  Use %sfd%s when you remember part of a filename.\n' "$GREEN" "$RESET"
  printf '  Use %srg%s when you remember text inside a file.\n' "$GREEN" "$RESET"
  printf '  Use %sfzf%s when there are many results and you want to choose.\n' "$GREEN" "$RESET"
  printf '  Combine them for very fast project navigation.\n'

  heading "Mental model"
  cmd "fd" "- where is the file?"
  cmd "rg" "- where is this text used?"
  cmd "fzf" "- let me choose from the results"
}

show_eza() {
  clear
  title "EZA"

  cmd "eza" "- modern replacement for ls"
  printf '  Lists files and folders with nicer formatting, colors, icons, git status, and tree views.\n'
  printf '  Easier to read than classic ls.\n'

  heading "Common examples"
  cmd "eza" "- list files in the current folder"
  cmd "eza -lah" "- list all files with details, including hidden files"
  cmd "eza --icons" "- list files with icons"
  cmd "eza -lah --icons" "- detailed list with hidden files and icons"
  cmd "eza --tree" "- show folder structure as a tree"
  cmd "eza --tree --level=2" "- tree view, only 2 levels deep"
  cmd "eza --git" "- show git status next to files"
  cmd "eza -lah --git --icons" "- detailed list with hidden files, git status, and icons"

  heading "Useful aliases"
  cmd "alias ls='eza --icons'" "- prettier ls"
  cmd "alias ll='eza -lah --icons --git'" "- detailed list"
  cmd "alias tree='eza --tree --icons --level=2'" "- nice tree view"

  heading "General tips"
  printf '  Use %seza%s instead of ls for normal file browsing.\n' "$GREEN" "$RESET"
  printf '  Use %seza --tree%s when you want to understand a project structure.\n' "$GREEN" "$RESET"
  printf '  Use %s--level=2%s or %s--level=3%s so tree output does not get too large.\n' "$GREEN" "$RESET" "$GREEN" "$RESET"
  printf '  Use %s--git%s inside coding projects to quickly see changed files.\n' "$GREEN" "$RESET"

  heading "Mental model"
  cmd "eza" "- prettier ls"
  cmd "eza -lah" "- detailed file list"
  cmd "eza --tree" "- folder map"
  cmd "eza --git" "- file list with git awareness"
}

show_direnv() {
  clear
  title "DIRENV"

  cmd "direnv" "- project-specific environment loader"
  printf '  Automatically loads environment variables and setup commands when you enter a folder.\n'
  printf '  Very useful for projects with API keys, paths, Python versions, Node settings, or local config.\n'

  heading "Basic idea"
  printf '  Each project can have a %s.envrc%s file.\n' "$GREEN" "$RESET"
  printf '  When you cd into that folder, direnv loads it.\n'
  printf '  When you leave the folder, direnv unloads it.\n'

  heading "Common examples"
  cmd "echo 'export NODE_ENV=development' > .envrc" "- create local project environment"
  cmd "direnv allow" "- trust and activate the current .envrc"
  cmd "echo 'export DATABASE_URL=postgres://localhost/mydb' >> .envrc" "- add database URL"
  cmd "echo 'export PATH=\"\$PWD/bin:\$PATH\"' >> .envrc" "- add project bin folder to PATH"

  heading "Useful commands"
  cmd "direnv allow" "- trust and activate the current .envrc file"
  cmd "direnv deny" "- stop trusting the current .envrc file"
  cmd "direnv reload" "- reload the current .envrc file"
  cmd "direnv status" "- show direnv status/debug info"

  heading "Important safety rule"
  warn "Always read .envrc before running direnv allow."
  printf '  .envrc is shell code, so it can run commands.\n'

  heading "Good use cases"
  cmd "Per-project API keys" "- local secrets, but do not commit them"
  cmd "Local database URLs" "- dev database config"
  cmd "Development/staging settings" "- per-project runtime settings"
  cmd "Python virtualenv activation" "- auto-load Python env"
  cmd "Node project paths" "- local node/npm tooling"
  cmd "Custom scripts" "- repo-specific shell setup"

  heading "Avoid"
  printf '  Putting shared long-term shell config in .envrc.\n'
  printf '  Blindly allowing .envrc files from random repos.\n'
  printf '  Committing secrets to git.\n'

  heading "Tip"
  printf '  Add .envrc to git only if it contains safe project setup.\n'
  printf '  For secrets, use .envrc locally and add it to .gitignore.\n'

  heading "Mental model"
  cmd ".zshrc" "- global terminal setup"
  cmd ".envrc" "- setup for this specific project folder"
  cmd "direnv" "- automatic on/off switch when entering/leaving folder"
}

show_quick_index() {
  clear
  title "QUICK TOOL INDEX"

  printf '  All the tools at a glance, one line each.\n\n'

  cmd "fzf" "- fuzzy finder / interactive picker"
  cmd "fd" "- better find"
  cmd "rg" "- better grep, searches inside files"
  cmd "bat" "- better cat"
  cmd "eza" "- better ls"
  cmd "delta" "- better git diff"
  cmd "zoxide" "- smarter cd / jump"
  cmd "direnv" "- per-project environment variables"
  cmd "gh" "- GitHub CLI"
  cmd "jq" "- JSON processor"
  cmd "htop" "- process viewer"
  cmd "ncdu" "- disk usage explorer"
  cmd "tldr" "- simple command examples"
  cmd "entr" "- run commands on file changes"
}

show_mental_model() {
  clear
  title "MENTAL MODEL"

  printf '  Each tool linked to the simple question it answers.\n\n'

  cmd "fd" "- where is the file?"
  cmd "rg" "- where is this text used?"
  cmd "fzf" "- let me choose from the results"
  cmd "eza" "- prettier ls / clearer file browsing"
  cmd "eza -lah" "- detailed file list"
  cmd "eza --tree" "- folder map"
  cmd "eza --git" "- file list with git awareness"
  cmd "zoxide" "- jump to folders fast"
  cmd "direnv" "- automatic project environment on/off switch"
  cmd "tmux" "- keep terminal sessions alive"
  cmd "git" "- checkpoint before AI edits"

  heading "Config files"
  cmd ".zshrc" "- global terminal setup"
  cmd ".envrc" "- setup for this specific project folder"
  cmd "~/.terminal-tools/" "- this interactive helper"
}

# ---------------------------------------------------------------------------
# Saved user pages and Claude integration.
# ---------------------------------------------------------------------------
# The "Ask Claude" page (last in the list) lets the user ask Claude a question
# and save the answer as a new markdown page or append it to an existing
# saved page. Saved pages live as plain markdown under
# TERMINAL_TOOLS_USER_PAGES_DIR and are picked up automatically.

TERMINAL_TOOLS_USER_PAGES_DIR="${TERMINAL_TOOLS_USER_PAGES_DIR:-$HOME/.terminal-tools/user-pages}"

# Set by save_as_new_user_page / append_to_user_page when a save succeeds, so
# cycle_pages can land the user on the resulting page after the flow.
ASK_JUMP_LABEL=""

# Slug a string into a safe filename component.
slugify() {
  printf '%s' "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | tr -c 'a-z0-9' '-' \
    | tr -s '-' \
    | sed -e 's/^-//' -e 's/-$//'
}

# Pick a unique filename for a new user page given a desired title.
unique_user_page_path() {
  local title="$1" slug base path i
  slug=$(slugify "$title")
  [[ -z "$slug" ]] && slug="page"
  base="$TERMINAL_TOOLS_USER_PAGES_DIR/$slug"
  path="$base.md"
  i=2
  while [[ -e "$path" ]]; do
    path="$base-$i.md"
    i=$(( i + 1 ))
  done
  printf '%s' "$path"
}

# Render a markdown file using the same color palette as the built-in pages.
# Intentionally tiny: enough for headings, bullets, and code blocks. Captures
# fenced code blocks (```), #/##/### headings, blockquotes, lists, and ---.
render_markdown_file() {
  local file="$1" line content in_code=0
  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" =~ ^[[:space:]]*\`\`\` ]]; then
      in_code=$(( 1 - in_code ))
      continue
    fi
    if (( in_code )); then
      printf '  %s%s%s\n' "$GREEN" "$line" "$RESET"
      continue
    fi
    case "$line" in
      "# "*)
        content="${line#\# }"
        printf '%s%s%s%s\n\n' "$CYAN" "$BOLD" "$content" "$RESET"
        ;;
      "## "*)
        content="${line#\#\# }"
        printf '\n%s%s%s%s\n' "$YELLOW" "$BOLD" "$content" "$RESET"
        ;;
      "### "*)
        content="${line#\#\#\# }"
        printf '\n%s%s%s%s\n' "$MAGENTA" "$BOLD" "$content" "$RESET"
        ;;
      "> "*)
        content="${line#> }"
        printf '  %s│%s %s%s%s\n' "$DIM" "$RESET" "$DIM" "$content" "$RESET"
        ;;
      "- "*|"* "*)
        content="${line:2}"
        printf '  %s•%s %s\n' "$CYAN" "$RESET" "$content"
        ;;
      "---")
        printf '\n  %s────────────────────────────────────────%s\n' "$DIM" "$RESET"
        ;;
      "")
        printf '\n'
        ;;
      *)
        printf '  %s\n' "$line"
        ;;
    esac
  done < "$file"
}

# Display a saved user page. Used by render_page() when an entry's func is
# the sentinel "__user_page__".
show_user_page_file() {
  local file="$1"
  clear
  if [[ -f "$file" ]]; then
    render_markdown_file "$file"
  else
    title "PAGE NOT FOUND"
    printf '  %s%s%s\n' "$RED" "$file" "$RESET"
  fi
}

# Built-in last page: documents the Ask Claude flow.
show_ask_claude() {
  clear
  title "ASK CLAUDE"

  printf '  Ask Claude a zsh / terminal question and optionally save the answer\n'
  printf '  as a new page or appended to an page you saved before.\n\n'

  heading "How to use"
  cmd "Press a" "- ask, see the answer, choose where to save"
  cmd "(n)ew page" "- create a new page from the question and answer"
  cmd "(e)xisting" "- append the answer to a previously saved page"
  cmd "(s)kip" "- discard, do not save"

  heading "Confirmation"
  printf '  After choosing, you see a preview and confirm with %sy%s before anything\n' "$GREEN" "$RESET"
  printf '  is written. Nothing is saved without an explicit yes.\n'

  heading "Examples"
  printf '    %sHow do I find files larger than 100 MB%s\n' "$GREEN" "$RESET"
  printf '    %sUnzip only one file from archive.zip%s\n' "$GREEN" "$RESET"
  printf '    %sWhat does set -euo pipefail do%s\n' "$GREEN" "$RESET"
  printf '    %sRename all .jpeg files to .jpg%s\n\n' "$GREEN" "$RESET"

  heading "Where pages live"
  printf '  %s%s%s\n' "$GREEN" "$TERMINAL_TOOLS_USER_PAGES_DIR" "$RESET"
  printf '  Plain markdown. Edit, rename, or delete with any editor.\n'

  heading "Notes"
  printf '  Uses Claude Haiku 4.5 for speed, same model as %sczsh%s.\n' "$GREEN" "$RESET"
  printf '  Sends %s~/.zshrc%s and the cheat-sheet entries as context, like %sczsh%s.\n' "$GREEN" "$RESET" "$GREEN" "$RESET"
  printf '  New pages appear in the menu and the page cycle right after a save.\n'
  printf '  Press %sa%s from any page, not just this one.\n' "$GREEN" "$RESET"
}

# Discover saved user pages and append them to the page arrays. Called from
# assemble_pages, which resets the arrays first so this is idempotent.
load_user_pages() {
  [[ -d "$TERMINAL_TOOLS_USER_PAGES_DIR" ]] || return 0
  local file label
  shopt -s nullglob
  local files=("$TERMINAL_TOOLS_USER_PAGES_DIR"/*.md)
  shopt -u nullglob
  for file in "${files[@]}"; do
    label=$(grep -m1 '^# ' "$file" 2>/dev/null | sed -e 's/^# *//' -e 's/[[:space:]]\{1,\}/ /g')
    [[ -z "$label" ]] && label=$(basename "$file" .md | tr '-' ' ')
    PAGE_LABELS+=("$label")
    PAGE_FUNCS+=("__user_page__")
    PAGE_DESCS+=("Saved by Ask Claude")
    USER_PAGE_FILES+=("$file")
  done
}

# Build the full page list: built-in pages, then user-saved pages, then the
# Ask Claude page at the end. Called at startup and after every save.
assemble_pages() {
  PAGE_LABELS=("${BUILTIN_PAGE_LABELS[@]}")
  PAGE_FUNCS=("${BUILTIN_PAGE_FUNCS[@]}")
  PAGE_DESCS=("${BUILTIN_PAGE_DESCS[@]}")
  USER_PAGE_FILES=()
  local i
  for (( i = 0; i < ${#PAGE_LABELS[@]}; i++ )); do
    USER_PAGE_FILES+=("")
  done
  load_user_pages
  PAGE_LABELS+=("Ask Claude")
  PAGE_FUNCS+=("show_ask_claude")
  PAGE_DESCS+=("Ask Claude a question, optionally save the answer")
  USER_PAGE_FILES+=("")
}

# Dispatch a page render. Routes user-page entries to show_user_page_file
# with the right path, otherwise calls the named built-in function.
render_page() {
  local idx="$1" func="${PAGE_FUNCS[$1]}"
  if [[ "$func" == "__user_page__" ]]; then
    show_user_page_file "${USER_PAGE_FILES[$idx]}"
  else
    "$func"
  fi
}

# Build the same context czsh sends, so the answer can reference the user's
# aliases and the cheat-sheet vocabulary.
__claude_context() {
  local self_path="${BASH_SOURCE[0]:-$0}"
  if [[ -r ~/.zshrc ]]; then
    printf 'My ~/.zshrc:\n'
    cat ~/.zshrc
    printf '\n\n'
  fi
  if [[ -r "$self_path" ]]; then
    printf 'Cheat-sheet entries from terminal-tools-interactive (alias/tool, description):\n'
    grep -E '^[[:space:]]*cmd ' "$self_path"
    printf '\n'
  fi
}

# Save the question + answer as a new user page after a Y/N confirmation.
save_as_new_user_page() {
  local question="$1" answer="$2"

  printf '%sNew page title%s %s(Enter to use the question)%s:\n> ' \
    "$YELLOW" "$RESET" "$DIM" "$RESET"
  local title
  IFS= read -r title
  [[ -z "$title" ]] && title="$question"

  mkdir -p "$TERMINAL_TOOLS_USER_PAGES_DIR" 2>/dev/null
  local path
  path=$(unique_user_page_path "$title")

  printf '\n%sPreview%s\n' "$DIM" "$RESET"
  printf '  %sTitle:%s %s\n' "$DIM" "$RESET" "$title"
  printf '  %sFile:%s  %s\n' "$DIM" "$RESET" "$path"
  printf '\n%sSave?%s %s(y/n)%s ' "$YELLOW" "$RESET" "$CYAN" "$RESET"
  local confirm
  IFS= read -rsn1 confirm
  printf '\n'

  if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    printf '%sCancelled. Nothing was saved.%s\n' "$DIM" "$RESET"
    return 1
  fi

  {
    printf '# %s\n\n' "$title"
    printf '> %s\n\n' "$question"
    printf '%s\n' "$answer"
  } > "$path"

  printf '%sSaved to %s%s\n' "$GREEN" "$path" "$RESET"
  ASK_JUMP_LABEL="$title"
}

# Append the question + answer to an existing user page after a Y/N confirm.
append_to_user_page() {
  local question="$1" answer="$2"

  shopt -s nullglob
  local files=("$TERMINAL_TOOLS_USER_PAGES_DIR"/*.md)
  shopt -u nullglob

  if (( ${#files[@]} == 0 )); then
    printf '%sNo saved pages yet.%s Use %s(n)%s next time to create one.\n' \
      "$DIM" "$RESET" "$CYAN" "$RESET"
    return 1
  fi

  local i file label
  local -a labels
  for i in "${!files[@]}"; do
    file="${files[$i]}"
    label=$(grep -m1 '^# ' "$file" 2>/dev/null | sed 's/^# *//')
    [[ -z "$label" ]] && label=$(basename "$file" .md | tr '-' ' ')
    labels+=("$label")
  done

  printf '%sExisting saved pages%s\n' "$DIM" "$RESET"
  for i in "${!labels[@]}"; do
    printf '  %s%2d%s  %s\n' "$CYAN" "$(( i + 1 ))" "$RESET" "${labels[$i]}"
  done

  printf '\n%sPick a page%s %s(number, Enter to cancel)%s > ' \
    "$YELLOW" "$RESET" "$DIM" "$RESET"
  local pick
  IFS= read -r pick
  if [[ -z "$pick" ]]; then
    printf '%sCancelled.%s\n' "$DIM" "$RESET"
    return 1
  fi
  if ! [[ "$pick" =~ ^[0-9]+$ ]]; then
    printf '%sNot a number, cancelled.%s\n' "$RED" "$RESET"
    return 1
  fi

  local idx=$(( pick - 1 ))
  if (( idx < 0 || idx >= ${#files[@]} )); then
    printf '%sOut of range, cancelled.%s\n' "$RED" "$RESET"
    return 1
  fi

  local target="${files[$idx]}"
  local target_label="${labels[$idx]}"

  printf '\n%sAppending to:%s %s\n' "$DIM" "$RESET" "$target_label"
  printf '%sFile:%s         %s\n' "$DIM" "$RESET" "$target"
  printf '\n%sAppend?%s %s(y/n)%s ' "$YELLOW" "$RESET" "$CYAN" "$RESET"
  local confirm
  IFS= read -rsn1 confirm
  printf '\n'

  if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    printf '%sCancelled. Nothing was changed.%s\n' "$DIM" "$RESET"
    return 1
  fi

  {
    printf '\n---\n\n'
    printf '## %s\n\n' "$question"
    printf '%s\n' "$answer"
  } >> "$target"

  printf '%sAppended to %s%s\n' "$GREEN" "$target" "$RESET"
  ASK_JUMP_LABEL="$target_label"
}

# Interactive flow: prompt for a question, call Claude, show the answer, and
# offer to save as a new page or append to an existing one. Each save step
# requires an explicit y/Y confirmation.
ask_claude_flow() {
  ASK_JUMP_LABEL=""

  if ! command -v claude >/dev/null 2>&1; then
    clear
    title "ASK CLAUDE"
    printf '  %sclaude%s command not found in PATH.\n' "$RED" "$RESET"
    printf '  Install Claude Code from %shttps://claude.com/claude-code%s and try again.\n' "$GREEN" "$RESET"
    printf '\n%sPress any key to continue...%s' "$DIM" "$RESET"
    IFS= read -rsn1
    return
  fi

  clear
  printf '%s%sASK CLAUDE%s\n\n' "$CYAN" "$BOLD" "$RESET"
  printf '%sType your question%s %s(Enter on empty line to cancel)%s\n> ' \
    "$YELLOW" "$RESET" "$DIM" "$RESET"

  local question
  IFS= read -r question
  [[ -z "$question" ]] && return

  printf '\n%sAsking Claude (haiku) ...%s\n' "$DIM" "$RESET"

  local context prompt answer
  context=$(__claude_context)
  prompt="You are helping me in zsh on macOS. Give concise, safe terminal commands. Output as concise markdown for a cheat-sheet page. Use a clear top-level # heading with a short title that names the topic. Then a one-sentence intro, then ## sub-headings with bullets and code blocks. Prefer the user's existing aliases when relevant. Question: $question"

  answer=$(claude -p --model haiku --append-system-prompt "$context" "$prompt" 2>&1)

  if [[ -z "$answer" ]]; then
    printf '%sNo response from Claude.%s\n' "$RED" "$RESET"
    printf '\n%sPress any key to continue...%s' "$DIM" "$RESET"
    IFS= read -rsn1
    return
  fi

  clear
  printf '%s%sQuestion%s\n  %s\n\n' "$CYAN" "$BOLD" "$RESET" "$question"
  printf '%s%sAnswer%s\n\n' "$CYAN" "$BOLD" "$RESET"
  if command -v glow >/dev/null 2>&1; then
    printf '%s' "$answer" | glow -
  else
    printf '%s\n' "$answer"
  fi

  printf '\n%s%sSave this answer?%s ' "$YELLOW" "$BOLD" "$RESET"
  printf '%s(n)%s new page  %s(e)%s append to existing  %s(s)%s skip > ' \
    "$CYAN" "$RESET" "$CYAN" "$RESET" "$CYAN" "$RESET"
  local action
  IFS= read -rsn1 action
  printf '\n\n'

  case "$action" in
    n|N) save_as_new_user_page "$question" "$answer" ;;
    e|E) append_to_user_page "$question" "$answer" ;;
    *)   printf '%sSkipped, nothing saved.%s\n' "$DIM" "$RESET" ;;
  esac

  printf '\n%sPress any key to continue...%s' "$DIM" "$RESET"
  IFS= read -rsn1
}

# Ordered list of pages for cycling. Three parallel arrays so each page has a
# stable label, a render function, and a one-line description shown in the menu.
PAGE_LABELS=(
  "Quick tool index"
  "General tools"
  "Navigation"
  "Git"
  "Claude Code"
  "Tmux"
  "fd"
  "rg / ripgrep"
  "fzf"
  "fd / rg / fzf combinations"
  "eza"
  "direnv"
  "Mental model"
)
PAGE_FUNCS=(
  "show_quick_index"
  "show_general"
  "show_navigation"
  "show_git"
  "show_claude"
  "show_tmux"
  "show_fd"
  "show_rg"
  "show_fzf"
  "show_fd_rg_fzf"
  "show_eza"
  "show_direnv"
  "show_mental_model"
)
PAGE_DESCS=(
  "All tools at a glance"
  "Everyday helpers like bat, jq, glow"
  "Move around the filesystem"
  "Common git aliases and workflow"
  "Run Claude Code safely on your code"
  "Persistent terminal sessions"
  "Fast file finder, replaces find"
  "Fast text search inside files"
  "Interactive fuzzy picker"
  "Combine the search trio"
  "Modern ls replacement"
  "Per-project environment variables"
  "Cheat sheet of mental shortcuts"
)

# Snapshot the built-in arrays so assemble_pages can rebuild from a clean
# state after each save. assemble_pages then re-loads user pages and appends
# the "Ask Claude" entry at the end.
BUILTIN_PAGE_LABELS=("${PAGE_LABELS[@]}")
BUILTIN_PAGE_FUNCS=("${PAGE_FUNCS[@]}")
BUILTIN_PAGE_DESCS=("${PAGE_DESCS[@]}")
USER_PAGE_FILES=()
assemble_pages

# Find index of a label, or -1.
page_index_of() {
  local label="$1" i
  for i in "${!PAGE_LABELS[@]}"; do
    [[ "${PAGE_LABELS[$i]}" == "$label" ]] && { echo "$i"; return; }
  done
  echo -1
}

# Empty trap so SIGWINCH (terminal resize) interrupts read and triggers a redraw.
trap : WINCH

# Wrap a single line (with embedded ANSI codes) into chunks no wider than $2
# visible columns. Result goes into global array WRAPPED. ANSI sequences are
# preserved as-is and don't count toward visible width.
visual_wrap() {
  local line="$1" cols="$2"
  WRAPPED=()
  if (( cols <= 0 )); then WRAPPED=("$line"); return; fi
  local rest="$line" current="" cur=0
  local ansi_re=$'^\x1b\\[[0-9;]*[a-zA-Z]'
  while [[ -n "$rest" ]]; do
    if [[ "$rest" =~ $ansi_re ]]; then
      current+="${BASH_REMATCH[0]}"
      rest="${rest:${#BASH_REMATCH[0]}}"
    else
      current+="${rest:0:1}"
      rest="${rest:1}"
      cur=$(( cur + 1 ))
      if (( cur >= cols )); then
        WRAPPED+=("$current")
        current=""
        cur=0
      fi
    fi
  done
  if [[ -n "$current" ]] || (( ${#WRAPPED[@]} == 0 )); then
    WRAPPED+=("$current")
  fi
}

cycle_pages() {
  local idx="$1" total="${#PAGE_LABELS[@]}"
  local output rows cols last_cols view max_off offset key rest discard
  local label line status i end new_idx
  local -a raw_lines lines

  while true; do
    # Re-capture the page only when we move between pages.
    output=$(render_page "$idx")
    raw_lines=()
    while IFS= read -r line; do
      raw_lines+=("$line")
    done <<< "$output"
    last_cols=-1
    offset=0

    while true; do
      # Query the controlling terminal directly. `tput lines/cols` inside $()
      # reads stdout (which is the capture pipe, not the tty) and falls back
      # to terminfo defaults (24x80), so use stty size on /dev/tty instead.
      local sz
      sz=$(stty size </dev/tty 2>/dev/null) || sz="24 80"
      rows=${sz%% *}
      cols=${sz#* }
      [[ "$rows" =~ ^[0-9]+$ ]] || rows=24
      [[ "$cols" =~ ^[0-9]+$ ]] || cols=80

      # Re-wrap only when the terminal width changes (or first time on this page).
      if (( cols != last_cols )); then
        lines=()
        for line in "${raw_lines[@]}"; do
          visual_wrap "$line" "$cols"
          lines+=("${WRAPPED[@]}")
        done
        last_cols=$cols
      fi

      view=$(( rows - 2 ))
      (( view < 5 )) && view=5
      max_off=$(( ${#lines[@]} - view ))
      (( max_off < 0 )) && max_off=0
      (( offset > max_off )) && offset=$max_off
      (( offset < 0 )) && offset=0

      tput clear 2>/dev/null || clear
      end=$(( offset + view ))
      (( end > ${#lines[@]} )) && end=${#lines[@]}
      for (( i=offset; i<end; i++ )); do
        printf '%s\n' "${lines[$i]}"
      done

      # Pin the status line to the bottom row of the terminal regardless of
      # how much body content was printed.
      tput cup $(( rows - 1 )) 0 2>/dev/null

      label=${PAGE_LABELS[$idx]}
      local KEY="${BOLD}${CYAN}" SEP="  ${DIM}·${RESET}  " prefix
      if (( max_off > 0 )); then
        prefix="${DIM}[$((idx+1))/$total $label] $((offset+1))-$end/${#lines[@]}${RESET}"
        status="${prefix}${SEP}${KEY}h/l${RESET} Pages${SEP}${KEY}j/k${RESET} Scroll${SEP}${KEY}g/G${RESET} Top/Bot${SEP}${KEY}a${RESET} Ask${SEP}${KEY}m${RESET} Menu${SEP}${KEY}q${RESET} Quit"
      else
        prefix="${DIM}[$((idx+1))/$total $label]${RESET}"
        status="${prefix}${SEP}${KEY}h/l${RESET} Pages${SEP}${KEY}a${RESET} Ask${SEP}${KEY}m${RESET} Menu${SEP}${KEY}q${RESET} Quit"
      fi
      # Truncate status to one visual row so it never wraps; append RESET in
      # case the wrap point fell inside an unclosed color sequence.
      visual_wrap "$status" "$cols"
      printf '%s%s' "${WRAPPED[0]}" "$RESET"

      # An empty key means SIGWINCH (or other interrupt) — just redraw.
      IFS= read -rsn1 key || true
      [[ -z "$key" ]] && continue
      case "$key" in
        $'\x1b')
          IFS= read -rsn2 -t 0.05 rest || true
          case "$rest" in
            '[A') (( offset-- )) ;;
            '[B') (( offset++ )) ;;
            '[C') idx=$(( (idx+1) % total )); break ;;
            '[D') idx=$(( (idx-1+total) % total )); break ;;
            '[H') offset=0 ;;
            '[F') offset=$max_off ;;
            '[1') IFS= read -rsn1 -t 0.05 discard || true; offset=0 ;;
            '[4') IFS= read -rsn1 -t 0.05 discard || true; offset=$max_off ;;
            '[5') IFS= read -rsn1 -t 0.05 discard || true; (( offset -= view )) ;;
            '[6') IFS= read -rsn1 -t 0.05 discard || true; (( offset += view )) ;;
          esac
          ;;
        n|N|l|L) idx=$(( (idx+1) % total )); break ;;
        p|P|h|H) idx=$(( (idx-1+total) % total )); break ;;
        j|J)  (( offset++ )) ;;
        k|K)  (( offset-- )) ;;
        ' ')  (( offset += view )) ;;
        b|B)  (( offset -= view )) ;;
        g)    offset=0 ;;
        G)    offset=$max_off ;;
        a|A)
          ask_claude_flow
          # User pages may have been added, rebuild and refresh the count.
          assemble_pages
          total="${#PAGE_LABELS[@]}"
          if [[ -n "$ASK_JUMP_LABEL" ]]; then
            new_idx=$(page_index_of "$ASK_JUMP_LABEL")
            (( new_idx >= 0 )) && idx=$new_idx
          fi
          (( idx >= total )) && idx=$(( total - 1 ))
          break
          ;;
        m|M)  return 0 ;;
        q|Q)  clear; exit 0 ;;
      esac
    done
  done
}

show_menu() {
  local choice labels start_idx i header label_w
  local KEY="${BOLD}${CYAN}" SEP="  ${DIM}·${RESET}  "

  while true; do
    clear
    printf '%s%s' "$CYAN" "$BOLD"
    printf '┌────────────────────────────────────────────────────────────┐\n'
    printf '│                    TERMINAL TOOLS MENU                    │\n'
    printf '└────────────────────────────────────────────────────────────┘\n'
    printf '%s' "$RESET"

    # Pad labels to a common width so descriptions line up in a column.
    label_w=0
    for i in "${!PAGE_LABELS[@]}"; do
      (( ${#PAGE_LABELS[$i]} > label_w )) && label_w=${#PAGE_LABELS[$i]}
    done

    labels=""
    for i in "${!PAGE_LABELS[@]}"; do
      labels+=$(printf '%-*s  %s%s%s' "$label_w" "${PAGE_LABELS[$i]}" \
        "$DIM" "${PAGE_DESCS[$i]}" "$RESET")$'\n'
    done
    labels+="Quit"

    local nav_header="${KEY}j/k${RESET} Navigate${SEP}${KEY}l${RESET} Open${SEP}${KEY}f${RESET} Filter${SEP}${KEY}esc${RESET} Back${SEP}${KEY}ctrl-c${RESET} Quit"
    local filter_header="${DIM}type to filter${RESET}${SEP}${KEY}enter${RESET} Open${SEP}${KEY}esc${RESET} Back${SEP}${KEY}ctrl-c${RESET} Quit"

    # Modal navigation:
    #   Default (nav) mode: j/k/l navigate; any other char gets wiped instantly
    #     via change:clear-query so nothing accumulates in the prompt.
    #   Press f to enter filter mode: unbind the auto-wipe (and f itself, so
    #     'f' can appear in queries like 'fzf' / 'fd'). Prompt and header
    #     update to make the mode obvious.
    #   Press esc to clear, rebind, and restore the nav prompt/header.
    choice=$(printf "%s" "$labels" | fzf \
        --ansi \
        --height=70% \
        --border \
        --prompt="terminal-tools > " \
        --header "$nav_header" \
        --bind 'change:clear-query' \
        --bind 'j:down,k:up,l:accept,h:ignore' \
        --bind "f:unbind(change,f)+change-prompt(filter > )+change-header($filter_header)" \
        --bind "esc:clear-query+rebind(change,f)+change-prompt(terminal-tools > )+change-header($nav_header)")

    # fzf returns the entire rendered row (label + padding + description).
    # Strip everything from the first run of two-or-more spaces onward to
    # recover the original label, then trim trailing single space if any.
    choice="${choice%%  *}"
    choice="${choice%"${choice##*[![:space:]]}"}"

    case "$choice" in
      ""|"Quit") clear; exit 0 ;;
      *)
        start_idx=$(page_index_of "$choice")
        if [[ "$start_idx" -ge 0 ]]; then
          cycle_pages "$start_idx"
        fi
        ;;
    esac
  done
}

show_menu
