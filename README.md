# Basic setup
This is a basic desktop setup

# Distro specific software
## Arch
- python

## Ubuntu
- software-properties-common
- lsb-release
- python3
- python3-pip
- python3-virtualenv
- python3-venv
- libfuse2
- docker-ce
- docker-composec

# Common installs
Commonly required software
## Installed with package manager
- git
- curl
- wget
- gnupg
- openssl
- bash-completion
- ca-certificates
- gnupg
- man
- docker
- docker-compose

## Installed via script/shell
- `curl https://mise.run | sh`

## Installed with mise
- bat
- cmake
- cookiecutter
- cosign
- crictl
- fd
- flux2
- fzf
- go
- helm
- k3d
- k9s
- kind
- kompose
- krew
- kubectl
- kustomize
- neovim
- neovim@v0.11.2 (wait until v0.11.5 to upgrade since there's a lot of broken stuff)
- node
- pipx
- python
- rg
- ripgrep
- rust
- slsa
- starship
- usage
- yq
- zig

# Github
`curl -L https://api.github.com/repos/${NAMESPACE}/${REPO}/releases/latest`
## Regular git installer
- https://github.com/alacritty/alacritty
- `curl -LO "$(curl -Ls https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | jq -r '.assets.[] | select(.name |  test(".*AppImage")) | select(.name | test(".*arm.*") | not) | .browser_download_url')" && chmod 755 Obsiadian-* && sudo install Obsiadian-* /usr/bin/obsidian `
## Manual installation
- https://obsidian.md/download
