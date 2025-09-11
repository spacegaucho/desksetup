#!/bin/bash
#shellcheck source=/dev/null

set -o vi
# bind -x '"\M-\C-l": "clear"'
bind -x '"\e[1;5L": "clear"'
export EDITOR="nvim"
shopt -s histappend
shopt -s checkwinsize
#bind 'set show-all-if-ambiguous on'

HISTCONTROL=ignoreboth
HISTTIMEFORMAT="%d/%m/%y %T "
HISTSIZE=1000000000
HISTFILESIZE=200000000000

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export GOPATH=$HOME/gopath
export PIPPATH=$HOME/.local/bin
export PATH=$PIPPATH:$PIPPATH/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:${GOPATH}/bin
export KUBE_EDITOR="nvim"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

#### <SOURCE USER STUFF> ######################################################

if [[ -d ~/.bashrc.d/ ]]
then
  for source_file in ~/.bashrc.d/*; do
    source "${source_file}"
  done
fi

#### </SOURCE USER STUFF> #####################################################

test -e "$(which starship)" && eval "$(starship init bash)"

#### <LEGACY CONFIG> ##########################################################

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

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#### </LEGACY CONFIG> #########################################################

#### <ALIAS> ##################################################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r "${HOME}/.dircolors" && eval "$(dircolors -b ${HOME}/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    alias grep='grep --color=auto'
    alias rgrep='grep -r --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f "${HOME}/.bash_aliases" ]; then
  . "${HOME}/.bash_aliases"
fi

#### </ALIAS> #################################################################

#### <CUSTOM CONF> ############################################################

# KUBECTL
source <(kubectl completion bash)
complete -F __start_kubectl k

# FZF
[ -f "$HOME/.fzf.bash" ] && FZF_DEFAULT_OPTS="--bind ctrl-n:down,ctrl-p:up" source "$HOME/.fzf.bash" 
[ -f "$HOME/git/fzf-tab-completion/bash/fzf-bash-completion.sh" ] && source "$HOME/git/fzf-tab-completion/bash/fzf-bash-completion.sh" && bind -x '"\t": fzf_bash_completion'

# TMUX
[[ -z ${TMUX} ]] && tmux -ls &>/dev/null && echo -e "\e[1;33mWarning:\e[0m Tmux running in another terminal.."
[ ! -d "${HOME}/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"

# K9s
export K9S_CONFIG_DIR="$HOME/.config/k9s"
#export XDG_CONFIG_HOME="$HOME/.config"

[ -f "${HOME}/.cargo/env" ] && . "$HOME/.cargo/env"

# KUBECH
if [[ -e ~/.kubech/kubech ]]; then
  source ~/.kubech/kubech
  source ~/.kubech/completion/kubech.bash
fi

# MISE
eval "$(~/.local/bin/mise activate bash)"

# USER FUNCTIONS
function check_x11() {
  CURRENT_XSERV=$(echo "${SSH_CONNECTION}" | awk '{print $1}')

  if [[ -n ${CURRENT_XSERV} ]]
  then
    export DISPLAY=${CURRENT_XSERV}:11.0
  else
    export DISPLAY=:0
  fi
}

function toggle_keyb() {
  if setxkbmap -print | grep 'alt-intl' 1>/dev/null 2>&1; then
    echo "I: changed keyboard to us" 
    setxkbmap -layout us -option nodeadkeys
  else
    echo "I: changed keyboard to us alt-intl" 
    setxkbmap -layout us -variant alt-intl -option nodeadkeys
  fi
}

# if which direnv > /dev/null; then eval "$(direnv hook bash)"; fi
if [[ -e ~/.asdf/asdf.sh ]]; then source "$HOME/.asdf/asdf.sh" && source "$HOME/.asdf/completions/asdf.bash"; fi
# source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/bashrc"

#### </CUSTOM CONF> ###########################################################
