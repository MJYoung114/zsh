export ZSH="$HOME/.oh-my-zsh"

# Load Oh My Zsh if available; otherwise use a minimal safe fallback
if [ -d "$ZSH" ]; then
  ZSH_THEME="robbyrussell"
  plugins=(git)
  source "$ZSH/oh-my-zsh.sh"
else
  setopt prompt_subst
  PROMPT='%n@%m:%~ %# '
fi

# User configuration area (safe to extend)
# export EDITOR="code -w"
# alias ll='ls -lah'

