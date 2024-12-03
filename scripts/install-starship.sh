#!/bin/bash

INSTALL_URL=https://starship.rs/install.sh

install ()
{
  # Install and configure starship
  echo "I: Installing starship"
  ln -s ${DIR_GIT_REPO}/${FILE_STARSHIPTOML} ${HOME}/.config/starship.toml
  curl -qs ${INSTALL_URL} | sh -
}

install
