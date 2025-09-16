#!/usr/bin/env bash
# shellcheck source=/dev/null
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script/246128#246128

BASE_NAME="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

source "${BASE_NAME}"/config.sh
source "${BASE_NAME}"/files/misc/stdlib.bash

SCRIPTS_DIR="${BASE_NAME}/scripts"

find_cmd() {
  find "${SCRIPTS_DIR}" -type f -name 'configure-*' -or -name 'install-*'
}

fzf_cmd() {
  fzf --preview 'bat -f {}' --preview-window right:50%
}

pre_req() {
  for PRE_REQ in ${1}; do
    if ! which "${PRE_REQ}" &>/dev/null; then
      if userInput "Required package: ${PRE_REQ} not present.. do you want to install it now?"; then
        if source "${SCRIPTS_DIR}"/install-"${PRE_REQ}".sh; then
          msgOK "Successfully installed ${PRE_REQ}"
        else
          msgError "Error installing ${PRE_REQ}"
          exit 1
        fi
      else
        msgError "Missing required applications: ${PRE_REQ}"
        exit 1
      fi
    fi
  done
}

pre_req fzf

# ANSI quoting to interpret \n as newline -> $'\n'
IFS=$'\n' read -r -d '' -a SELECTED < <( find_cmd | fzf_cmd )

for i in "${!SELECTED[@]}"; do
  echo Running "${SELECTED[i]}"
  source "${SELECTED[i]}"
done


