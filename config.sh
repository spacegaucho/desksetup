#!/bin/bash
# Files
FILE_BASHALIASES="files/confs/.bash_aliases"
FILE_BASHRC="files/confs/.bashrc"
FILE_TMUX="files/confs/.tmux.conf"
FILE_STARSHIPTOML="files/confs/starship.toml"
FILE_KREWINSTALL="files/krewcurlinstall.sh"

# Urls
URL_LIGHLINE="https://github.com/itchyny/lightline.vim"

# Other
# neovim and tmux are going to be installed from urls
APT_BASICS="software-properties-common git curl wget gnupg openssl bash-completion python3 python3-pip python3-virtualenv python3-venv ca-certificates gnupg lsb-release man ripgrep libfuse2 npm"
GIT_REPO="https://github.com/spacegaucho/desksetup"
DIR_GIT_REPO="${HOME}/git/desksetup"
COMMAND_OUT="/tmp/desksetup.log"
BACKUP_SFX=".$(date +%s).bk"

# vi: ft=bash
