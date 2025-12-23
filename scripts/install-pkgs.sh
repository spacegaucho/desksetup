#!/bin/bash

if [[ -e /etc/lsb-release ]]; then
  ./ubuntu-pkgs-installer.sh "$@"
elif [[ -e /etc/arch-release ]]; then
  ./arch-pkgs-installer.sh "$@"
fi
  
