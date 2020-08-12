# Aliases {{{1
case $(uname) in
    Darwin | FreeBSD)
        alias ls='ls -FG'
        ;;
    Linux)
        alias ls='ls --color=auto --classify --group-directories-first --quoting-style=literal'
        ;;
    MINGW* | MSYS_NT* | CYGWIN_NT*)
        alias ls='ls --color=auto --classify --group-directories-first --quoting-style=literal --show-control-chars'
        ;;
esac
if type gls >/dev/null 2>&1; then
    alias ls='gls --color=auto --classify --group-directories-first --quoting-style=literal'
fi
alias l='ls -l'
alias ll='ls -Al'
alias la='ls -A'

if [ $(uname) = Darwin ]; then
    alias cp='cp -Xi'
else
    alias cp='cp -i'
fi

alias mv='mv -i'

alias rm='rm -i'

alias vi=vim

alias more=less

if type colordiff >/dev/null 2>&1; then
    alias colordiff='colordiff -u'
    alias diff=colordiff
else
    alias diff='diff -u'
fi

if type exctags >/dev/null 2>&1; then
    alias ctags=exctags
fi

alias sudo='sudo '

# External Commands {{{1
if type fasd >/dev/null 2>&1; then
    fasd_cache="~/.fasd-init-bash"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
      fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
    fi
    source "$fasd_cache"
    unset fasd_cache
fi

test -r ~/.fzf.bash && source ~/.fzf.bash
