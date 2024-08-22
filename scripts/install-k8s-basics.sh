#!/bin/bash
URL_HELM="https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"

install_krew ()
{
  (
    set -x; cd "$(mktemp -d)" &&
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
  curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
}

install_k8sbasics ()
{
  # Install kubectl
  echo "I: Installing kubectl.."
  curl -Lso kubectl "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo chmod 755 kubectl
  sudo install kubectl /usr/local/bin/ || echo "W: kubectl install failed! Ignore if already installed"
  rm kubectl

  # Install krew
  echo "I: Installing krew.."

  install_krew
  install_kustomize

  kubectl krew install ctx || echo "W: ctx failed to install"
  kubectl krew install ns || echo "W: ns install failed"

  # Install helm
  echo "I: Installing helm.."
  curl -s ${URL_HELM} | sudo bash || echo "W: helm install failed!"
}


install_k8sbasics
