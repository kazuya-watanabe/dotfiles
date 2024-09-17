#!/usr/bin/env bash

set -e
set -u
set -o pipefail

function _ln() {
  SOURCE="${1}"
  DEST="${2}"

  if [ -L "${DEST}" ]; then
    rm -f "${DEST}"
  elif [ -e "${DEST}" ]; then
    mv -f "${DEST}" "${DEST}~"
  fi

  mkdir -p "$(dirname ${DEST})"

  ln -s "${SOURCE}" "${DEST}"
}

function install_dotfiles() {
  gh auth login

  GITDIR="${HOME}/.conceal"

  if [ ! -d "${GITDIR}" ]; then
    gh repo clone dotfiles.conceal "${GITDIR}" -- --recursive
    pushd "${GITDIR}" >/dev/null 2>&1
    gh auth setup-git
    popd >/dev/null 2>&1
  fi

  chmod -R go-rwx "${GITDIR}/.ssh"

  _ln "${GITDIR}/.config/openai.token"   "${HOME}/.config/openai.token"
  _ln "${GITDIR}/.config/textlint"       "${HOME}/.config/textlint"
  _ln "${GITDIR}/.ssh/aws"               "${HOME}/.ssh/aws"
  _ln "${GITDIR}/.ssh/azure"             "${HOME}/.ssh/azure"
  _ln "${GITDIR}/.ssh/backlog"           "${HOME}/.ssh/backlog"
  _ln "${GITDIR}/.ssh/config"            "${HOME}/.ssh/config"
  _ln "${GITDIR}/.w3m/bookmark.html"     "${HOME}/.w3m/bookmark.html"
  _ln "${GITDIR}/intelephense"           "${HOME}/intelephense"

  GITDIR="${HOME}/.dotfiles"

  if [ ! -d "${GITDIR}" ]; then
    gh repo clone dotfiles "${GITDIR}" -- --recursive
    pushd "${GITDIR}" >/dev/null 2>&1
    gh auth setup-git
    popd >/dev/null 2>&1
  fi

  _ln "${GITDIR}/.aliases"               "${HOME}/.aliases"
  _ln "${GITDIR}/.config/bat"            "${HOME}/.config/bat"
  _ln "${GITDIR}/.config/fd"             "${HOME}/.config/fd"
  _ln "${GITDIR}/.config/git"            "${HOME}/.config/git"
  _ln "${GITDIR}/.config/git/config.mac" "${HOME}/.config/git/config"
  _ln "${GITDIR}/.config/lf"             "${HOME}/.config/lf"
  _ln "${GITDIR}/.config/pip"            "${HOME}/.config/pip"
  _ln "${GITDIR}/.config/rg"             "${HOME}/.config/rg"
  _ln "${GITDIR}/.config/sheldon"        "${HOME}/.config/sheldon"
  _ln "${GITDIR}/.config/starship.toml"  "${HOME}/.config/starship.toml"
  _ln "${GITDIR}/.config/tig"            "${HOME}/.config/tig"
  _ln "${GITDIR}/.curlrc"                "${HOME}/.curlrc"
  _ln "${GITDIR}/.inputrc"               "${HOME}/.inputrc"
  _ln "${GITDIR}/.npm-rc"                "${HOME}/.npmrc"
  _ln "${GITDIR}/.profile"               "${HOME}/.profile"
  _ln "${GITDIR}/.ripgreprc"             "${HOME}/.ripgreprc"
  _ln "${GITDIR}/.textlintrc"            "${HOME}/.textlintrc"
  _ln "${GITDIR}/.tmux.conf"             "${HOME}/.tmux.conf"
  _ln "${GITDIR}/.vim"                   "${HOME}/.vim"
  _ln "${GITDIR}/.w3m/config"            "${HOME}/.w3m/config"
  _ln "${GITDIR}/.w3m/keymap"            "${HOME}/.w3m/keymap"
  _ln "${GITDIR}/.wgetrc"                "${HOME}/.wgetrc"
  _ln "${GITDIR}/.zsh"                   "${HOME}/.zsh"
  _ln "${GITDIR}/.zshenv"                "${HOME}/.zshenv"
}

function install_cask_package() {
  if ! brew list --cask "${1}" >/dev/null 2>&1; then
    brew install --cask "${1}"
  fi
}

function install_brew_package() {
  if ! brew list --formula "${1}" >/dev/null 2>&1; then
    brew install --formula "${1}"
  fi
}

function install_cargo_package() {
  if ! cargo install --list | grep -q "${1}"; then
    cargo install "${1}"
  fi
}

function install_apt_package() {
  if ! dpkg -l "${1}" >/dev/null 2>&1; then
    sudo apt-get install --yes "${1}"
  fi
}

