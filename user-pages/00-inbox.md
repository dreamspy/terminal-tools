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
