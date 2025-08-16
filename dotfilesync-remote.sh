#!/usr/bin/env bash

echo -n "$(cat ./dotfiles-hosts)" | parallel -kd " " --color echo {} \; ssh {} -- git -C desksetup pull \\\; git -C \\\~/.ssh/ pull \\\; ./desksetup/dotfilesync.sh
