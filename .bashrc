PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
PATH=$PATH:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.local/sbin:$HOME/.npm/sbin:$HOME/bin:$HOME/sbin
export PATH=$(echo "$PATH" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')

#type sheldon >/dev/null 2>&1 && eval "$(sheldon source)"
type starship >/dev/null 2>&1 && eval "$(starship init bash)"
type zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"

test -r "$HOME/.aliases.sh" >/dev/null 2>&1 && source "$HOME/.aliases.sh"

if type gdircolors >/dev/null 2>&1; then
  eval "$(gdircolors -b)"
elif type dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi
