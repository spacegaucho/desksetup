#!/usr/bin/env bash

echo -n "$(cat ./dotfiles-hosts)" | parallel -kd ' ' "echo ==== Host: {} ==== \; ssh {} -- git -C desksetup pull \\\; TERM=xterm-256color ~/desksetup/dotfilesync.sh \; echo"
