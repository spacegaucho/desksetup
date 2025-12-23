#!/bin/bash
alias reset='tput reset'
alias apt-get='sudo apt-get'
alias gitchecker='bash ~/scripts/sh/git-checker.sh'
alias gitbranchhist="git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"
alias g-scripts="cd ~/git/scripts/"
alias g-tmp="cd ~/tmp/"
alias k="kubectl"
alias l='ls -hCF --color'
alias la='ls -hA --color'
alias ll='ls -ahlF --color'
alias lls='ls -ahlFSr --color'
alias llt='ls -ahlFtr --color'
alias p='ping'
alias s="ssh"
alias sk="~/git/scripts/sh/ssh-login-keytransfer.sh"
alias tf="terraform"
alias venv_ansible='. ~/virtualenv/py3.12_ansible/bin/activate'
# Using XDG_CACHE_HOME=/tmp solves an issue where a path is too long https://github.com/neovim/neovim/issues/29372#issuecomment-2307019287
alias vi='nvim'
alias vim='nvim'
alias nvim='nvim'
alias vps="~/scripts/sh/vpnpsitadmin.sh"
alias vy='XDG_CACHE_HOME=/tmp nvim -c "set syntax=yaml"'
alias xw='~/scripts/sh/xw.sh'
alias cal='ncal -b'
alias ssh-keygen-rsa4096="ssh-keygen -t rsa -b 4096 -N '' -C '' -f " # better yet, make a script
# Git
alias ga='git add -A'
alias gc='git commit-autogen.sh'
alias gp='git push origin HEAD'
alias gac='ga && gc'
alias gacp='ga && gc && gp'
