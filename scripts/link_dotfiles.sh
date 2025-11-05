#!/usr/bin/env bash
set -euo pipefail

repo_root="$HOME/zsh"
dotfiles_dir="$repo_root/dotfiles"
backups_root="$repo_root/backups"
timestamp="$(date +%Y%m%d-%H%M%S)"
backup_dir="$backups_root/$timestamp"

mkdir -p "$backup_dir"

link_one() {
  local name="$1"
  local src="$dotfiles_dir/$name"
  local dst="$HOME/$name"

  if [ ! -e "$src" ]; then
    echo "[SKIP] Missing source: $src" >&2
    return 0
  fi

  if [ -L "$dst" ]; then
    # If it's already the correct symlink, keep it
    local target
    target="$(readlink "$dst")"
    if [ "$target" = "$src" ]; then
      echo "[OK] Symlink already set: $dst -> $src"
      return 0
    fi
    echo "[MOVE] Existing symlink to backup: $dst"
    mv "$dst" "$backup_dir/$(basename "$dst").symlink"
  elif [ -e "$dst" ]; then
    echo "[MOVE] Backing up existing file: $dst"
    mv "$dst" "$backup_dir/$(basename "$dst")"
  fi

  echo "[LINK] $dst -> $src"
  ln -s "$src" "$dst"
}

link_one ".zshrc"
link_one ".zprofile"

echo "Backups saved to: $backup_dir"
echo "Done."

