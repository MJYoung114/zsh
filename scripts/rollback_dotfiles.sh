#!/usr/bin/env bash
set -euo pipefail

repo_root="$HOME/zsh"
backups_root="$repo_root/backups"

if [ ! -d "$backups_root" ]; then
  echo "No backups directory found: $backups_root" >&2
  exit 1
fi

latest_backup="$(ls -1 "$backups_root" | sort | tail -n 1 || true)"
if [ -z "$latest_backup" ]; then
  echo "No backup snapshots found in $backups_root" >&2
  exit 1
fi

backup_dir="$backups_root/$latest_backup"
echo "Restoring from backup: $backup_dir"

restore_one() {
  local name="$1"
  local dst="$HOME/$name"
  local src_file="$backup_dir/$name"
  local src_symlink="$backup_dir/$name.symlink"

  if [ -L "$dst" ] || [ -e "$dst" ]; then
    echo "[REMOVE] Removing current: $dst"
    rm -rf "$dst"
  fi

  if [ -e "$src_file" ]; then
    echo "[RESTORE] $dst from $src_file"
    mv "$src_file" "$dst"
  elif [ -e "$src_symlink" ]; then
    echo "[RESTORE] $dst from saved symlink"
    mv "$src_symlink" "$dst"
  else
    echo "[WARN] No backup found for $name" >&2
  fi
}

restore_one ".zshrc"
restore_one ".zprofile"

echo "Rollback complete."

