#!/usr/bin/env bash

cat ./dotfiles-hosts | parallel -kd ' ' 'printf "\033[0;35mHost: %s\033[0m\n" {} ; ssh "{}" -- git -C desksetup pull \\\; TERM=xterm-256color ~/desksetup/dotfilesync.sh ; printf "\n"'
