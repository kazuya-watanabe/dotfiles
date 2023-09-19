#!/usr/bin/env bash

set -eu

function dnf_install() {
  if ! rpm -q "$1"; then
    sudo dnf install -y "$1"
  fi

  return 0
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

sudo dnf upgrade -y

# console utils
dnf_install coreutils
dnf_install fzf
dnf_install langpacks-ja
dnf_install tmux
dnf_install util-linux-user
dnf_install zsh

# text utils
dnf_install ctags
dnf_install jq
dnf_install translate-shell
dnf_install vim-enhanced

# program languages
dnf_install nodejs
dnf_install python3
dnf_install python3-devel

# development tools
dnf_install cargo
dnf_install cmake
dnf_install git
dnf_install tig

# development libraries
dnf_install openssl-devel

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

sudo dnf autoremove -y nodejs

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
