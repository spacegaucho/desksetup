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
    git -C "${CONF_DIR}" pull 2>&1
    git -C "${CONF_DIR}" status -s 2>&1
    git -C "${CONF_DIR}" add -A 2>&1
    git -C "${CONF_DIR}" commit -m "auto saved by $0" 2>&1
    git -C "${CONF_DIR}" push origin HEAD 2>&1
  else
    msgWarning "${CONF_DIR} does not exist in this host, skipping"
  fi
done

msgInfo "Updating Mason"
echo ..
nvim --headless -c 'Lazy! sync' -c 'MasonUpdateAll' -c 'qall!' 2>&1 | tail -3
