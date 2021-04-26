if exists(':CocInstall')
    echomsg 'Installing coc extensions. Please wait a moment.'
    CocInstall -sync
                \ coc-css
                \ coc-eslint
                \ coc-highlight
                \ coc-html
                \ coc-json
                \ coc-markdownlint
                \ coc-sh
                \ coc-snippets
                \ coc-sql
                \ coc-stylelint
                \ coc-tsserver
                \ coc-vetur
                \ coc-vimlsp
                \ coc-xml
                \ coc-yaml

    if executable('bash')
        CocInstall -sync coc-sh
    endif

    if executable('clangd')
        CocInstall -sync coc-clangd
    endif

    if executable('cmake')
        CocInstall -sync coc-cmake
    endif

    if executable('java')
        CocInstall -sync coc-java
    endif

    if executable('perl')
        CocInstall -sync coc-perl
    endif

    if executable('php')
        CocInstall -sync coc-phpls
    endif

    if executable('pwsh') || executable('powershell')
        CocInstall -sync coc-powershell
    endif

    if executable('python') || executable('python3')
        CocInstall -sync coc-pyright

    endif
endif
quitall
