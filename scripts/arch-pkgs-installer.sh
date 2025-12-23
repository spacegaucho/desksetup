#!/bin/bash

sudo pacman -Syu
sudo pacman -Sy --confirm "$@"
