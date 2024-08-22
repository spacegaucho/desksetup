#!/bin/bash

install_basics ()
{
  # Install basics + awscli and terraform
  DEBIAN_FRONTEND=noninteractive
  sudo apt-get clean
  sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo add-apt-repository universe
  sudo apt-get update -y
  sudo apt-get install -y ${APT_BASICS}
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg  | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  sudo apt-get update -y
  sudo apt-get install -y terraform
}

install_basics
