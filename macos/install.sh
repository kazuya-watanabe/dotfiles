#!/usr/bin/env bash

set -eu

function brew_tap() {
  echo "tapping $1"

  brew tap-info "$1" | grep 'Not installed' && brew tap "$1"

  return 0
}

function brew_install() {
  echo "installing $2"

  brew info "$1" "$2" | grep 'Not installed' && brew install "$1" "$2"

  return 0
}

function pip_install() {
  echo "installing $1"

  pip3 show "$1" 2>&1 | grep 'not found' && pip3 install "$1"

  return 0
}

if ! type brew; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew_tap homebrew/cask
brew_tap homebrew/cask-fonts
brew_tap microsoft/git

# gui apps
brew_install --cask 1password
brew_install --cask adguard
brew_install --cask adguard-vpn
brew_install --cask altserver
brew_install --cask appcleaner
brew_install --cask cloudmounter
brew_install --cask iterm2
brew_install --cask karabiner-elements
brew_install --cask macvim
brew_install --cask microsoft-edge
brew_install --cask microsoft-office
brew_install --cask scroll-reverser
brew_install --cask ueli

# fonts
brew_install --cask font-hack-nerd-font

# console utils
brew_install --formula bat
brew_install --formula coreutils
brew_install --formula fd
brew_install --formula fzf
brew_install --formula less
brew_install --formula lesspipe
brew_install --formula lsd
brew_install --formula navi
brew_install --formula sheldon
brew_install --formula starship
brew_install --formula tldr
brew_install --formula tmux
brew_install --formula wkhtmltopdf
brew_install --formula zoxide

# compression/archivers
brew_install --formula bzip2
brew_install --formula gnu-tar
brew_install --formula gzip
brew_install --formula p7zip
brew_install --formula unzip
brew_install --formula xz
brew_install --formula zip

# network
brew_install --formula curl
brew_install --formula httpie
brew_install --formula w3m
brew_install --formula wget

# text utils
brew_install --formula colordiff
brew_install --formula gawk
brew_install --formula git-delta
brew_install --formula gnu-sed
brew_install --formula jq
brew_install --formula odt2txt
brew_install --formula pandoc
brew_install --formula poppler
brew_install --formula ripgrep
brew_install --formula translate-shell
brew_install --formula universal-ctags

# program languages
brew_install --cask dotnet-sdk
brew_install --formula go
brew_install --formula node
brew_install --formula openjdk
brew_install --formula perl
brew_install --formula php
brew_install --formula python@3.11

# development tools
brew_install --formula cmake
brew_install --formula composer
brew_install --formula corepack
brew_install --formula git
brew_install --formula mysql
brew_install --formula postgresql@15
brew_install --formula redis
brew_install --formula sqlite
brew_install --formula tig

# media
brew_install --formula ffmpeg
brew_install --formula imagemagick

# dotfiles
gitdir="$HOME/Documents/Conceal"

if [ ! -d "$gitdir" ]; then
  git clone --recursive https://github.com/kazuya-watanabe/dotfiles.conceal.git "$gitdir"
  pushd "$gitdir"
  git remote set-url origin git@github.com:kazuya-watanabe/dotfiles.conceal.git
  ./install-dotfiles.sh
  popd
fi

gitdir="$HOME/Documents/Dotfiles"

if [ ! -d "$gitdir" ]; then
  git clone --recursive git@github.com:kazuya-watanabe/dotfiles.git "$gitdir"
  pushd "$gitdir"
  ./install-dotfiles.sh
  popd
fi

# python modules
pip_install pip3-autoremove
pip_install pip_search

# tmux
if [ ! -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
  git clone https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"

  "$HOME/.tmux/plugins/tpm/bin/install_plugins"
fi
