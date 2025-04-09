#!/usr/bin/env bash

set -euo pipefail

case "$1" in
  *.htm?)
    pandoc --standalone --from=html --to=markdown "$1" | bat --color=always --language markdown
    ;;
  *.pdf)
    pdftohtml -stdout -i "$1" | pandoc --standalone --from=html --to=markdown | bat --color=always --language html
    ;;
  *.docx)
    pandoc --standalone --from=docx --to=markdown "$1" | bat --color=always --language markdown
    ;;
  *.pptx)
    pptx2md --disable-image --output /dev/stdout "$1" | bat --color=always --language markdown
    ;;
  *.xlsx)
    xlsx2csv "$1" | bat --color=always --language csv
    ;;
  *.7z)
    7z l "$1"
    ;;
  *.tar* | *.tgz | *.tbz | *.txz)
    tar tvf "$1" 2>&1
    ;;
  *.zip)
    unzip -l "$1"
    ;;
  *.mp3 | *.flac | *.wav | *.m4a | *.mp4 | *.mkv | *.avi | *.webm | *.mov | *.wmv | *.flv | *.m4v)
    ffprobe -hide_banner -i "$1" 2>&1
    ;;
  *.json)
    jq . "$1" | bat --color=always --language json
    ;;
  *.svg)
    svg2png -w 400 "$1" | img2sixel -w 400
    ;;
  *)
    case "$(file -Lb --mime-type -- "$1")" in
      image/*)
        img2sixel -w 400 "$1"
        ;;
      text/*)
        bat --color=always --file-name "$1" "$1"
        ;;
    esac
    ;;
esac
