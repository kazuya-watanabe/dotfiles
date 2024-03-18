#!/usr/bin/env bash

set -eu

function brew_tap() {
  echo "tapping $1"

  brew tap-info "$1" | grep 'Not installed' && brew tap "$1"

  return 0
}

function cargo_install() {
  cargo install "$1"

  return 0
}

function brew_install() {
  echo "installing $2"

  brew info "$1" "$2" | grep 'Not installed' && brew install "$1" "$2"

  return 0
}

function pip_install() {
  echo "installing $1"

  $HOME/.local/bin/pip show "$1" 2>&1 | grep 'not found' && $HOME/.local/bin/pip install "$1"

  return 0
}

if ! type brew; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  chmod go-w /usr/local/etc
fi

brew_tap homebrew/cask-fonts

# gui apps
brew_install --cask 1password
brew_install --cask adguard
brew_install --cask adguard-vpn
brew_install --cask altserver
brew_install --cask appcleaner
brew_install --cask iterm2
brew_install --cask microsoft-edge
brew_install --cask microsoft-office
brew_install --cask alfred

# fonts
brew_install --cask font-hack-nerd-font

# console utils
brew_install --formula coreutils
brew_install --formula fzf
brew_install --formula tmux

# text utils
brew_install --formula jq
brew_install --formula macvim
brew_install --formula translate-shell
brew_install --formula universal-ctags

# program languages
brew_install --formula node
brew_install --formula python
brew_install --formula rust

# development tools
brew_install --formula cmake
brew_install --formula git
brew_install --formula git-flow
brew_install --formula tig

# dotfiles
concdir="$HOME/Documents/Conceal"

if [ ! -d "$concdir" ]; then
  git clone --recursive https://github.com/kazuya-watanabe/dotfiles.conceal.git "$concdir"
  pushd "$concdir"
  git remote set-url origin git@github.com:kazuya-watanabe/dotfiles.conceal.git
  chmod +x ./install-dotfiles.sh
  ./install-dotfiles.sh
  popd
fi

dotdir="$HOME/Documents/Dotfiles"

if [ ! -d "$dotdir" ]; then
  git clone --recursive git@github.com:kazuya-watanabe/dotfiles.git "$dotdir"
  pushd "$dotdir"
  chmod +x ./install-dotfiles.sh
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

brew uninstall node

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
