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

# Prompting {{{1
_username_color='\[\e[00;36m\]'
_hostname_color='\[\e[00;32m\]'
_dirname_color='\[\e[00;33m\]'
_shellname_color='\[\e[00;34m\]'
_prompt_color=''
_reset_color='\[\e[m\]'
export PS1="$_username_color\u$_reset_color@$_hostname_color\h$_reset_color:$_dirname_color[\w]$_reset_color\n$_shellname_color(\s)$_reset_color \$ "
unset _username_color
unset _hostname_color
unset _dirname_color
unset _shellname_color
unset _prompt_color
unset _reset_color

# External Commands {{{1
if type fasd >/dev/null 2>&1; then
    eval "$(fasd --init auto)"
fi

test -r ~/.fzf.bash && source ~/.fzf.bash
