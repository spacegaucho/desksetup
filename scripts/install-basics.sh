#!/bin/bash
APT_BASICS="software-properties-common git curl wget gnupg openssl bash-completion python3 python3-pip python3-virtualenv python3-venv ca-certificates gnupg lsb-release man ripgrep libfuse2 npm cmake"

DEBIAN_FRONTEND=noninteractive
sudo apt-get clean
sudo add-apt-repository universe
sudo apt-get update -y
sudo apt-get install -y "${APT_BASICS}"
