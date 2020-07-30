#!/bin/bash

set -eu

test -r "$(dirname $0)/scripts/subr.sh" && source "$(dirname $0)/scripts/subr.sh"

# PYTHON
echo export PYTHONUSERBASE=~/.local
PYDIR=~/.local/bin

# HOMEBREW
if [ -d /opt/homebrew ]; then
    BREWDIR_BIN=/opt/homebrew/bin
    BREWDIR_SBIN=/opt/homebrew/sbin
    BREWDIR_LLVM=/opt/homebrew/opt/llvm/bin
    echo export HOMEBREW_GITHUB_API_TOKEN=4f533f43c271368630b1616e27ac7b199192966f
fi

# ZSH
echo export ZDOTDIR=~/.zsh

# PATH
if [ -z "$BREWDIR_BIN" ]; then
    cat << EOS
export PATH=~/bin:~/.local/bin:\$PATH
EOS
else
    cat << EOS
export PATH=~/bin:~/.local/bin:$BREWDIR_BIN:$BREWDIR_SBIN:$BREWDIR_LLVM:\$PATH
EOS
fi

# MACOS
if [ `uname` = Darwin ]; then
    cat << EOS
export COPY_EXTENDED_ATTRIBUTES_DISABLE=1
export COPYFILE_DISABLE=1
export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
EOS
    type xcrun >/dev/null 2>&1 && echo "export SDKROOT=$(xcrun --show-sdk-path)"
fi

# VIM
if type vim >/dev/null 2>&1; then
    echo export EDITOR=vim
    echo export VISUAL=vim
else
    echo export EDITOR=vi
    echo export VISUAL=vi
fi

# LESS
if type less >/dev/null 2>&1; then
    echo export PAGER=less
    echo export LESS=-iJMR
    if type lesspipe.sh >/dev/null 2>&1; then
        echo "export LESSOPEN='| lesspipe.sh %s'"
        echo export LESS_ADVANCED_PREPROCESSOR=1
    elif type lesspipe >/dev/null 2>&1; then
        echo "export LESSOPEN='| lesspipe %s'"
        echo export LESS_ADVANCED_PREPROCESSOR=1
    fi
else
    echo export PAGER=more
fi

# FZF
if type fzf >/dev/null 2>&1 || type /opt/homebrew/bin/fzf >/dev/null 2>&1; then
    cat << EOS
export FZF_DEFAULT_OPTS='
    --reverse
    --preview "[[ \$(file --mime {}) =~ binary ]] &&
    file {} ||
    (highlight -O xterm256 -l {} ||
    coderay {} ||
    rougify {} ||
    cat {}) 2> /dev/null | head -500"'
EOS
    if type rg >/dev/null 2>&1; then
        echo export FZF_DEFAULT_COMMAND=\'rg --files --glob \"\"\'
    elif type ag >/dev/null 2>&1; then
        echo export FZF_DEFAULT_COMMAND=\'ag --filename-pattern \"\"\'
    fi
fi

# SHELL
cat << EOS
if [ \$SHELL = /bin/bash -o \$SHELL = /usr/bin/bash ]; then
    test -r /etc/bash.bashrc && source /etc/bash.bashrc
    test -r /etc/bashrc && source /etc/bashrc
    test -r ~/.bashrc && source ~/.bashrc
fi
EOS
