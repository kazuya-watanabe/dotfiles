#!/usr/bin/env bash

test -r "$(dirname $0)/scripts/subr.sh" && source "$(dirname $0)/scripts/subr.sh"

# PYTHON
PYDIR="$($(getpython) -m site --user-base)"
if [ ! -z "$PYDIR" ]
then
    PYDIR="$PYDIR/bin"
fi

# HOMEBREW
if [ -d "/opt/homebrew" ]
then
    BREWDIR_BIN="/opt/homebrew/bin"
    BREWDIR_SBIN="/opt/homebrew/sbin"
    BREWDIR_LLVM="/opt/homebrew/opt/llvm/bin"
    echo export HOMEBREW_GITHUB_API_TOKEN=4f533f43c271368630b1616e27ac7b199192966f
fi

# PATH
cat << EOS
export ZDOTDIR="$HOME/.zsh"
export PATH="\$HOME/bin":"$PYDIR":"$BREWDIR_BIN":"$BREWDIR_SBIN":"$BREWDIR_LLVM":\$PATH
EOS

# MACOS
if [ `uname` = "Darwin" ]
then
    cat << EOS
export COPY_EXTENDED_ATTRIBUTES_DISABLE=1
export COPYFILE_DISABLE=1
export _JAVA_OPTIONS="-Dfile.encoding=UTF-8"
EOS
    type xcrun >/dev/null 2>&1 && echo "export SDKROOT=$(xcrun --show-sdk-path)"
fi

if type vim >/dev/null 2>&1
then
    echo export EDITOR=vim
else
    echo export EDITOR=vi
fi

# LESS
if type less >/dev/null 2>&1
then
    echo export PAGER=less
    echo export LESS=-iJMR
    if type lesspipe.sh >/dev/null 2>&1
    then
        echo export LESSOPEN="| lesspipe.sh %s"
        echo export LESS_ADVANCED_PREPROCESSOR=1
    fi
fi

# FZF
if type fzf >/dev/null 2>&1 || type /opt/homebrew/bin/fzf >/dev/null 2>&1
then
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
fi

if type rg >/dev/null 2>&1
then
    echo export FZF_DEFAULT_COMMAND=\'rg --files --glob \"\"\'
elif type ag >/dev/null 2>&1
then
    echo export FZF_DEFAULT_COMMAND=\'ag --filename-pattern \"\"\'
fi
