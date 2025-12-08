#!/usr/bin/env bash
export PATH="$HOME/desksetup:$HOME/desksetup/files/misc/:$PATH"

. stdlib.bash

CONFS="$HOME/git/desksetup/
$HOME/.config/nvim/
$HOME/.ssh/
$HOME/.i3/
$HOME/scripts/"

for CONF_DIR in ${CONFS}
do
  if [[ -d "${CONF_DIR}" ]]; then
    msgInfo "updating ${CONF_DIR}"
    git -C "${CONF_DIR}" pull
  else
    msgWarning "${CONF_DIR} does not exist in this host, skipping"
  fi
done

nvim --headless -c 'Lazy! sync' -c 'MasonUpdateAll' -c 'qall!'
