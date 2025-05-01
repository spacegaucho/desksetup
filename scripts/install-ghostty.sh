#!/bin/bash
DEFAULT_INSTALL_DIR="$HOME/.local/bin"
REQ_DEB="libgtk-4-dev libadwaita-1-dev git blueprint-compiler gettext libxml2-utils"
GIT_URL="https://github.com/ghostty-org/ghostty"
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

cd ghostty
zig build -Doptimize=ReleaseFast
install zig-out/bin/ghostty "${DEFAULT_INSTALL_DIR}"

popd

# source ${BASE_NAME}/scripts/configure-ghostty.sh
