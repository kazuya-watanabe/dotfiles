#!/bin/bash

set -eu

basedir=$(dirname $0)
test -r $basedir/scripts/subr.sh && source $basedir/scripts/subr.sh

pushd $basedir >/dev/null 2>&1

for i in .??*; do
    test $i = .git && continue
    test $i = .gitignore && continue
    test $i = .gitmodules && continue

    test $i = .profile && ln -fs $(pwd)/$i $HOME/.zshenv

    ln -fs $(pwd)/$i ~/
done

popd >/dev/null 2>&1
