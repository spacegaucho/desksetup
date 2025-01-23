#!/usr/bin/env bash
# v0.1

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
reset=$(tput sgr0)

# Functions
drawLine() {
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}
msgInfo() {
    MSG=${1}
    echo "${blue}[II] ${MSG}${reset}"
}
msgOK() {
    MSG="$1"
    echo "${green}[OK] ${MSG}${reset}"
}
msgWarning() {
    MSG="$1"
    echo "${yellow}[!!] ${MSG}${reset}"
}
msgError() {
    MSG="$1"
    echo "${red}[EE] ${MSG}${reset}"
}

userInput() {
  ARG="${1}"
  read -r -p "${green:-}${ARG:=Are you sure?} [y/n] (Default n):${reset:-} " apply_reponse
  if [ "${apply_reponse}" == "y" ]
  then
    return 0
  else
    return 1
  fi
}

chkRoot() {
  if [ "$(whoami)" == "root" ]
  then
    msgError "Do not run this script as root."
    exit 1
  fi
}

chkBranch() {
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  msgInfo "Using branch: ${CURRENT_BRANCH}"
}
