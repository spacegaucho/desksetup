#!/bin/bash 
# DESCRIPTION: Install/setup minimum customization for bash.

# Files
FILE_BASHALIASES="files/bash_aliases"
FILE_BASHRC="files/bashrc"
FILE_KREWINSTALL="files/krewcurlinstall.sh"
FILE_STARSHIPTOML="files/starship.toml"
FILE_VIMRC="files/vimrc"
FILE_DOCKERD="/etc/docker/daemon.json"

# Urls
URL_SKAFFOLD="https://gist.githubusercontent.com/spacegaucho/b3a0be246d2af3a7bde323a587408f12/raw"
URL_INSTALLK3D="https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh"
URL_FZF="https://github.com/junegunn/fzf.git"
URL_HELM="https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"
URL_KIND="https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64"
URL_GITHUB_REPO="https://github.com/spacegaucho/desksetup"
URL_LIGHLINE="https://github.com/itchyny/lightline.vim"

# Other
APT_BASICS="git curl wget gnupg openssl vim neovim bash-completion python3 python3-pip python3-virtualenv golang ca-certificates gnupg lsb-release tmux man"
DIR_GIT_REPO="${HOME}/git/desksetup"
DOCKER_BIP="192.168.255.1/24"
COMMAND_OUT="/tmp/desksetup.log"

main() { 
  echo "I: starting installation.."
  set -x
  # Install basics + awscli and terraform
  DEBIAN_FRONTEND=noninteractive
  sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
  sudo apt-get clean
  sudo apt-get update -y
  sudo apt-get install -y software-properties-common ${APT_BASICS}
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg  | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  sudo apt-get install -y awscli terraform
  
  # Create directories for awscli to work
  mkdir ${HOME}/.aws
  touch ${HOME}/.aws/credentials
  
  # Create directories for git
  mkdir ${HOME}/git
  git clone ${URL_GITHUB_REPO} ${DIR_GIT_REPO}

  # Install kubectl
  curl -Lso kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo chmod 755 kubectl 
  if ! sudo install kubectl /usr/local/bin/; then echo "W: kubectl install failed! Ignore if already installed"; fi

  # Install krew
  if ! bash ${DIR_GIT_REPO}/${FILE_KREWINSTALL} ; then echo "W: krew install failed!"; fi
  if ! kubectl krew install ctx; then echo "W: ctx install failed!"; fi
  if ! kubectl krew install ns; then echo "W: ns install failed"; fi

  # Install helm
  if ! curl -s ${URL_HELM} | sudo bash; then echo "W: helm install failed!"; fi

  # Install docker-ce
  if ! sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y; then echo "W: docker install fialed!"; fi

  # Change docker BIP
  if ! grep "${DOCKER_BIP}" ${FILE_DOCKERD}; then
  sudo cat <<EOF | sudo tee -a 
{
  "bip": ${DOCKER_BIP}"
}
EOF
  sudo systemctl restart docker
  fi

  # Install skaffold
  if ! curl -Lso skaffold ${URL_SKAFFOLD} && \
  sudo install skaffold /usr/local/bin/; then echo "W: skaffold install failed!"; fi

  # Install kind
  curl -Lso ./kind ${URL_KIND}
  chmod +x ./kind
  if ! sudo install kind /usr/local/bin; then echo "W: kind install failed"; fi
  
  # Install k3d
  curl -s ${URL_INSTALLK3D} | sudo bash

  # Install fzf
  if ! git clone --depth 1 ${URL_FZF} ~/.fzf; then echo "W: fialed clone fzf, exists?"; fi
  ~/.fzf/install --all

  # Install and configure starship
	mkdir ~/.config || true
	cp ${FILE_STARSHIPTOML} ${HOME}/.config/starship.toml
	curl -s https://starship.rs/install.sh -o install_starship.sh
	sh install_starship.sh -y
	rm install_starship.sh

  # Vim stuff
  if ! mkdir -p ${HOME}/.vim/autoload ${HOME}/.vim/bundle; then echo "W: failed mkdir for patogen, exists?"; fi
	curl -LSso ${HOME}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  cp ${DIR_GIT_REPO}/${FILE_VIMRC} ${HOME}/.vimrc
  if ! mkdir -p ${HOME}/.vim/bundle/lightline.vim ; then echo "W: fialed mkdir lightline.vim, exists?"; fi
	if ! git clone ${URL_LIGHLINE} ${HOME}/.vim/bundle/lightline.vim; then echo "W: failed clone ligthline.vim, exists?"; fi

  # Upd .bashrc
  cp ~/.bashrc{,.bk}
  cp ~/.bash_aliases{,.bk}
  cp ${FILE_BASHRC} ${HOME}/.bashrc
  cp ${FILE_BASHALIASES} ${HOME}/.bash_aliases
  
  # Add tmux configs and cp neovim configs
  set +x
}

if main &>> ${COMMAND_OUT}
then 
  echo "OK: setup succesful"
else
  echo "ERR: Presse any key to see details"
  less ${COMMAND_OUT}
fi
 
