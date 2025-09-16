# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=500000
setopt interactivecomments
unsetopt beep

bindkey -v
bindkey '^[[1;5C' forward-word     # Ctrl+right arrow
bindkey '^[[1;5D' backward-word    # Ctrl+left arrow

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

source ~/.bash_aliases
source ~/.bashrc.d/00_bashaliases
eval "$(starship init zsh)"

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

export GOPATH=$HOME/gopath
export PIPPATH=$HOME/.local/bin
export PATH=$PIPPATH:$PIPPATH/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export KUBECONFIG=$HOME/.kube/config
export KUBE_EDITOR="nvim"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
