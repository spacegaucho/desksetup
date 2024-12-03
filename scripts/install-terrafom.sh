#!/bin/bash

INSTALL_URL=https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_amd64.zip
INSTALL_DIR=$HOME/.local/bin

install ()
{
  if ! which unzip; then echo E: Install unzip and retry; exit 1; fi
  echo "I: Installing terraform"
  ln -s ${DIR_GIT_REPO}/${FILE_STARSHIPTOML} ${HOME}/.config/starship.toml
  if [[ ! -d ${INSTALL_DIR} ]]
  then 
    mkdir -p ${INSTALL_DIR}
  fi
  curl -qs ${INSTALL_URL} -o ${INSTALL_DIR}
  unzip ${INSTALL_DIR}/${INSTALL_URL##*/}

}

install
