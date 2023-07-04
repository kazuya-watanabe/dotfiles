if type bat >/dev/null 2>&1; then
  alias cat='bat'
  alias less='bat'
fi

if type delta >/dev/null 2>&1; then
  alias diff='delta'
elif type colordiff >/dev/null 2>&1; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

alias fd='fd --follow --hidden'
alias fda='fd --follow --no-ignore'

if type lsd >/dev/null 2>&1 && ! test -z "$NERDFONT"; then
  alias ls='lsd --group-directories-first'
else
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
fi

alias l='ls -l'
alias ll='ls -Al'
alias la='ls -A'

alias rg='rg --follow --hidden --smart-case'
alias rga='rg --no-ignore'

alias sudo='sudo '
