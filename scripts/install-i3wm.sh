#!/bin/bash
# https://github.com/Airblader/i3/wiki/Building-from-source
# https://github.com/i3/i3/tree/4.24?tab=readme-ov-file
# More references: https://faq.i3wm.org/question/68/how-to-build-and-install-i3-from-sources.1.html
# TAG=4.24
# use ./install-picom.sh as reference
#
URL_GITLAB_CASA_LAN_NVIM="ssh://gitlab.casa.lan:2222/mystuff/i3config"
REQ_DEB="libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev"
GIT_URL="https://github.com/i3/i3"
GIT_TAG="4.24"
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
meson build
cd build/
udo ninja install

popd

git clone ${URL_GITLAB_CASA_LAN_NVIM} ~/.i3 --depth 1 || git -C ~/.i3 pull
