#!/bin/bash

INSTALL_URL="https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_amd64.zip"
INSTALL_DIR=$HOME/.local/bin

sudo apt install unzip

echo "I: Installing terraform"
if [[ ! -d ${INSTALL_DIR} ]]
then 
  mkdir -p ${INSTALL_DIR}
fi

curl -qs ${INSTALL_URL} -o ${INSTALL_DIR}/${INSTALL_URL##*/}
unzip ${INSTALL_DIR}/${INSTALL_URL##*/} -d ${INSTALL_DIR}/
rm ${INSTALL_DIR}/${INSTALL_URL##*/}
