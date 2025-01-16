#!/bin/bash
REQ_DEB="autoconf automake pkg-config"
GIT_URL="https://github.com/tmux/tmux"
GIT_TAG="3.5a"
APP_NAME="${GIT_URL##*/}"
GIT_DIR="${HOME}/git"

if [[ ! -d "${GIT_DIR}" ]]
then
  mkdir -p "${GIT_DIR}"
fi

git clone --single-branch --branch "${GIT_TAG}" "${GIT_URL}" "${GIT_DIR}/${APP_NAME}-${GIT_TAG}"

sudo apt install -y ${REQ_DEB}

pushd .

cd "${GIT_DIR}/${APP_NAME}-${GIT_TAG}"
sh autogen.sh
./configure && make
sudo make install

popd

source ${BASE_NAME}/scripts/configure-tmux.sh
