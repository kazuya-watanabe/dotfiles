#!/usr/bin/env bash

set -eu

pushd "$(dirname ${0})" >/dev/null 2>&1

for i in .??*
do
    [[ $i = '.git' ]] && continue
    [[ $i = '.gitignore' ]] && continue
    [[ $i = '.gitmodules' ]] && continue

    if [ -e "${HOME}/${i}" ]
    then
        mv -f "${HOME}/${i}" "${HOME}/${i}.$(date +%s)"
    fi

    if type python3 >/dev/null 2>&1
    then
        ln -fs "$(python3 -c "import os; print(os.path.relpath(\"${i}\", \"${HOME}\"))")" "${HOME}/"
    elif type python >/dev/null 2>&1
    then
        ln -fs "$(python -c "import os; print(os.path.relpath(\"${i}\", \"${HOME}\"))")" "${HOME}/"
    fi
done

popd >/dev/null 2>&1
