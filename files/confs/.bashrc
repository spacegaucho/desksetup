#
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# ~/.bashrc

test -e $(which starship) && eval "$(starship init bash)"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTTIMEFORMAT="%d/%m/%y %T "
HISTSIZE=1000000000
HISTFILESIZE=200000000000

shopt -s histappend
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    alias grep='grep --color=auto'
    alias rgrep='grep -r --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.hidden.bash_aliases ]; then
    . ~/.hidden.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

bind 'set show-all-if-ambiguous on'

export GOPATH=$HOME/gopath
export PIPPATH=$HOME/.local/bin
export PATH=$PIPPATH:$PIPPATH/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export KUBECONFIG=$HOME/.kube/config
export KUBE_EDITOR="nvim"

source <(kubectl completion bash)
complete -F __start_kubectl k

[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash

[[ -z ${TMUX} ]] && tmux -ls &>/dev/null && echo -e "\e[1;33mWarning:\e[0m Tmux running in another terminal.."

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

FZF_BASH_COMP_FILE="$HOME/git/fzf-tab-completion/bash/fzf-bash-completion.sh"
[ ! -f $FZF_BASH_COMP_FILE ] && mkdir -p "${FZF_BASH_COMP_FILE%/*}" && curl "https://raw.githubusercontent.com/lincheney/fzf-tab-completion/master/bash/fzf-bash-completion.sh" -o "${FZF_BASH_COMP_FILE}" && echo "I: bash_completion for fzf setup correctly"
source $HOME/git/fzf-tab-completion/bash/fzf-bash-completion.sh 
bind -x '"\t": fzf_bash_completion'
export K9S_CONFIG_DIR="$HOME/.config/k9s"
#export XDG_CONFIG_HOME="$HOME/.config"
