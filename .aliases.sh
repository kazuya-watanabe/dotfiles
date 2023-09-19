if type bat >/dev/null 2>&1; then
  alias cat='bat'
fi

if type delta >/dev/null 2>&1; then
  alias diff='delta'
else
  alias diff='diff -u'
fi

alias fd='fd --follow --hidden'
alias d='fd --follow --hidden --type d .'

if type lsd >/dev/null 2>&1 && ! test -z "${NERDFONT}"; then
  alias ls='lsd --group-directories-first'
else
  case $(uname) in
    Darwin)
      if type gls >/dev/null 2>&1; then
        alias ls='gls --color=auto --classify --group-directories-first --quoting-style=literal'
      else
        alias ls='ls --color=auto -F'
      fi
      ;;
    Linux)
      alias ls='ls --color=auto --classify --group-directories-first --quoting-style=literal'
      ;;
    MINGW* | MSYS_NT* | CYGWIN_NT*)
      alias ls='ls --color=auto --classify --group-directories-first --quoting-style=literal --show-control-chars'
      ;;
  esac
fi

alias l='ls -l'
alias ll='ls -Al'
alias la='ls -A'
alias sudo='sudo '
alias tm='if tmux list-session >/dev/null 2>&1; then NERDFONT=1 tmux attach; else NERDFONT=1 tmux; fi'

if [ $(uname -s) = 'Darwin' ]; then
  alias cp='cp -X'
fi

# vim:ft=sh:
