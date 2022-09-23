#!/usr/bin/env bash

set -eu

function dnf_install() {
  if ! rpm -q "$1"; then
    sudo dnf install -y "$1"
  fi
}

function cargo_install() {
  cargo install "$1"
}

function npm_install() {
  mkdir -p "$HOME/.npm/lib"
  if ! npm -g list "$1"; then
    npm -g install "$1"
  fi
}

function pip_install() {
  venvsdir="$HOME/.venvs"
  mkdir -p "$venvsdir"

  venvdir="$venvsdir/$1"
  if [ ! -f "$venvdir/bin/pip3" ]; then
    python3 -m venv "$venvdir"
    "$venvdir/bin/pip3" install $1

    if [ -f "$venvdir/bin/$1" ]; then
      ln -fs "$venvdir/bin/$1" "$HOME/.local/bin/$1"
    fi
  fi
}

# console utils
dnf_install bat
dnf_install coreutils
dnf_install fd-find
dnf_install fzf
dnf_install less
dnf_install tmux
dnf_install vim-enhanced
dnf_install zoxide
dnf_install zsh

# compression/archivers
dnf_install bzip2
dnf_install gzip
dnf_install p7zip
dnf_install tar
dnf_install unzip
dnf_install xz
dnf_install zip

# network
dnf_install curl
dnf_install w3m
dnf_install wget

# text utils
dnf_install colordiff
dnf_install ctags
dnf_install gawk
dnf_install jq
dnf_install odt2txt
dnf_install pandoc
dnf_install poppler-utils
dnf_install ripgrep
dnf_install sed
dnf_install translate-shell

# program languages
dnf_install dotnet-sdk-7.0
dnf_install golang
dnf_install java-17-openjdk
dnf_install nodejs
dnf_install perl
dnf_install php
dnf_install python3
dnf_install python3-setuptools

# development tools
dnf_install cargo
dnf_install cmake
dnf_install git
dnf_install tig

# development libraries
dnf_install openssl-devel

# dotfiles
gitdir="$HOME/.conceal"
if [ ! -d "$gitdir" ]; then
  git clone --recursive https://github.com/kazuya-watanabe/dotfiles.conceal.git "$gitdir"
  pushd "$gitdir"
  git remote set-url origin git@github.com:kazuya-watanabe/dotfiles.conceal.git
  ./install-dotfiles.sh
  popd
fi

gitdir="$HOME/.dotfiles"
if [ ! -d "$gitdir" ]; then
  git clone --recursive git@github.com:kazuya-watanabe/dotfiles.git "$gitdir"
  pushd "$gitdir"
  ./install-dotfiles.sh
  popd
fi

# cargo
cargo_install sheldon
cargo_install starship

# npm
npm_install corepack

# python modules
pip_install pip_search
pip_install yt-dlp

# tmux
if [ ! -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
  git clone https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"

  "$HOME/.tmux/plugins/tpm/bin/install_plugins"
fi
