export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export TZ=Asia/Tokyo

if type vim >/dev/null 2>&1; then
    export EDITOR=vim
    export VISUAL=vim
fi

if type less >/dev/null 2>&1; then
    export PAGER=less
    export LESS=-iJMRX

    for i in lesspipe.sh lesspipe; do
        if type $i >/dev/null 2>&1; then
            export LESSOPEN="| $i %s"
            export LESS_ADVANCED_PREPROCESSOR=1
            if type pygmentize >/dev/null 2>&1; then
                export LESSCOLORIZER=pygmentize
            else
                export LESSCOLORIZER=code2color
            fi
            break
        fi
    done
fi

if type python >/dev/null 2>&1 || type python3 >/dev/null 2>&1; then
    export PYTHONUSERBASE="$HOME/.local"
    export PATH="$PYTHONUSERBASE/bin":$PATH
fi

if type composer >/dev/null 2>&1; then
    export COMPOSER_HOME="$HOME/.composer"
    export PATH="$COMPOSER_HOME/vendor/bin":$PATH
fi

if type npm >/dev/null 2>&1; then
    export PATH="`npm bin -g 2>/dev/null`":$PATH
    mkdir -p "`npm root -g`"
fi

if type zsh >/dev/null 2>&1; then
    export ZDOTDIR="$HOME/.zsh"
fi

if [ $(uname) = Darwin ]; then
    export COPY_EXTENDED_ATTRIBUTES_DISABLE=1
    export COPYFILE_DISABLE=1
    export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
    export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'
    export HOMEBREW_GITHUB_API_TOKEN=0829119282e606df8c3b0fe8e59ce8705cd4e4e6
    export PATH=/usr/local/opt/llvm/bin:/usr/local/opt/ruby/bin:$PATH
    stty discard undef
fi

if type fzf >/dev/null 2>&1; then
    if type fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fd --hidden --type f --exclude .git --exclude node_modules'
    elif type fdfind >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fdfind --hidden --type f --exclude .git --exclude node_modules'
    elif type rg >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='rg --hidden --files --glob ""'
    elif type ag >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='ag --hidden --filename-pattern ""'
    fi
    export FZF_DEFAULT_OPTS='--layout=reverse --inline-info --border'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

if type docker >/dev/null 2>&1; then
    export DOCKER_HOST=tcp://nas40a97e.local:2376
    export DOCKER_TLS_VERIFY=1
fi
