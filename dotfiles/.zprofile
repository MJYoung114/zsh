# Homebrew environment (macOS universal)
if [ -d "/opt/homebrew" ]; then
  eval "$({ /opt/homebrew/bin/brew shellenv; } 2>/dev/null)"
fi
if [ -d "/usr/local" ]; then
  export PATH="/usr/local/bin:$PATH"
fi

# Prefer user bin if present
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

