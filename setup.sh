#!/bin/bash
# DESCRIPTION: Install/setup minimum customization for bash.

# Files
FILE_BASHALIASES="files/confs/.bash_aliases"
FILE_BASHRC="files/confs/.bashrc"
FILE_KREWINSTALL="files/krewcurlinstall.sh"
FILE_STARSHIPTOML="files/confs/starship.toml"
FILE_TMUX="files/confs/.tmux.conf"

# Urls
URL_FZF="https://github.com/junegunn/fzf.git"
URL_HELM="https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"
URL_LIGHLINE="https://github.com/itchyny/lightline.vim"
URL_NVCHAD="https://github.com/NvChad/NvChad"
URL_NVIM="https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
URL_RIPGREP="https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb"
URL_DOCKERGPG="https://download.docker.com/linux/ubuntu/gpg"
URL_BASH_FZF_TAB_COMP="https://github.com/lincheney/fzf-tab-completion"

# Other
# neovim and tmux are going to be installed from urls
APT_BASICS="software-properties-common git curl wget gnupg openssl bash-completion python3 python3-pip python3-virtualenv python3-venv ca-certificates gnupg lsb-release man libfuse2 npm unzip"
GIT_REPO="https://github.com/spacegaucho/desksetup"
DIR_GIT_REPO="${HOME}/git/desksetup"
COMMAND_OUT="/tmp/desksetup.log"
BACKUP_SFX=".$(date +%s).bk"
FILE_DOCKERGPG="/usr/share/keyrings/docker-archive-keyring.gpg"

# Temp files
TMP_RIPGREP="/tmp/ripgrep.deb"

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
  curl -fsSL ${URL_DOCKERGPG} | sudo gpg --dearmor -o ${FILE_DOCKERGPG}
  sudo apt-get update -y
  sudo apt-get install -y terraform
}

install_nvim ()
{
  # Install nvim
  pip3 install --upgrade pynvim
  curl -Lo ${TMP_RIPGREP} ${URL_RIPGREP}
  sudo dpkg -i ${TMP_RIPGREP} 
  curl -Lo nvim ${URL_NVIM}
  chmod 755 nvim
  sudo install nvim /usr/bin
  rm nvim
  mkdir -p ~/.config/nvim
  git clone ${URL_NVCHAD} ~/.config/nvim --depth 1
}

install_k8sbasics ()
{
  # Install kubectl
  echo "I: Installing kubectl.."
  curl -Lso kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo chmod 755 kubectl
  if ! sudo install kubectl /usr/local/bin/; then echo "W: kubectl install failed! Ignore if already installed"; fi
  rm kubectl

  # Install krew
  echo "I: Installing krew.."
  if ! bash ${DIR_GIT_REPO}/${FILE_KREWINSTALL} ; then echo "W: krew install failed!"; fi
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
  if ! kubectl krew install ctx; then echo "W: ctx install failed!"; fi
  if ! kubectl krew install ns; then echo "W: ns install failed"; fi

  # Install helm
  echo "I: Installing helm.."
  if ! curl -s ${URL_HELM} | sudo bash; then echo "W: helm install failed!"; fi
}

install_fzf ()
{
  # Install fzf
  echo "I: Installing fzf.."
  if ! git clone --depth 1 ${URL_FZF} ~/.fzf; then echo "W: fialed clone fzf, exists?"; fi
  ~/.fzf/install --all
  git -C ${DIR_GIT_REPO} clone ${URL_BASH_FZF_TAB_COMP}
}

install_starship ()
{
  # Install and configure starship
  echo "I: Installing starship"
  ln -s ${DIR_GIT_REPO}/${FILE_STARSHIPTOML} ${HOME}/.config/starship.toml
  curl -s https://starship.rs/install.sh -o /tmp/install_starship.sh
  sh /tmp/install_starship.sh -y
  rm /tmp/install_starship.sh
}

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

main ()
{
  mkdir ~/git
  echo "I: Getting cloning/pulling repo.."
  git clone ${GIT_REPO} ${DIR_GIT_REPO} || git -C ${DIR_GIT_REPO} pull
  install_basics
  install_confs
  install_fzf
  install_starship
  install_nvim
  install_k8sbasics
}

main

. ~/.bashrc
