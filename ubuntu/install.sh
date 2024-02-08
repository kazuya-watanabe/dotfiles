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

  pip3 show "$1" 2>&1 | grep 'not found' && pip3 install "$1"

  return 0
}

sudo apt-get update
sudo apt-get upgrade -y

# console utils
apt_install bat
apt_install coreutils
apt_install fd-find
apt_install fzf
apt_install language-pack-ja
apt_install less
apt_install tldr
apt_install tmux
apt_install zoxide
apt_install zsh

# compression/archiving
apt_install bzip2
apt_install gzip
apt_install p7zip-full
apt_install tar
apt_install unzip
apt_install xz-utils
apt_install zip

# network
apt_install curl
apt_install httpie
apt_install w3m
apt_install wget

# text utils
apt_install colordiff
apt_install gawk
apt_install jq
apt_install odt2txt
apt_install pandoc
apt_install pandoc-data
apt_install poppler-data
apt_install poppler-utils
apt_install ripgrep
apt_install sed
apt_install translate-shell
apt_install universal-ctags
apt_install vim

# program languages
apt_install golang
apt_install nodejs
apt_install perl
apt_install php
apt_install python3
apt_install python3-pip

# development tools
apt_install cargo
apt_install cmake
apt_install composer
apt_install git
apt_install git-flow
#apt_install mysql-server
apt_install npm
#apt_install postgresql
#apt_install redis-server
apt_install sqlite3
apt_install tig

# media
apt_install ffmpeg
apt_install imagemagick

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
cargo_install sheldon
cargo_install starship

# npm
npm_install corepack
npm_install n

export PATH="$HOME/.npm/bin:$PATH"
export N_PREFIX="$HOME/.npm"
n install lts

sudo apt autoremove -y nodejs npm

# python modules
pip_install pip3-autoremove
pip_install pip_search

# tmux
if [ ! -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
  git clone https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"

  "$HOME/.tmux/plugins/tpm/bin/install_plugins"
fi
