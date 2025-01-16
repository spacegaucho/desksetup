#!/bin/bash
CONF_FILE="tmux.conf"
CONFS="./files/confs"
DEST="${HOME}"


if [[ ! -d "${DEST}" ]]
then
  mkdir -p "${DEST}"
fi

if [[ -L "${DEST}/${CONF_FILE}" ]]
then
  echo "I: ${DEST}/${CONF_FILE} already exists and is link"
elif [[ -f "${DEST}/${CONF_FILE}" ]]
then
  echo "I: ${DEST}/${CONF_FILE} already exists but is regular file, backing up"
  set -x
  mv "${DEST}/${CONF_FILE}" "${DEST}/${CONF_FILE}${BACKUP_SFX}"
  set +x
else
  ln -s "${DIR_GIT_REPO}/${CONFS}/${CONF_FILE}" "${DEST}/${CONF_FILE}"
fi
