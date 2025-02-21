#!/bin/bash

# REQ_DEB=""
if [[ -z ${BASE_NAME} ]]
then
  BASE_NAME="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
else
  BASE_NAME="${BASE_NAME}/scripts"
fi
GIT_URL="https://github.com/derailed/k9s"
GIT_TAG="$(source ${BASE_NAME}/get_latest_tag.sh ${GIT_URL})"
APP_NAME="${GIT_URL##*/}"
GIT_DIR="${HOME}/git"

if [[ ! -d "${GIT_DIR}" ]]
then
  mkdir -p "${GIT_DIR}"
fi

git clone --single-branch --branch "${GIT_TAG}" "${GIT_URL}" "${GIT_DIR}/${APP_NAME}-${GIT_TAG}"

# sudo apt install -y ${REQ_DEB}

pushd .

cd "${GIT_DIR}/${APP_NAME}-${GIT_TAG}"

make -j $(nproc) build && cp ./execs/k9s ~/.local/bin/k9s 

popd

# source ${BASE_NAME}/scripts/config-polybar.sh
