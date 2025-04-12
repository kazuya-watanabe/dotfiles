#!/usr/bin/env bash

set -euo pipefail

export PATH="${HOME}/.local/bin":"${HOME}/.local/sbin":"${HOME}/bin":"${HOME}/sbin":"/opt/homebrew/bin":"/opt/homebrew/sbin":${PATH}

if ! type brew >/dev/null 2>&1; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  test -d /opt/homebrew/etc && chmod go-w /opt/homebrew/etc
fi

brew install --formula git
brew install --formula gh

GITDIR="${HOME}/.dotfiles"

if [ ! -d "${GITDIR}" ]; then
  gh auth login
  gh repo clone dotfiles "${GITDIR}" -- --recursive
fi

mkdir -pv "${HOME}/.config"

test ! -e "${HOME}/.aliases" && ln -fsv "${GITDIR}/.aliases" "${HOME}/.aliases"
test ! -e "${HOME}/.config/bat" && ln -fsv "${GITDIR}/.config/bat" "${HOME}/.config/bat"
test ! -e "${HOME}/.config/fd" && ln -fsv "${GITDIR}/.config/fd" "${HOME}/.config/fd"
test ! -e "${HOME}/.config/git" && ln -fsv "${GITDIR}/.config/git" "${HOME}/.config/git"
test ! -e "${HOME}/.config/lf" && ln -fsv "${GITDIR}/.config/lf" "${HOME}/.config/lf"
test ! -e "${HOME}/.config/pip" && ln -fsv "${GITDIR}/.config/pip" "${HOME}/.config/pip"
test ! -e "${HOME}/.config/rg" && ln -fsv "${GITDIR}/.config/rg" "${HOME}/.config/rg"
test ! -e "${HOME}/.config/sheldon" && ln -fsv "${GITDIR}/.config/sheldon" "${HOME}/.config/sheldon"
test ! -e "${HOME}/.config/starship.toml" && ln -fsv "${GITDIR}/.config/starship.toml" "${HOME}/.config/starship.toml"
test ! -e "${HOME}/.config/tig" && ln -fsv "${GITDIR}/.config/tig" "${HOME}/.config/tig"
test ! -e "${HOME}/.config/vim" && ln -fsv "${GITDIR}/.config/vim" "${HOME}/.config/vim"
test ! -e "${HOME}/.curlrc" && ln -fsv "${GITDIR}/.curlrc" "${HOME}/.curlrc"
test ! -e "${HOME}/.inputrc" && ln -fsv "${GITDIR}/.inputrc" "${HOME}/.inputrc"
test ! -e "${HOME}/.profile" && ln -fsv "${GITDIR}/.profile" "${HOME}/.profile"
test ! -e "${HOME}/.textlintrc" && ln -fsv "${GITDIR}/.textlintrc" "${HOME}/.textlintrc"
test ! -e "${HOME}/.tmux.conf" && ln -fsv "${GITDIR}/.tmux.conf" "${HOME}/.tmux.conf"
test ! -e "${HOME}/.w3m" && ln -fsv "${GITDIR}/.w3m" "${HOME}/.w3m"
test ! -e "${HOME}/.wgetrc" && ln -fsv "${GITDIR}/.wgetrc" "${HOME}/.wgetrc"
test ! -e "${HOME}/.zsh" && ln -fsv "${GITDIR}/.zsh" "${HOME}/.zsh"
test ! -e "${HOME}/.zshenv" && ln -fsv "${GITDIR}/.zshenv" "${HOME}/.zshenv"

GITDIR="${HOME}/.conceal"

if [ ! -d "${GITDIR}" ]; then
  gh repo clone dotfiles.conceal "${GITDIR}" -- --recursive
  chmod -Rv go-rwx "${GITDIR}/.ssh"
fi

test ! -e "${HOME}/.config/openai.token" && ln -fsv "${GITDIR}/.config/openai.token" "${HOME}/.config/openai.token"
test ! -e "${HOME}/.config/textlint" && ln -fsv "${GITDIR}/.config/textlint" "${HOME}/.config/textlint"
test ! -e "${HOME}/.ssh" && ln -fsv "${GITDIR}/.ssh" "${HOME}/.ssh"
test ! -e "${HOME}/.w3m/bookmark.html" && ln -fsv "${GITDIR}/.w3m/bookmark.html" "${HOME}/.w3m/bookmark.html"
test ! -e "${HOME}/intelephense" && ln -fsv "${GITDIR}/intelephense" "${HOME}/intelephense"

brew install --cask adguard
brew install --cask adguard-vpn
brew install --cask alfred
brew install --cask apidog
brew install --cask appcleaner
brew install --cask iterm2
brew install --cask karabiner-elements
brew install --cask logitech-g-hub
brew install --cask macvim
brew install --cask microsoft-edge
brew install --cask microsoft-office
brew install --cask sequel-ace

brew install --formula bat
brew install --formula cmake
brew install --formula coreutils
brew install --formula docker
brew install --formula docker-completion
brew install --formula fd
brew install --formula ffmpeg
brew install --formula fnm
brew install --formula fzf
brew install --formula gawk
brew install --formula git-delta
brew install --formula git-flow
brew install --formula go
brew install --formula imagemagick
brew install --formula jq
brew install --formula lesspipe
brew install --formula lf
brew install --formula libsixel
brew install --formula lima
brew install --formula lsd
brew install --formula p7zip
brew install --formula pandoc
brew install --formula poppler
brew install --formula ripgrep
brew install --formula sheldon
brew install --formula starship
brew install --formula svg2png
brew install --formula tig
brew install --formula tmux
brew install --formula translate-shell
brew install --formula universal-ctags
brew install --formula w3m
brew install --formula watchman
brew install --formula wget
brew install --formula xz
brew install --formula zoxide

fnm install 22
fnm use 22
eval "$(fnm env --use-on-cd)"

npm --global install corepack
npm --global install textlint
npm --global install textlint-rule-preset-ja-technical-writing
npm --global install textlint-rule-prh
npm --global install trash-cli

export PYTHONUSERBASE="${HOME}/.local"

pip3 install --user --break-system-packages httpie
pip3 install --user --break-system-packages openai
pip3 install --user --break-system-packages pip3-autoremove
pip3 install --user --break-system-packages pipenv
pip3 install --user --break-system-packages pptx2md
pip3 install --user --break-system-packages xlsx2csv
pip3 install --user --break-system-packages yt-dlp

if [ ! -x "${HOME}/.tmux/plugins/tpm/bin/install_plugins" ]; then
  git clone https://github.com/tmux-plugins/tpm.git "${HOME}/.tmux/plugins/tpm"
fi

"${HOME}/.tmux/plugins/tpm/bin/install_plugins"
