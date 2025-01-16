#!/bin/bash
GIT_URL="https://github.com/yshui/picom"
APP_NAME="${GIT_URL##*/}"
GIT_TAG="v12.5"
REQ_DEB="libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev cmake"
GIT_DIR="${HOME}/git"
INSTALL_PATH="${HOME}/.local/bin/"

if [[ ! -d "${GIT_DIR}" ]]
then
  mkdir -p "${GIT_DIR}"
fi

git clone --single-branch --branch "${GIT_TAG}" "${GIT_URL}" "${GIT_DIR}/${APP_NAME}-${GIT_TAG}"

sudo apt update && sudo apt install -y ${REQ_DEB}

pushd .

cd "${GIT_DIR}/${APP_NAME}-${GIT_TAG}"
meson setup --buildtype=release build
ninja -C build
meson configure -Dprefix="${INSTALL_PATH}" build
sudo ninja -C build install

popd

source ${BASE_NAME}/scripts/configure-picom.sh
