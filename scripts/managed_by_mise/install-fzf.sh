#!/bin/bash
GIT_URL="https://github.com/junegunn/fzf"

echo "I: Installing fzf.."
git clone --depth 1 ${GIT_URL} ~/.fzf || git pull ~/.fzf && ~/.fzf/install --all
