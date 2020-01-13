# zplug {{{1
if [ ! -r "${HOME}/.zplug/init.zsh" ]
then
    mkdir -p "${HOME}/.zplug"
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

if [ -r "${HOME}/.zplug/init.zsh" ]
then
    source "${HOME}/.zplug/init.zsh"

    zplug 'plugins/aws', from:oh-my-zsh
    zplug 'plugins/docker', from:oh-my-zsh
    zplug 'plugins/docker-compose', from:oh-my-zsh
    zplug 'plugins/fasd', from:oh-my-zsh
    zplug 'plugins/git', from:oh-my-zsh
    zplug 'plugins/git-flow', from:oh-my-zsh
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
fi

if type history-substring-search-up >/dev/null 2>&1
then
    bindkey -M emacs '^P' history-substring-search-up
    bindkey -M emacs '^N' history-substring-search-down
    bindkey -M vicmd 'k'  history-substring-search-up
    bindkey -M vicmd 'j'  history-substring-search-down
fi

# Changing Directories {{{1
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# Completion {{{1
typeset -U fpath FPATH

fpath=("${HOME}/.homebrew/share/zsh/site-functions"(N-/)
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

HISTFILE="${HOME}/.zsh/.zsh_history"
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

# Prompting {{{1
setopt prompt_subst

_username_color='%F{cyan}'
_hostname_color='%F{green}'
_dirname_color='%F{yellow}'
_vcsinfo_staged_color='%F{yellow}'
_vcsinfo_unstaged_color='%F{red}'
_vcsinfo_normal_color='%F{green}'
_virtualenv_color='%F{magenta}'
_datetime_color='%F{red}'
_prompt_color=''
_vi_ins_color='%F{blue}'
_vi_norm_color='%F{red}'

_username_pattern="${_username_color}%n%f"
_hostname_pattern="${_hostname_color}%m%f"
_dirname_pattern="${_dirname_color}[%~]%f"
_datetime_pattern="${_datetime_color}[%D{%Y.%m.%d %H:%M}]%f"
_prompt_pattern="${_prompt_color}%#%f"
_vi_ins_pattern="${_vi_ins_color}[INSERT]%f"
_vi_norm_pattern="${_vi_norm_color}[NORMAL]%f"

# vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "${_vcsinfo_staged_color}!"
zstyle ':vcs_info:git:*' unstagedstr "${_vcsinfo_unstaged_color}+"
zstyle ':vcs_info:*' formats "${_vcsinfo_normal_color}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

function precmd
{
    vcs_info
}

# virtualenv_prompt_info
if ! type virtualenv_prompt_info >/dev/null 2>&1
then
    function virtualenv_prompt_info() {
    }
fi
ZSH_THEME_VIRTUALENV_PREFIX="${_virtualenv_color}["
ZSH_THEME_VIRTUALENV_SUFFIX=']%f '

# vi mode
function zle-line-init zle-keymap-select
{
    _vim_pattern="${${KEYMAP/vicmd/${_vi_norm_pattern}}/(main|viins)/${_vi_ins_pattern}}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

PROMPT='${_username_pattern}@${_hostname_pattern}:${_dirname_pattern}
${_vim_pattern}${_prompt_pattern} '
RPROMPT='$(virtualenv_prompt_info)${vcs_info_msg_0_}${_datetime_pattern}'

unset _username_color
unset _hostname_color
unset _dirname_color
unset _vcsinfo_staged_color
unset _vcsinfo_unstaged_color
unset _vcsinfo_normal_color
unset _virtualenv_color
unset _datetime_color
unset _prompt_color
unset _vi_ins_color
unset _vi_norm_color

# Key binding {{{1
bindkey -v
bindkey -M viins '^?'  backward-delete-char
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^G'  send-break
bindkey -M viins '^H'  backward-delete-char
bindkey -M viins '^K'  kill-line
bindkey -M viins '^N'  history-beginning-search-forward-end
bindkey -M viins '^P'  history-beginning-search-backward-end
bindkey -M viins '^R'  history-incremental-pattern-search-backward
bindkey -M viins '^U'  backward-kill-line
bindkey -M viins '^W'  backward-kill-word
bindkey -M viins '^Y'  yank

# Aliases {{{1
case "$(uname)" in
    'Darwin' | 'FreeBSD')
        alias ls='ls -FG'
        ;;
    'Linux')
        alias ls='ls --color=auto --classify --group-directories-first --quoting-style=literal'
        ;;
    'MINGW'* | 'MSYS_NT'* | 'CYGWIN_NT'*)
        alias ls='ls --color=auto --classify --group-directories-first --quoting-style=literal --show-control-chars'
        ;;
esac
if type gls >/dev/null 2>&1
then
    alias ls='gls --color=auto --classify --group-directories-first --quoting-style=literal'
fi
alias l='ls -l'
alias ll='ls -Al'
alias la='ls -A'

if [ "$(uname)" = 'Darwin' ]
then
    alias cp='cp -Xi'
else
    alias cp='cp -i'
fi

alias mv='mv -i'

alias rm='rm -i'

alias vi='vim'

alias more='less'

if type colordiff >/dev/null 2>&1
then
    alias colordiff='colordiff -u'
    alias diff='colordiff'
else
    alias diff='diff -u'
fi

if type exctags >/dev/null 2>&1
then
    alias ctags='exctags'
fi

alias sudo='sudo '

# External Commands {{{1
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
