#
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.

# Customize to your needs...
export GOPATH=/Users/$USER/go
export PATH=$GOPATH/bin:$PATH
# Add snap to path
# export PATH="/snap/bin:$PATH"

# eval "$(fnm env --multi)"

 

# Setup fzf and fzf-z
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.fzf-z/fzf-z.plugin.zsh
export FZFZ_EXTRA_DIRS="~/Documents"
export FZFZ_SUBDIR_LIMIT=1


 

 
fpath=(~/.zsh/completions $fpath) 
autoload -U compinit && compinit

# Fix invisible cursor error when going back: https://github.com/zsh-users/zsh-syntax-highlighting/issues/171
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[cursor]=underline

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Ensure Homebrew bin on PATH for non-login shells (so fnm is discoverable)
if [[ "$OSTYPE" == darwin* ]] && [ -d "/opt/homebrew/bin" ]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# fnm (guarded; prefer fnm over nvm)
if command -v fnm >/dev/null 2>&1; then
  # Add user's fnm dir with space-safe path if needed
  if [ -d "/Users/mjyoung/Library/Application Support/fnm" ]; then
    export PATH="$PATH:/Users/mjyoung/Library/Application Support/fnm"
  fi
  eval "$(fnm env --use-on-cd)"
fi

# Setup golang
# export GOROOT=/snap/bin/go # install go via snap
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export PATH=~/bin:$PATH

 

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# Setup completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# This somehow gets git to have proper autocomplete even though hub is also aliased to git.
# setopt complete_aliases # this breaks the autocomplete for kubectl it seems...
source <(kubectl completion zsh)

# complete -C '/usr/local/bin/aws_completer' aws

autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/bin/terraform terraform


## useful functions:
take ()
{
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

  
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

 

complete -o nospace -C /usr/bin/terraform terraform

 


 


## Keep bash history neat:
setopt HIST_IGNORE_ALL_DUPS

setopt EXTENDED_HISTORY

export AWS_PROFILE=envio
export SOPS_AGE_KEY_FILE=/Users/mjyoung/Documents/envio.txt

 
