#!/bin/bash
PKGS=(software-properties-common git curl wget gnupg openssl bash-completion python3 python3-pip python3-virtualenv python3-venv ca-certificates gnupg lsb-release man ripgrep libfuse2 npm cmake)

./install-pkgs.sh "${PKGS[@]}"
