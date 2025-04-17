#!/bin/bash
CONF_DIR="kitty"
CONFS="./files/confs"
DEST="${HOME}/.config"

if [[ ! -d "${DEST}" ]]
then
  mkdir -p "${DEST}"
fi

if [[ -L "${DEST}/${CONF_DIR}" ]]
then
  echo "I: ${DEST}/${CONF_DIR} already exists and is link"
elif [[ -d "${DEST}/${CONF_DIR}" ]]
then
  echo "I: ${DEST}/${CONF_DIR} already exists but is directory, backing up"
  set -x
  mv "${DEST}/${CONF_DIR}" "${DEST}/${CONF_DIR}${BACKUP_SFX}"
  set +x
else
  ln -s "${DIR_GIT_REPO}/${CONFS}/${CONF_DIR}" "${DEST}/${CONF_DIR}"
fi
