if exists(':CocInstall')
    echomsg 'Installing coc extensions. Please wait a moment.'
    CocInstall -sync
                \ coc-css
                \ coc-eslint
                \ coc-highlight
                \ coc-html
                \ coc-json
                \ coc-markdownlint
                \ coc-perl
                \ coc-sh
                \ coc-snippets
                \ coc-sql
                \ coc-stylelint
                \ coc-tsserver
                \ coc-vetur
                \ coc-vimlsp
                \ coc-xml
                \ coc-yaml
    redraw
    quit

    if executable('clangd')
        CocInstall -sync coc-clangd
        redraw
        quit
    endif

    if executable('cmake')
        CocInstall -sync coc-cmake
        redraw
        quit
    endif

    if executable('java')
        CocInstall -sync coc-java
        redraw
        quit
    endif

    if executable('php')
        CocInstall -sync coc-phpls
        redraw
        quit
    endif

    if executable('python') || executable('python3')
        CocInstall -sync coc-python
        redraw
        quit
    endif

    if executable('bash')
        CocInstall -sync coc-sh
        redraw
        quit
    endif
endif
quitall
