#!/bin/bash
CONF_FILE="config.ini"
CONFS="./files/confs/polybar"
DEST="/etc/polybar"

if [[ ! -d "${DEST}" ]]
then
  sudo mkdir -p "${DEST}"
fi

if [[ -L "${DEST}/${CONF_FILE}" ]]
then
  echo "I: ${DEST}/${CONF_FILE} already exists and is link"
elif [[ -f "${DEST}/${CONF_FILE}" ]]
then
  echo "I: ${DEST}/${CONF_FILE} already exists but is regular file, backing up"
  set -x
  sudo mv "${DEST}/${CONF_FILE}" "${DEST}/${CONF_FILE}${BACKUP_SFX}"
  set +x
else
  sudo ln -s "${DIR_GIT_REPO}/${CONFS}/${CONF_FILE}" "${DEST}/${CONF_FILE}"
fi


