#!/bin/bash
URL_FZF="https://github.com/junegunn/fzf.git"

install_fzf ()
{
  # Install fzf
  echo "I: Installing fzf.."
  git clone --depth 1 ${URL_FZF} ~/.fzf || git pull ~/.fzf && ~/.fzf/install --all
}

install_fzf
