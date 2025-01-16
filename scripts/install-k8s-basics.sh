#!/bin/bash
URL_HELM="https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"

install_krew ()
{
  # Install krew
  echo "I: Installing krew.."
  (
    cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
    if ! grep KREW_ROOT ${HOME}/.bashrc; then echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"'>> ${HOME}/.bashrc ; fi
  )
}

install_kustomize ()
{
  # Install kustomize
  echo "I: Installing kustomize.."
  curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash ~/.local/bin
}

install_kubectl ()
{
  # Install kubectl
  echo "I: Installing kubectl.."
  curl -Lso kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod 755 kubectl
  install kubectl ${HOME}/.local/bin/kubectl || echo "W: kubectl install failed! Ignore if already installed"
  rm kubectl
}

install_krew_plugins ()
{
  kubectl krew install ctx || echo "W: ctx failed to install"
  kubectl krew install ns || echo "W: ns install failed"
}

install_helm ()
{
  # Install helm
  # TODO install helm without sudo
  echo "I: Installing helm.."
  curl -s ${URL_HELM} | sudo bash || echo "W: helm install failed!"
}

install_kubectl
install_krew
install_krew_plugins
install_kustomize
install_helm
