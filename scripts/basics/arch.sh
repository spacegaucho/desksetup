#!/bin/bash
# For arch linux

declare -A GIT_REPOS=(
	["$HOME/.config/nvim"]="ssh://git@gitlab.casa.lan:2222/mystuff/nvim"
	["$HOME/.i3"]="ssh://git@gitlab.casa.lan:2222/mystuff/i3config"
	["$HOME/git/scripts"]="ssh://git@gitlab.casa.lan:/mystuff/scripts" 
)

sudo pacman -Syu
sudo pacman -Sy rsync bash-completion tree i3 git make parted gcc npm go unzip

if [ ! -d "$HOME/.fonts" ]; then
  rsync -avh 192.168.1.20:/mnt/data/backup/fonts/ ~/.fonts/
fi

if [ ! -f "$HOME/.ssh/.git" ]; then 
  rsync -avh 192.168.1.20:.ssh ~/.ssh
fi

for DIR in "${!GIT_REPOS[@]}"
do
  echo "Working on: ${DIR}, ${GIT_REPOS[${DIR}]}"
  git clone "${GIT_REPOS[${DIR}]}" "${DIR}" || true
done

# AUDIO
sudo pacman -Sy pipewire-audio pipewire-pulse wireplumber pipewire bluez bluetui
systemctl --user enable pipewire.service --now
systemctl --user enable pipewire-pulse.service --now
sudo systemctl enable --now bluetooth.service

# GOODIES
sudo pacman -Sy obsidian keepassxc syncthing firefox chromium
systemctl --user enable --now syncthing.service 
