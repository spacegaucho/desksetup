#!/bin/env bash
mkdir -p ~/.config/mise
ln -s  ~/git/desksetup/files/confs/mise/config.toml ~/.config/mise/config.toml
curl https://mise.run | sh
