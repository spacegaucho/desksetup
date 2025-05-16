#!/bin/bash
REQ_DEB="pynvim"
GIT_URL="https://github.com/neovim/neovim"
APP_NAME="${GIT_URL##*/}"
GIT_DIR="${HOME}/git"

# REQ_DEB=""
if [[ -z ${BASE_NAME} ]]
then
  BASE_NAME="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
else
  BASE_NAME="${BASE_NAME}/scripts"
fi

GIT_TAG="$(source ${BASE_NAME}/get_latest_tag.sh ${GIT_URL})"

if [[ ! -d "${GIT_DIR}" ]]
then
  mkdir -p "${GIT_DIR}"
fi

git clone --single-branch --branch "${GIT_TAG}" "${GIT_URL}" "${GIT_DIR}/${APP_NAME}-${GIT_TAG}"

sudo apt install -y ${REQ_DEB}
pip3 install --upgrade 

pushd .

cd "${GIT_DIR}/${APP_NAME}-${GIT_TAG}"
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

popd

source ${BASE_NAME}/scripts/configure-nvim.sh
