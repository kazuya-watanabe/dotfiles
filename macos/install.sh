#!/usr/bin/env bash

set -eu

function cask_install() {
  if ! brew info --cask "$1" >/dev/null 2>&1; then
    brew install --cask "$1"
  fi

  return 0
}

function brew_install() {
  if ! brew info --formula "$1" >/dev/null 2>&1; then
    brew install --formula "$1"
  fi

  return 0
}

function cargo_install() {
  if ! $HOME/.cargo/bin/cargo install --list | grep -q "$1"; then
    $HOME/.cargo/bin/cargo install "$1"
  fi

  return 0
}

function npm_install() {
  if ! npm --global list "$1" >/dev/null 2>&1; then
    npm --global install "$1"
  fi

  return 0
}

function pip_install() {
  if ! $HOME/.local/bin/pip show "$1"; then
    $HOME/.local/bin/pip install "$1"
  fi

  return 0
}

export PATH=/opt/homebrew/bin:$PATH

if ! type brew; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  test -d /opt/homebrew/etc && chmod go-w /opt/homebrew/etc
fi

cask_install 1password
cask_install adguard
cask_install adguard-vpn
cask_install alfred
cask_install altserver
cask_install apidog
cask_install appcleaner
cask_install iterm2
cask_install macvim
cask_install microsoft-edge
cask_install microsoft-office
cask_install sequel-ace
cask_install visual-studio-code

brew_install coreutils
brew_install fzf
brew_install lf
brew_install tmux

brew_install p7zip
brew_install xz

brew_install gawk
brew_install jq
brew_install pandoc
brew_install poppler
brew_install translate-shell
brew_install universal-ctags

brew_install curl
brew_install w3m
brew_install wget

brew_install mysql
brew_install sqlite

brew_install node
brew_install php
brew_install composer
brew_install python

brew_install autoconf
brew_install automake
brew_install cmake
brew_install docker
brew_install docker-completion
brew_install gh
brew_install git
brew_install git-flow
brew_install tig
brew_install llvm

gh auth login

GIT_DIR="$HOME/Documents/Conceal"

if [ ! -d "$GIT_DIR" ]; then
  gh repo clone dotfiles.conceal "$GIT_DIR" --recursive
  pushd "$GIT_DIR"
  gh auth setup-git
  chmod +x ./install-dotfiles.sh
  ./install-dotfiles.sh
  popd
fi

GIT_DIR="$HOME/Documents/Dotfiles"

if [ ! -d "$GIT_DIR" ]; then
  gh repo clone dotfiles "$GIT_DIR" --recursive
  pushd "$GIT_DIR"
  chmod +x ./install-dotfiles.sh
  ./install-dotfiles.sh
  popd
fi

if [ ! -f "$HOME/.cargo/bin/cargo" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

cargo_install bat
cargo_install cargo-update
cargo_install fd-find
cargo_install git-delta
cargo_install lsd
cargo_install ripgrep
cargo_install sheldon
cargo_install starship
cargo_install zoxide

export PATH="$HOME/.npm/bin:$PATH"
export N_PREFIX="$HOME/.npm"

mkdir -p "$HOME/.npm/lib"

npm_install n
npm_install corepack

n install lts

brew uninstall --formula node
brew autoremove

if [ ! -x $HOME/.local/bin/pip ]; then
  python3 -m venv ~/.local
fi

pip_install httpie
pip_install pip3-autoremove
pip_install pip_search

if [ ! -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
  git clone https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"
fi

"$HOME/.tmux/plugins/tpm/bin/install_plugins"
