#!/bin/bash

set -eu

basedir=$(dirname $0)
test -r $basedir/scripts/subr.sh && source $basedir/scripts/subr.sh

pushd $basedir >/dev/null 2>&1

for i in .??*; do
    test $i = .git && continue
    test $i = .gitignore && continue
    test $i = .gitmodules && continue

    ln -fs $(pwd)/$i ~/
done

if [ $(uname) = Darwin ]; then
    read -p 'Homebrew パッケージをインストールしますか？ [Y/n]: ' -a ans
    if checkyesno ${ans:-y}; then
        $basedir/scripts/homebrew install
    fi
fi

if type npm >/dev/null 2>&1; then
    read -p 'Node.js パッケージをインストールしますか？ [Y/n]: ' -a ans
    if checkyesno ${ans:-y}; then
        $basedir/scripts/nodejs install
    fi
fi

if type python >/dev/null 2>&1 || type python3 >/dev/null 2>&1; then
    read -p 'Python パッケージをインストールしますか？ [Y/n]: ' -a ans
    if checkyesno ${ans:-y}; then
        $basedir/scripts/python install
    fi
fi

if type tmux >/dev/null 2>&1; then
    read -p 'tmux パッケージをインストールしますか？ [Y/n]: ' -a ans
    if checkyesno ${ans:-y}; then
        $basedir/scripts/tmux install
    fi
fi

popd >/dev/null 2>&1
