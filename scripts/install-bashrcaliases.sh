#!/bin/bash

# Install all necessary confs
echo "I: Installing confs.."
( [[ ! -L ~/.bashrc ]] && mv ~/.bashrc ~/.bashrc${BACKUP_SFX} ) || true
( [[ ! -L ~/.bash_aliases ]] && mv ~/.bash_aliases ~/.bash_aliases${BACKUP_SFX} ) || true
ln -s ${DIR_GIT_REPO}/${FILE_BASHRC} ${HOME}/ || true
ln -s ${DIR_GIT_REPO}/${FILE_BASHALIASES} ${HOME}/ || true

# vi: ft=bash
