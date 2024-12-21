#!/bin/bash

install_confs ()
{
  # Install all necessary confs
  echo "I: Installing confs.."
	[[ ! -d ~/.config ]] && mkdir ~/.config || true
  [[ ! -L ~/.config/starship.toml ]] && mv ~/.config/starship.toml ~/.config/starship.toml${BACKUP_SFX} || true
  [[ ! -L ~/.bashrc ]] && mv ~/.bashrc ~/.bashrc${BACKUP_SFX} || true
  [[ ! -L ~/.bash_aliases ]] && mv ~/.bash_aliases ~/.bash_aliases${BACKUP_SFX} || true
  [[ ! -L ~/.tmux.conf ]] && mv ~/.tmux.conf ~/.tmux.conf${BACKUP_SFX} || true
  # mv ~/.config/nvim ~/.config/nvim${BACKUP_SFX} || true
  # mv ~/.local/share/nvim ~/.local/share/nvim${BACKUP_SFX} || true
  ln -s ${DIR_GIT_REPO}/${FILE_BASHRC} ${HOME}/ || true
  ln -s ${DIR_GIT_REPO}/${FILE_BASHALIASES} ${HOME}/ || true
  ln -s ${DIR_GIT_REPO}/${FILE_TMUX} ${HOME}/ || true
  ln -s ${DIR_GIT_REPO}/${FILE_STARSHIPTOML} ${HOME}/.config/starship.toml || true
}

install_confs
