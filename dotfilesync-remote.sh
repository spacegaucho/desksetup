#!/usr/bin/env bash

# Directory of this script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Read dotfiles-hosts file relative to script directory
cat "$SCRIPT_DIR/dotfiles-hosts" | \
  parallel -kd '\n' 'printf "\033[0;35mHost: %s\033[0m\n" {} ; ssh "{}" -- "git -C ~/desksetup pull ;git -C ~/scripts pull ; TERM=xterm-256color ~/scripts/sh/dotfilesync.sh 2>&1" ; printf "\n"'

