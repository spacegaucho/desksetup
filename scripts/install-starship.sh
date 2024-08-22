#!/bin/bash

install_starship ()
{
  # Install and configure starship
  echo "I: Installing starship"
  ln -s ${DIR_GIT_REPO}/${FILE_STARSHIPTOML} ${HOME}/.config/starship.toml
  curl -s https://starship.rs/install.sh -o /tmp/install_starship.sh
  sh /tmp/install_starship.sh -y
  rm /tmp/install_starship.sh
}

install_starship
