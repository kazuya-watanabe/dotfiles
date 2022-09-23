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

type starship >/dev/null 2>&1 && eval "$(starship init bash)"

type zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"
