#!/bin/bash 
# DESCRIPTION: Install/setup minimum customization for bash.

# export the desired value before installing
COMMAND_OUT=/tmp/desksetup.out

main() { 
  echo "I: starting installation.."
  set -x
  # Install basics + awscli and terraform
  DEBIAN_FRONTEND=noninteractive
  sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
  sudo apt-get clean
  sudo apt-get update -y
  sudo apt-get install -y software-properties-common git curl wget gnupg openssl vim neovim bash-completion python3 python3-pip python3-virtualenv golang ca-certificates gnupg lsb-release tmux man
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg  | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  sudo apt-get install -y awscli terraform
  
  # Personal hack
  mkdir ${HOME}/.aws
  touch ${HOME}/.aws/credentials
  
  # Install kubectl
  curl -Lso kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo chmod 755 kubectl 
  if ! sudo install kubectl /usr/local/bin/; then echo "W: kubectl install failed! Ignore if already installed"; fi

  # Install krew
  if ! curl -s https://gist.githubusercontent.com/spacegaucho/440872661ef5159ce5e70837bd1db335/raw | bash ; then echo "W: krew install failed!"; fi
  if ! kubectl krew install ctx; then echo "W: ctx install failed!"; fi
  if ! kubectl krew install ns; then echo "W: ns install failed"; fi

  # Install helm
  if ! curl -s https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sudo bash; then echo "W: helm install failed!"; fi

  # Install docker-ce
  if ! sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y; then echo "W: docker install fialed!"; fi

  # Change docker BIP
  sudo cat <<EOF | sudo tee -a /etc/docker/daemon.json
{
  "bip": "192.168.255.1/24"
}
EOF
  sudo systemctl restart docker

  # Install skaffold
  if ! curl -Lso skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
  sudo install skaffold /usr/local/bin/; then echo "W: skaffold install failed!"; fi

  # Install kind
  curl -Lso ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
  chmod +x ./kind
  if ! sudo install kind /usr/local/bin; then echo "W: kind install failed"; fi
  
  # Install k3d
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | sudo bash

  # Install fzf
  if ! git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; then echo "W: fialed clone fzf, exists?"; fi
  ~/.fzf/install --all

  # Install and configure starship
	mkdir ~/.config || true
	curl -s https://gist.githubusercontent.com/spacegaucho/b3a0be246d2af3a7bde323a587408f12/raw > ~/.config/starship.toml
	curl -s https://starship.rs/install.sh -o install_starship.sh
	sh install_starship.sh -y
	rm install_starship.sh

  # Vim stuff
  if ! mkdir -p ${HOME}/.vim/autoload ${HOME}/.vim/bundle; then echo "W: failed mkdir for patogen, exists?"; fi
	curl -LSso ${HOME}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  curl -LSso ${HOME}/.vimrc https://gist.github.com/spacegaucho/2fef5c3f386086c2ff937fc85c92f21d/raw
  if ! mkdir -p ${HOME}/.vim/bundle/lightline.vim ; then echo "W: fialed mkdir lightline.vim, exists?"; fi
	if ! git clone https://github.com/itchyny/lightline.vim ${HOME}/.vim/bundle/lightline.vim; then echo "W: failed clone ligthline.vim, exists?"; fi

  # Upd .bashrc
  cp ~/.bashrc{,.bk}
  cp ~/.bash_aliases{,.bk}
  curl -s https://gist.githubusercontent.com/spacegaucho/b062a2f20ad7d67fce7a9156aa23f7f0/raw > ~/.bashrc
  curl -s https://gist.githubusercontent.com/spacegaucho/25c8b3f505484e16e1fc11d34075a297/raw > ~/.bash_aliases
  
  # Add tmux configs and cp neovim configs
  set +x
}

if main &>> $COMMAND_OUT
then 
  echo "OK: setupp succesful"
else
  echo "ERR: Presse any key to see details"
  less $COMMAND_OUT
fi
 
