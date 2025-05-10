URL_GITLAB_CASA_LAN_NVIM="ssh://gitlab.casa.lan:2222/mystuff/nvim.git"
mkdir -p ~/.config/nvim
git clone ${URL_GITLAB_CASA_LAN_NVIM} ~/.config/nvim --depth 1 || git -C ~/.config/nvim pull
