#!/usr/bin/env bash

set -eu

test -r "$(dirname $0)/scripts/subr.sh" && source "$(dirname $0)/scripts/subr.sh"

pushd "$(dirname ${0})" >/dev/null 2>&1

for i in .??*
do
    [[ "$i" = ".git" ]] && continue
    [[ "$i" = ".gitignore" ]] && continue
    [[ "$i" = ".gitmodules" ]] && continue

    if [ -e "$HOME/$i" ]
    then
        mv -f "$HOME/$i" "$HOME/$i.$(date +%s)"
    fi

    ln -fs "$(relpath $i $HOME)" "$HOME/"
done

popd >/dev/null 2>&1
