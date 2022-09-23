# bat
if type bat >/dev/null 2>&1; then
  alias cat='bat'
  alias less='bat'
fi

# colordiff
type colordiff >/dev/null 2>&1 && alias diff='colordiff -u'

# ls
case $(uname) in
  Darwin)
    if type gls >/dev/null 2>&1; then
      alias ls='gls --color=auto --classify --group-directories-first --quoting-style=literal'
    else
      alias ls='ls --color=auto -F'
    fi
    alias cp='cp -X'
    ;;
  Linux)
    alias ls='ls --color=auto --classify --group-directories-first --quoting-style=literal'
    ;;
  MINGW* | MSYS_NT* | CYGWIN_NT*)
    alias ls='ls --color=auto --classify --group-directories-first --quoting-style=literal --show-control-chars'
    ;;
esac

alias l='ls -l'
alias ll='ls -Al'
alias la='ls -A'

# sudo
alias sudo='sudo '
