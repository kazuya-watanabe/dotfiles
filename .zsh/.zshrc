# zplug {{{1
for i in "$HOME/.zplug/init.zsh" '/usr/local/opt/zplug/init.zsh' '/usr/share/zplug/init.zsh'; do
    if [ -r "$i" ]; then
        ZPLUG_INIT="$i"
        break
    fi
done

if [ ! -z "$ZPLUG_INIT" ]; then
    export ZPLUG_HOME="$HOME/.zplug"
    source "$ZPLUG_INIT"

    zplug 'plugins/docker', from:oh-my-zsh
    zplug 'plugins/fasd', from:oh-my-zsh
    zplug 'plugins/git', from:oh-my-zsh
    zplug 'plugins/python', from:oh-my-zsh
    zplug 'plugins/ripgrep', from:oh-my-zsh
    zplug 'plugins/tig', from:oh-my-zsh
    zplug 'plugins/tmux', from:oh-my-zsh
    zplug 'plugins/virtualenv', from:oh-my-zsh
    zplug 'zplug/zplug', hook-build:'zplug --self-manage'
    zplug 'zsh-users/zsh-autosuggestions'
    zplug 'zsh-users/zsh-completions'
    zplug 'zsh-users/zsh-history-substring-search'
    zplug 'zsh-users/zsh-syntax-highlighting', defer:2

    zplug load

    if type history-substring-search-up >/dev/null 2>&1; then
        bindkey -M emacs '^P' history-substring-search-up
        bindkey -M emacs '^N' history-substring-search-down
        bindkey -M vicmd 'k'  history-substring-search-up
        bindkey -M vicmd 'j'  history-substring-search-down
    fi
fi

# Changing Directories {{{1
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# Completion {{{1
typeset -U fpath FPATH

fpath=("/usr/local/share/zsh/site-functions"(N-/)
       "/usr/share/zsh/site-functions"(N-/)
       "/usr/local/etc/bash_completion.d"(N-/)
       "/etc/bash_completion.d"(N-/)
       $fpath)

setopt auto_name_dirs
unsetopt auto_remove_slash

# Expansion and Globbing {{{1
unsetopt case_glob
setopt magic_equal_subst

# History {{{1
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

HISTFILE="$HOME/.zsh/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt bang_hist
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_verify
setopt share_history

# Input/Output {{{1
setopt correct

# Job Control {{{1
setopt notify

# Key binding {{{1
bindkey -v
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^G' send-break
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^K' kill-line
bindkey -M viins '^N' history-beginning-search-forward-end
bindkey -M viins '^P' history-beginning-search-backward-end
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^Y' yank

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

if [ $(uname) = 'Darwin' ]; then
    alias cp='cp -Xi'
else
    alias cp='cp -i'
fi

alias mv='mv -i'

alias rm='rm -i'

if type vim >/dev/null 2>&1; then
    alias vi=vim
fi

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

if type vifm >/dev/null 2>&1; then
    alias fm=vifm
fi

# External Commands {{{1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ "$NERDFONTS" != "1" ]; then
    [ -f ~/.zsh/prompt.zsh ] && source ~/.zsh/prompt.zsh
else
    [ -f ~/.zsh/prompt.zsh ] && source ~/.zsh/prompt-nerdfonts.zsh
fi
