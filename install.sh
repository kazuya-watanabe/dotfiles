#!/bin/bash

set -eu

basedir=$(dirname $0)
test -r $basedir/scripts/subr.sh && source $basedir/scripts/subr.sh

pushd $basedir >/dev/null 2>&1

for i in .??*; do
    [[ $i = .git ]] && continue
    [[ $i = .gitignore ]] && continue
    [[ $i = .gitmodules ]] && continue

    if [ -e ~/$i ]; then
        mv -f ~/$i ~/$i.$(date +%s)
    fi

    ln -fs $(pwd)/$i ~/
done

popd >/dev/null 2>&1
