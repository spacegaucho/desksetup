#!/bin/bash

install_all ()
{
  mkdir ~/git
  echo "I: Getting cloning/pulling repo.."
  git clone ${GIT_REPO} ${DIR_GIT_REPO} || git -C ${DIR_GIT_REPO} pull
  source ./scripts/install-basics.sh
  source ./scripts/install-confs.sh
  source ./scripts/install-fzf.sh
  source ./scripts/install-starship.sh 
  source ./scripts/install-nvim.sh
  source ./scripts/install-k8s-basics.sh
}

upgrade_all ()
{
  source ./scripts/install-fzf.sh
  source ./scripts/install-starship.sh 
  source ./scripts/install-nvim.sh
  source ./scripts/install-k8s-basics.sh
}

install_upgrade_specific ()
{
  CHOICE=$(
  whiptail --title "Select components" --notags --checklist "Selection" 10 80 4 \
    "fzf" "fzf" 0           \
    "starship" "starship" 0 \
    "nvim" "nvim" 0         \
    "k8s" "k8s" 0 3>&2 2>&1 1>&3 | tr -d '\"'
  )

  for TASK in ${CHOICE[@]}
  do 
    case ${TASK} in
      "fzf") 
        source ./scripts/install-fzf.sh
        ;;
      "starship")
        source ./scripts/install-starship.sh
        ;;
      "nvim")
        source  ./scripts/install-nvim.sh
        ;;
      "k8s")
        source ./scripts/install-k8s-basics.sh
        ;;
      *)
        echo "${CHOICE}"
        ;;
    esac 
  done
}

main ()
{
  source ./config.sh
  CHOICE=$(
  whiptail --title "Installation options" --notags --menu "Select" 10 80 4 \
    "1" "Install all from scratch"                         \
    "2" "Install/Upgrade all components (except basics)"   \
    "3" "Install/Upgrade specific components"              \
    "99" "Exit" 3>&2 2>&1 1>&3
  )

  case $CHOICE in
    "1") 
      install_all
      ;;
    "2")
      upgrade_all
      ;;
    "3")
      install_upgrade_specific
      ;;
    "99")
      exit 0
      ;;
  esac  
}

main
