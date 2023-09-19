plugins=(
  starship
  vi-mode
  zoxide
  )

typeset -U fpath FPATH

fpath=(
  '/opt/homebrew/share/zsh/site-functions'(N-/)
  '/opt/homebrew/share/zsh/vendor-completions'(N-/)
  '/usr/local/share/zsh/site-functions'(N-/)
  '/usr/local/share/zsh/vendor-completions'(N-/)
  '/usr/share/zsh/site-functions'(N-/)
  '/usr/share/zsh/vendor-completions'(N-/)
  ${fpath}
  )

type sheldon >/dev/null 2>&1 && eval "$(sheldon source)"

test -r "${HOME}/.aliases.sh" >/dev/null 2>&1 && source "${HOME}/.aliases.sh"

setopt auto_name_dirs
setopt bang_hist
setopt correct
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_verify
setopt magic_equal_subst
setopt notify
setopt share_history
unsetopt auto_remove_slash
unsetopt case_glob

zstyle ':completion:*' menu true select list-colors

autoload history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

HISTFILE="${HOME}/.zsh/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

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

if type fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

if type gdircolors >/dev/null 2>&1; then
  eval "$(gdircolors -b)"
elif type dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi

if [ -r "${HOME}/.conceal/.zsh/.zshrc-private" ]; then
  source "${HOME}/.conceal/.zsh/.zshrc-private"
fi
