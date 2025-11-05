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
link_one ".vimrc"

# Link config files under ~/.config
mkdir -p "$HOME/.config"

link_to() {
  local src_rel="$1"      # e.g., config/aliasrc
  local dst_abs="$2"      # e.g., $HOME/.config/aliasrc
  local src="$dotfiles_dir/$src_rel"

  if [ ! -e "$src" ]; then
    echo "[SKIP] Missing source: $src" >&2
    return 0
  fi

  if [ -L "$dst_abs" ]; then
    local target
    target="$(readlink "$dst_abs")"
    if [ "$target" = "$src" ]; then
      echo "[OK] Symlink already set: $dst_abs -> $src"
      return 0
    fi
    echo "[MOVE] Existing symlink to backup: $dst_abs"
    mv "$dst_abs" "$backup_dir/$(basename "$dst_abs").symlink"
  elif [ -e "$dst_abs" ]; then
    echo "[MOVE] Backing up existing file: $dst_abs"
    mv "$dst_abs" "$backup_dir/$(basename "$dst_abs")"
  fi

  echo "[LINK] $dst_abs -> $src"
  ln -s "$src" "$dst_abs"
}

link_to "config/aliasrc" "$HOME/.config/aliasrc"
link_to "config/shortcutrc" "$HOME/.config/shortcutrc"

echo "Backups saved to: $backup_dir"
echo "Done."

