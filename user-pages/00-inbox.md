# 00_INBOX

> how do a see a directory tree

# Directory Tree

View folder structures quickly to understand project layout or navigate deeply nested directories.

## Quick view

```sh
tree
```
Shows folder tree with icons and 2 levels by default (your custom alias).

## Full tree

```sh
eza --tree
```
Display entire directory tree with no depth limit.

## Controlled depth

```sh
eza --tree --level=3
```
Show tree up to 3 levels deep (adjust the number as needed).

## Tree with details

```sh
eza --tree -lah
```
Tree view with file sizes, permissions, and hidden files.

## Tree with git status

```sh
eza --tree --git
```
Show file git status (modified, ignored, untracked) alongside tree.

---

## how to rename all jpeg tiles to jpg

# Rename JPEG to JPG

Bulk rename JPEG tile files to JPG extension using common zsh patterns.

## Quick single command

```bash
for file in *.jpeg; do mv "$file" "${file%.jpeg}.jpg"; done
```

## With fd (faster for many files)

```bash
fd -e jpeg -x mv {} {.}.jpg
```

## With find and rename

```bash
find . -name "*.jpeg" -exec sh -c 'mv "$1" "${1%.jpeg}.jpg"' _ {} \;
```

## Recursive (subdirectories)

```bash
fd -e jpeg -x mv {} {.}.jpg .
```

## Preview before running

```bash
fd -e jpeg -x echo mv {} {.}.jpg
```

Remove `echo` once you confirm the output looks right.

---

## how to use z and zi

# Smart Folder Jumping with Zoxide

Jump to frequently-used folders by name without full paths, using zoxide's `z` and `zi` commands.

## Basic Usage

- `z projectname` - Jump to a folder named "projectname" (matched by frecency, your most frequent/recent visits)
- `z` - Jump to your most-visited folder
- `z .` - Jump to current folder (not typically useful)

## Interactive Selection

- `zi` - Open interactive picker when multiple folders match the same name
- `zi projectname` - Pick from all folders containing "projectname" in the path

## Examples

```bash
z myproject      # Jump if you have one folder matching myproject
zi myproject     # Choose from multiple myproject folders
z src            # Jump to your most-visited /src folder
zi               # Choose from all your frecent folders
```

## How It Works

Zoxide learns your navigation patterns and ranks folders by frecency (visits × recency). Matches are case-insensitive. As you navigate with `cd`, zoxide tracks the folder automatically.

---

## running "sudo -iu <username>" on ubuntu does what

# Switch to another user with login shell

Switches to another user's login environment with sudo privileges, loading their shell configuration.

## What it does

- `sudo -iu <username>` switches to `<username>` as a full login shell
  - `-i` loads the user's login scripts (`~/.profile`, `~/.bash_profile`, etc.)
  - `-u <username>` specifies which user to switch to
  - You remain unprivileged (not root) unless `<username>` is `root`

## Examples

```bash
# Switch to 'appuser' login shell, loading their environment
sudo -iu appuser

# Switch to root with full login environment
sudo -iu root
```

## Common use cases

- Starting a service as a specific application user (`appuser`, `www-data`, etc.)
- Testing commands in another user's environment
- Debugging permission/configuration issues for a specific user
- Running cron jobs manually to replicate their context

## Related

- `sudo -u <username> <command>` – run a single command as user, no login shell
- `su - <username>` – switch user without sudo (requires their password)
