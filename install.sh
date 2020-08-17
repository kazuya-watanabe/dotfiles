#!/bin/bash

set -eu

basedir=$(dirname $0)
test -r $basedir/scripts/subr.sh && source $basedir/scripts/subr.sh

pushd $basedir >/dev/null 2>&1

for i in .??*; do
    test $i = .git && continue
    test $i = .gitignore && continue
    test $i = .gitmodules && continue

    info "Installing ~/$i."
    if [ -e ~/$i ]; then
        read -p "Do you want to overwrite the file '~/$i'? [Y/n]: " -a ans
        if ! checkyesno ${ans:-y}; then
            info "-- Skipped."
            continue
        else
            mv -f ~/$i ~/$i.$(date +%F)
            info "-- Backupped."
        fi
    fi

    ln -s $(pwd)/$i ~/
    info "-- Installed."
done

if [ $(uname) = Darwin ]; then
    read -p 'Do you want to install the Homebrew packages? [Y/n]: ' -a ans
    if checkyesno ${ans:-y}; then
        $basedir/scripts/homebrew install
    fi
fi

source $basedir/.profile

if type npm >/dev/null 2>&1; then
    read -p 'Do you wanto to install the Node.js packages? [Y/n]: ' -a ans
    if checkyesno ${ans:-y}; then
        $basedir/scripts/nodejs install
    fi
fi

if type python >/dev/null 2>&1 || type python3 >/dev/null 2>&1; then
    read -p 'Do you want to install the Python packages? [Y/n]: ' -a ans
    if checkyesno ${ans:-y}; then
        $basedir/scripts/python install
    fi
fi

if type tmux >/dev/null 2>&1; then
    read -p 'Do you want to install the tmux packages? [Y/n]: ' -a ans
    if checkyesno ${ans:-y}; then
        $basedir/scripts/tmux install
    fi
fi

popd >/dev/null 2>&1
