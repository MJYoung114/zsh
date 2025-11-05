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


# allow `ctrl+a` to move you to the beginning of the line even in vi mode.
bindkey "^A" vi-beginning-of-line
# See more here: https://github.com/zsh-users/zsh/blob/master/Src/Zle/iwidgets.list

 
fpath=(~/.zsh/completions $fpath) 
autoload -U compinit && compinit

# Fix invisible cursor error when going back: https://github.com/zsh-users/zsh-syntax-highlighting/issues/171
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[cursor]=underline

## from: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^o' 'lfcd\n'

# ci" (more vim fixes)
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, di{ etc.. (some vim fixes)
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do  #'
    bindkey -M $m $c select-bracketed
  done
done

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# # fnm (I'm not sure if this is actually needed, it seems to work when I remove this. Anyway, left in to be safe)
export PATH="/Users/mjyoung/Library/Application Support/fnm"
eval "`fnm env --multi`"

# Setup golang
# export GOROOT=/snap/bin/go # install go via snap
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export PATH=~/bin:$PATH

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# Setup completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# This somehow gets git to have proper autocomplete even though hub is also aliased to git.
# setopt complete_aliases # this breaks the autocomplete for kubectl it seems...
source <(kubectl completion zsh)
alias k=kubectl
alias kns=kubens
alias kctx=kubectx

# complete -C '/usr/local/bin/aws_completer' aws

autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/bin/terraform terraform

alias oni2="~/bin/Onivim.AppImage --force-device-scale-factor 2"

. ~/.private_scripts.sh


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

alias python="python3"

# Flux for kubernetes
. <(flux completion zsh)

complete -o nospace -C /usr/bin/terraform terraform

#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: /run/user/1000/fnm_multishells/75917_1689530499555/bin/gt completion >> ~/.zshrc
#    or /run/user/1000/fnm_multishells/75917_1689530499555/bin/gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" /run/user/1000/fnm_multishells/75917_1689530499555/bin/gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###

# Add thefuck command
# eval "$(thefuck --alias fu)"

# Use fzf to view files with a preview
alias f='fzf --preview "bat --color "always" {}"'

# # ls, but a bit nicer
# alias ls='exa'
# alias ll='exa -l'

# Better highlighting etc than cat.
#alias cat='bat' # leaving this here as a reminder - rather just type bat.
# man kindof sucks.
alias man='tldr'


## Keep bash history neat:
setopt HIST_IGNORE_ALL_DUPS

setopt EXTENDED_HISTORY

# function shorten_cluster() {
#     local cluster=$1
#     # To shorten the cluster name, you can use the following line:
#     cluster=${cluster: -10}

#     # To set an alias, you can use an associative array like the following:
#     declare -A cluster_alias_map
#     cluster_alias_map["very-long-cluster-name"]="alias1"
#     cluster_alias_map["another-long-cluster-name"]="alias2"

#     if [[ ${cluster_alias_map[$cluster]+_} ]]; then
#         echo "${cluster_alias_map[$cluster]}"
#     else
#         echo "$cluster"
#     fi
# }

# export KUBE_PS1_CLUSTER_FUNCTION=shorten_cluster

# # Setup ps1 (kubernetes prompt) [unfortunately this is very long for AWS clusters]
# source /home/jasoons/Documents/config/kube-ps1/kube-ps1.sh
# PROMPT='$(kube_ps1)'$PROMPT # or RPROMPT='$(kube_ps1)'
export AWS_PROFILE=envio
export SOPS_AGE_KEY_FILE=/Users/mjyoung/Documents/envio.txt

unalias gt # gt is used for graphite
export PATH="/Users/mjyoung/Library/Application Support/fnm":/opt/homebrew/bin:/home/mjyoung/.fnm:/Users/mjyoung/bin:/Users/mjyoung/go/bin:/bin:/snap/bin:/home/jasoons/.deno/bin:/Users/mjyoung/bin:/Users/mjyoung/go/bin:/bin:/snap/bin:/usr/local/bin:/usr/local/sbin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/mjyoung/.cargo/bin:/home/jasoons/.local/bin:/Users/mjyoung/.fzf/bin:/home/jasoons/.foundry/bin:/home/jasoons/.local/bin:/home/jasoons/.foundry/bin:/home/jasoons/.local/bin

eval "`fnm env`"

