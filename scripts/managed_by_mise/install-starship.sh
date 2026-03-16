#!/bin/bash

INSTALL_URL=https://starship.rs/install.sh

# Install and configure starship
echo "I: Installing starship"
sh ${BASE_NAME}/scripts/starship-installer.sh -f --bin-dir ~/.local/bin

source ${BASE_NAME}/scripts/configure-starship.sh
