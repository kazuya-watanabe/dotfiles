#!/usr/bin/env bash

set -eu

dotfiles=$(cat <<END
  .config/bat
  .config/git
  .config/pip
  .config/sheldon
  .config/starship.toml
  .config/tig
  .vim
  .w3m/config
  .w3m/keymap
  .zsh
  .aliases.sh
  .bash_profile
  .bashrc
  .curlrc
  .inputrc
  .npmrc
  .profile
  .tmux.conf
  .wgetrc
  .zshenv
END
)

function install_dotfile() {
  src="$1"
  dst="$2"

  if [ -L "$dst" ]; then
    rm -f "$dst"
  elif [ -e "$dst" ]; then
    mv -f "$dst" "$dst~"
  fi

  mkdir -p "$(dirname $dst)"

  ln -sv "$src" "$dst"
}

function install_dotfiles() {
  pushd "$1" >/dev/null 2>&1

  for i in $dotfiles; do
    install_dotfile "$(pwd)/$i" "$HOME/$i"
  done

  popd >/dev/null 2>&1
}

mkdir -p ~/.local/bin ~/.local/lib ~/.local/share ~/.local/state ~/.local/tmp

install_dotfiles "$(dirname $0)"