function install_npm_package() {
  if ! npm --global list "${1}" >/dev/null 2>&1; then
    npm --global install "${1}"
  fi
}

function cleanup_packages() {
  if [ $(uname -s) = 'Darwin' ]; then
    if brew list --formula node >/dev/null 2>&1; then
      brew uninstall --formula node
      brew autoremove
    fi
  elif [ $(uname -s) = 'Linux' ]; then
    if type apt-get >/dev/null 2>&1; then
      sudo apt-get purge --yes nodejs
      sudo apt-get purge --yes python3-venv
      sudo apt-get purge --yes python3-pip
      sudo apt-get purge --yes vim-tiny
      sudo apt-get autoremove --yes
    fi
  fi
}

function install_pip_package() {
  if ! pip show "${1}"; then
    pip install "${1}"
  fi
}

export PATH="${HOME}/.cargo/bin":"${HOME}/.npm/bin":"${HOME}/.local/bin":"${HOME}/.local/sbin":"${HOME}/bin":"${HOME}/sbin":"/opt/homebrew/bin":"/opt/homebrew/sbin":${PATH}

if [ $(uname -s) = 'Darwin' ]; then
  if ! type brew >/dev/null 2>&1; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    test -d /opt/homebrew/etc && chmod go-w /opt/homebrew/etc
  fi

  install_brew_package gh

  install_dotfiles

  install_cask_package 1password
  install_cask_package adguard
  install_cask_package adguard-vpn
  install_cask_package alfred
  install_cask_package altserver
  install_cask_package apidog
  install_cask_package appcleaner
  install_cask_package iterm2
  install_cask_package macvim
  install_cask_package microsoft-edge
  install_cask_package microsoft-office
  install_cask_package sequel-ace
  install_cask_package visual-studio-code

  install_brew_package cmake
  install_brew_package composer
  install_brew_package coreutils
  install_brew_package docker
  install_brew_package docker-completion
  install_brew_package fzf
  install_brew_package gawk
  install_brew_package git-flow
  install_brew_package go
  install_brew_package jq
  install_brew_package lf
  install_brew_package mysql
  install_brew_package node
  install_brew_package p7zip
  install_brew_package pandoc
  install_brew_package poppler
  install_brew_package tig
  install_brew_package tmux
  install_brew_package translate-shell
  install_brew_package universal-ctags
  install_brew_package w3m
  install_brew_package wget
  install_brew_package xz
elif [ $(uname -s) = 'Linux' ]; then
  if type apt-get >/dev/null 2>&1; then
    sudo apt-get update --yes

    install_apt_package gh

    install_dotfiles

    install_apt_package bzip2
    install_apt_package cmake
    install_apt_package composer
    install_apt_package fzf
    install_apt_package gawk
    install_apt_package git-flow
    install_apt_package golang
    install_apt_package jq
    install_apt_package language-pack-ja-base
    install_apt_package mysql-client
    install_apt_package npm
    install_apt_package p7zip
    install_apt_package pandoc
    install_apt_package pandoc-data
    install_apt_package poppler-data
    install_apt_package poppler-utils
    install_apt_package python3-pip
    install_apt_package python3-venv
    install_apt_package sqlite3
    install_apt_package tig
    install_apt_package tmux
    install_apt_package translate-shell
    install_apt_package universal-ctags
    install_apt_package unzip
    install_apt_package w3m
    install_apt_package wget
    install_apt_package xz-utils
    install_apt_package zip
    install_apt_package zsh

    sudo add-apt-repository --yes ppa:jonathonf/vim
    install_apt_package vim
  else
    echo "Unsupported package manager"
    exit 1
  fi
fi

if ! type cargo >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

install_cargo_package bat
install_cargo_package cargo-update
install_cargo_package fd-find
install_cargo_package git-delta
install_cargo_package lsd
install_cargo_package ripgrep
install_cargo_package sheldon
install_cargo_package starship
install_cargo_package zoxide

export N_PREFIX="${HOME}/.npm"

mkdir -p "${HOME}/.npm/lib"

install_npm_package n
install_npm_package corepack

n install lts

if ! type pip >/dev/null 2>&1; then
  python3 -m venv ${HOME}/.local
fi

install_pip_package httpie
install_pip_package pip3-autoremove
install_pip_package pip_search

cleanup_packages

if [ ! -x "${HOME}/.tmux/plugins/tpm/bin/install_plugins" ]; then
  git clone https://github.com/tmux-plugins/tpm.git "${HOME}/.tmux/plugins/tpm"
fi

"${HOME}/.tmux/plugins/tpm/bin/install_plugins"
