#!/usr/bin/env bash
export PATH="$HOME/desksetup:$HOME/desksetup/files/misc:$PATH"

. stdlib.bash

CONFS="$HOME/git/desksetup/
$HOME/.config/nvim/
$HOME/.ssh/
$HOME/.i3/
$HOME/scripts/"

for CONF_DIR in ${CONFS}
do
  if [[ -d "${CONF_DIR}" ]]; then
    msgInfo "${CONF_DIR}"
    git -C "${CONF_DIR}" pull
    git -C "${CONF_DIR}" status -s
    git -C "${CONF_DIR}" add -A
    git -C "${CONF_DIR}" commit -m "auto saved by $0"
    git -C "${CONF_DIR}" push origin HEAD
  else
    msgWarning "${CONF_DIR} does not exist in this host, skipping"
  fi
done

msgInfo "Updating Mason"
nvim --headless -c 'Lazy! sync' -c 'MasonUpdateAll' -c 'qall!' &>/dev/null
