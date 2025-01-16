#!/bin/bash
URL_GITLAB_CASA_LAN_NVIM="ssh://gitlab.casa.lan:2222/mystuff/nvim.git"
URL_NVIM="https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"

pip3 install --upgrade pynvim
curl -Lo nvim ${URL_NVIM}
chmod 755 nvim
sudo install nvim /usr/bin
rm nvim
mkdir -p ~/.config/nvim
git clone ${URL_GITLAB_CASA_LAN_NVIM} ~/.config/nvim --depth 1 || git -C ~/.config/nvim pull
