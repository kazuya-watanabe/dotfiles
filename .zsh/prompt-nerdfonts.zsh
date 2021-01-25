#!/usr/bin/env zsh

setopt prompt_subst

USERNAME_PATTERN="%{$fg[cyan]%}:%n%{$reset_color%}"
HOSTNAME_PATTERN="%{$fg[green]%}:%m%{$reset_color%}"
CURRENTDIR_PATTERN="%{$fg[yellow]%}:%~%{$reset_color%}"
DATETIME_PATTERN="%{$fg[red]%}:%D{%Y-%m-%d %H:%M}%{$reset_color%}"
PROMPT_PATTERN=" %# "
VIINSERT_PATTERN="%{$fg[blue]%} INSERT%{$reset_color%}"
VINORMAL_PATTERN="%{$fg[red]%}ﲵ NORMAL%{$reset_color%}"

autoload -Uz vcs_info

function precmd {
    vcs_info
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=''
ZSH_THEME_GIT_PROMPT_CLEAN=''

if ! type virtualenv_prompt_info >/dev/null 2>&1; then
    function virtualenv_prompt_info {
    }
fi

ZSH_THEME_VIRTUALENV_PREFIX="%{$fg[magenta]%}:"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%} "

function zle-line-init zle-keymap-select {
    VIM_PATTERN="${${KEYMAP/vicmd/$VINORMAL_PATTERN}/(main|viins)/$VIINSERT_PATTERN}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

PROMPT='$USERNAME_PATTERN $HOSTNAME_PATTERN $CURRENTDIR_PATTERN
$VIM_PATTERN$PROMPT_PATTERN'
RPROMPT='$(virtualenv_prompt_info)$(git_prompt_info)$DATETIME_PATTERN'
