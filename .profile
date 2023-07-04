export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export TZ=Asia/Tokyo

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export PATH="$HOME/.cargo/bin":"$HOME/.dotnet/tools":"$HOME/.local/bin":"$HOME/.npm/bin":/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

umask 0022

# fzf
export FZF_DEFAULT_COMMAND='fd --hidden --follow --type f --exclude .git/'

# less
export PAGER=less
export LESS=-iFJMRX
export LESSOPEN="| lesspipe.sh %s"
export LESS_ADVANCED_PREPROCESSOR=1

if type bat >/dev/null 2>&1; then
  # bat
  export MANPAGER='sh -c "col -bx | bat -l man -p"'
  export PAGER=bat
fi

# python
export PYTHONUSERBASE="$HOME/.local"

# vim
export EDITOR=vim
export VISUAL=vim

# zsh
export ZDOTDIR="$HOME/.zsh"

# macos
if [ $(uname)='Darwin' ]; then
  export COPY_EXTENDED_ATTRIBUTES_DISABLE=1
  export COPYFILE_DISABLE=1
  export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
  export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
fi
