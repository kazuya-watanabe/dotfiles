# Changing Directories
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# Completion
typeset -U fpath FPATH

fpath=('/usr/local/share/zsh-completions'(N-/)
       '/usr/local/share/zsh/site-functions'(N-/)
       '/usr/share/zsh/site-functions'(N-/)
       '/usr/local/etc/bash_completion.d'(N-/)
       '/etc/bash_completion.d'(N-/)
       $fpath)

setopt auto_name_dirs
unsetopt auto_remove_slash

zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

# Expansion and Globbing
unsetopt case_glob
setopt magic_equal_subst

# History
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

# Input/Output
setopt correct

# Job Control
setopt notify

# Key binding
bindkey -v
bindkey -M vicmd 'j'  history-substring-search-down
bindkey -M vicmd 'k'  history-substring-search-up
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^B' backward-char
bindkey -M viins '^D' delete-char-or-list
bindkey -M viins '^E' end-of-line
bindkey -M viins '^F' forward-char
bindkey -M viins '^G' send-break
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^K' kill-line
bindkey -M viins '^N' history-substring-search-down
bindkey -M viins '^P' history-substring-search-up
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^Y' yank

# Aliases
source "$HOME/.aliases.sh"

# External Commands
if [ -f /usr/share/zsh/site-functions/fzf ]; then
  source /usr/share/zsh/site-functions/fzf
elif [ -f /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/completion.zsh
fi

if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
elif [ -f /usr/local/opt/fzf/shell/key-bindings.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
fi

type sheldon >/dev/null 2>&1 && eval "$(sheldon source)"

type starship >/dev/null 2>&1 && eval "$(starship init zsh)"

type zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
