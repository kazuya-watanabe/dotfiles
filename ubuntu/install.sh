#!/usr/bin/env bash

set -eu

function apt_install() {
  if dpkg-quey -s $1 &> /dev/null; then
    echo "$1 is already installed"
  else
    sudo apt-get install -y $1
  fi
}

function cargo_install() {
  cargo install "$1"

  return 0
}

function npm_install() {
  mkdir -p "$HOME/.npm/lib"

  if ! npm -g list "$1"; then
    npm -g install "$1"
  fi

  return 0
}

function pip_install() {
  echo "installing $1"

  $HOME/.local/bin/pip show "$1" 2>&1 | grep 'not found' && $HOME/.local/bin/pip install "$1"

  return 0
}

echo "$(whoami) ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$(whoami)

sudo add-apt-repository -y ppa:jonathonf/vim
sudo add-apt-repository -y ppa:ondrej/php

sudo apt-get update
sudo apt-get upgrade -y

# console utils
apt_install coreutils
apt_install fzf
apt_install language-pack-ja
apt_install tmux
apt_install zsh

# text utils
apt_install jq
apt_install translate-shell
apt_install universal-ctags
apt_install vim-gtk3

# program languages
apt_install python3
apt_install python3-venv

# development tools
apt_install cargo
apt_install cmake
apt_install git
apt_install git-flow
apt_install npm
apt_install tig

sudo chsh -s /bin/zsh "$(whoami)"

# dotfiles
concdir="$HOME/.conceal"

if [ ! -d "$concdir" ]; then
  git clone --recursive https://github.com/kazuya-watanabe/dotfiles.conceal.git "$concdir"
  pushd "$concdir"
  git remote set-url origin git@github.com:kazuya-watanabe/dotfiles.conceal.git
  ./install-dotfiles.sh
  popd
fi

dotdir="$HOME/.dotfiles"

if [ ! -d "$dotdir" ]; then
  git clone --recursive git@github.com:kazuya-watanabe/dotfiles.git "$dotdir"
  pushd "$dotdir"
  ./install-dotfiles.sh
  popd
fi

# cargo
cargo_install bat
cargo_install fd-find
cargo_install git-delta
cargo_install lsd
cargo_install ripgrep
cargo_install sheldon
cargo_install starship
cargo_install zoxide

# npm
npm_install n

export PATH="$HOME/.npm/bin:$PATH"
export N_PREFIX="$HOME/.npm"
n install lts

sudo apt autoremove -y npm

npm_install corepack

# python modules
if [ ! -x $HOME/.local/bin/pip ]; then
  python3 -m venv ~/.local
fi

pip_install pip3-autoremove
pip_install pip_search
pip_install ranger-fm

# tmux
if [ ! -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
  git clone https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"

  "$HOME/.tmux/plugins/tpm/bin/install_plugins"
fi
