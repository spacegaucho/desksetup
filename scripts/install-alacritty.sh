#!/bin/bash
REQ_DEB="cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3"
GIT_URL="https://github.com/alacritty/alacritty"
GIT_TAG="v0.15.0"
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
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup override set stable
rustup update stable
cargo build --release
infocmp alacritty
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

popd

source ${BASE_NAME}/scripts/configure-alacritty.sh
