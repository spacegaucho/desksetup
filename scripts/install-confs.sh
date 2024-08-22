#!/bin/bash

install_confs ()
{
  # Install all necessary confs
  echo "I: Installing confs.."
	mkdir ~/.config
  mv ~/.config/starship.toml ~/.config/starship.toml${BACKUP_SFX}
  mv ~/.bashrc ~/.bashrc${BACKUP_SFX}
  mv ~/.bash_aliases ~/.bash_aliases${BACKUP_SFX}
  mv ~/.tmux.conf ~/.tmux.conf${BACKUP_SFX}
  mv ~/.config/nvim ~/.config/nvim${BACKUP_SFX}
  mv ~/.local/share/nvim ~/.local/share/nvim${BACKUP_SFX}
  ln -s ${DIR_GIT_REPO}/${FILE_BASHRC} ${HOME}/
  ln -s ${DIR_GIT_REPO}/${FILE_BASHALIASES} ${HOME}/
  ln -s ${DIR_GIT_REPO}/${FILE_TMUX} ${HOME}/
}

install_confs
