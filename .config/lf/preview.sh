#!/usr/bin/env bash

set -euo pipefail

case "$1" in
  *.tar*)
    tar tvf "$1" 2>&1
    ;;
  *.zip)
    unzip -l "$1"
    ;;
  *.7z)
    7z l "$1"
    ;;
  *)
    bat --color=always "$1"
    ;;
esac
