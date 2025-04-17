#!/bin/bash
DEFAULT_INSTALL_DIR="$HOME/.local/bin"
REQ_DEB="libxi-dev libxcb-cursor-dev libxinerama-dev libxrandr-dev"
GIT_URL="https://github.com/kovidgoyal/kitty"
if [[ -z ${BASE_NAME} ]]
then
  BASE_NAME="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
else
  BASE_NAME="${BASE_NAME}/scripts"
fi
GIT_TAG="$(source ${BASE_NAME}/get_latest_tag.sh ${GIT_URL})"
APP_NAME="${GIT_URL##*/}"
GIT_DIR="${HOME}/git"

if [[ ! -d "${GIT_DIR}" ]]
then
  mkdir -p "${GIT_DIR}"
fi

git clone --single-branch --branch "${GIT_TAG}" "${GIT_URL}" "${GIT_DIR}/${APP_NAME}-${GIT_TAG}"

sudo apt install -y ${REQ_DEB}

# Config goes here 
pushd .

cd "${GIT_DIR}/${APP_NAME}-${GIT_TAG}"

./dev.sh build
install kitty/launcher/kitty "${DEFAULT_INSTALL_DIR}"

popd

source ${BASE_NAME}/scripts/configure-kitty.sh
