if type vim >/dev/null 2>&1; then
    export EDITOR=vim
    export VISUAL=vim
fi

if type less >/dev/null 2>&1; then
    export PAGER=less
    export LESS=-iJMRX
    if type lesspipe.sh >/dev/null 2>&1; then
        export LESSOPEN='| lesspipe.sh %s'
        export LESS_ADVANCED_PREPROCESSOR=1
    elif type lesspipe >/dev/null 2>&1; then
        export LESSOPEN='| lesspipe %s'
        export LESS_ADVANCED_PREPROCESSOR=1
    fi
fi

if type python >/dev/null 2>&1 || type python3 >/dev/null 2>&1; then
    export PYTHONUSERBASE=~/.local
    PATH=$PYTHONUSERBASE/bin:$PATH
fi

if type zsh >/dev/null 2>&1; then
    export ZDOTDIR=~/.zsh
fi

if [ $(uname) = Darwin ]; then
    export COPY_EXTENDED_ATTRIBUTES_DISABLE=1
    export COPYFILE_DISABLE=1

    if [ -d $HOMEBREW_PREFIX ]; then
        export HOMEBREW_PREFIX=/opt/homebrew
        export HOMEBREW_GITHUB_API_TOKEN=4f533f43c271368630b1616e27ac7b199192966f

        if [ -d $HOMEBREW_PREFIX/opt/llvm/bin ]; then
            PATH=$HOMEBREW_PREFIX/opt/llvm/bin:$PATH
        fi
        PATH=$HOMEBREW_PREFIX/bin:$PATH
    fi

    export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk

    export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
fi

if type fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_OPTS='
        --reverse
        --preview "[[ $(file --mime {}) =~ binary ]] &&
        file {} ||
        (highlight -O xterm256 -l {} ||
        coderay {} ||
        rougify {} ||
        cat {}) 2> /dev/null | head -500"'
    if type rg >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='rg --files --glob ""'
    elif type ag >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='ag --filename-pattern ""'
    fi
fi

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

export TZ=Asia/Tokyo

export PATH=~/bin:$PATH
