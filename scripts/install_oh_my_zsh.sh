#!/usr/bin/env bash
set -euo pipefail

# Install Oh My Zsh unattended if not present
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh already installed at $HOME/.oh-my-zsh"
  exit 0
fi

echo "Installing Oh My Zsh (unattended)..."
export RUNZSH=no
export CHSH=no

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
  echo "Installation failed" >&2
  exit 1
}

echo "Oh My Zsh installation completed."

