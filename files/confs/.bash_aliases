#!/bin/bash
alias reset='tput reset'
alias apt-get='sudo apt-get'
alias gitchecker='bash ~/scripts/sh/git-checker.sh'
alias gitbranchhist="git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'"
alias g-scripts="cd ~/git/scripts/"
alias g-tmp="cd ~/tmp/"
alias k="kubectl"
alias kcx="kubectl-ctx"
alias kns="kubectl-ns"
alias l='ls -hCF --color'
alias la='ls -hA --color'
alias ll='ls -ahlF --color'
alias lls='ls -ahlFSr --color'
alias llt='ls -ahlFtr --color'
alias p='ping'
alias s="ssh"
alias sk="~/git/scripts/sh/sshlogin-keytransfer.sh"
alias ssh_clean_offending="~/scripts/sh/ssh_remove_offending_ip_key.sh"
alias tf="terraform"
alias venv_ansible='. ~/virtualenv/py3.12_ansible/bin/activate'
# Using XDG_CACHE_HOME=/tmp solves an issue where a path is too long https://github.com/neovim/neovim/issues/29372#issuecomment-2307019287
alias vi='nvim'
alias vim='nvim'
alias nvim='nvim'
alias vps="~/scripts/sh/vpnpsitadmin.sh"
alias vy='XDG_CACHE_HOME=/tmp nvim -c "set syntax=yaml"'
alias xw='~/scripts/sh/xw.sh'
