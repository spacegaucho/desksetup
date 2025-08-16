#!/usr/bin/env bash
export PATH="$HOME/desksetup:$HOME/desksetup/misc/:$PATH"

. stdlib.bash

CONFS="$HOME/git/desksetup/
$HOME/.config/nvim/
$HOME/.i3/
$HOME/scripts/"

for CONF_DIR in ${CONFS}
do
  if [[ -d "${CONF_DIR}" ]]; then
    echo "I: updating ${CONF_DIR}"
    git -C "${CONF_DIR}" pull
  else
    echo "${CONF_DIR} does not exist in this host, skipping"
  fi
done

