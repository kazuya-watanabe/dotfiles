type sheldon >/dev/null 2>&1 && eval "$(sheldon source)"
type starship >/dev/null 2>&1 && eval "$(starship init bash)"
type zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"

test -r "$HOME/.aliases.sh" >/dev/null 2>&1 && source "$HOME/.aliases.sh"
