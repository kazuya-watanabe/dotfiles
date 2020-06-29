#!/bin/bash

WARN="${WARN:=yes}"
INFO="${INFO:=yes}"
DEBUG="${DEBUG:=no}"

LOGGER="${LOGGER:=/usr/bin/logger}"

function checkyesno() {
    case "$1" in
        [Yy][Ee][Ss]|[Tt][Rr][Uu][Ee]|[Oo][Nn])
            return 0
            ;;
        [Nn][Oo]|[Ff][Aa][Ll][Ss][Ee]|[Oo][Ff][Ff])
            return 1
            ;;
        "")
            return 2
            ;;
        *)
            return 3
            ;;
    esac
}

function err() {
    if [ -x "$LOGGER" ]; then
        "$LOGGER" -p user.err "ERROR: $*"
    fi
    echo 1>&2 "ERROR: $*"
    return 0
}

function warn() {
    if checkyesno "$WARN"; then
        if [ -x "$LOGGER" ]; then
            "$LOGGER" -p user.warn "WARN: $*"
        fi
        echo 1>&2 "WARN: $*"
    fi
    return 0
}

function info() {
    if checkyesno "$INFO"; then
        if [ -x "$LOGGER" ]; then
            "$LOGGER" -p user.info "INFO: $*"
        fi
        echo "INFO: $*"
    fi
    return 0
}

function debug() {
    if checkyesno "$DEBUG"; then
        if [ -x "$LOGGER" ]; then
            "$LOGGER" -p user.debug "DEBUG: $*"
        fi
        echo 1>&2 "DEBUG: $*"
    fi
    return 0
}

function getpython() {
    if which python3 >/dev/null 2>&1; then
        echo "python3"
    elif which python >/dev/null 2>&1; then
        echo "python"
    else
        return 1
    fi
    return 0
}

function relpath() {
    tgt="$1"
    ref="$2"

    py=$(getpython)

    if [ -z "$py" ]; then
        echo $1
        return 0
    fi

    echo $($py -c "import os; print(os.path.relpath(\"$tgt\", \"$ref\"))")
    return 0
}
