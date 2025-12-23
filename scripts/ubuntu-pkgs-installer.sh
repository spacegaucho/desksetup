#!/bin/bash
DEBIAN_FRONTEND=noninteractive

sudo apt update
sudo apt install -y "$@"
