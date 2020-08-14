if exists(':CocInstall')
    echomsg 'Installing coc extensions. Please wait a moment.'
    CocInstall -sync
                \ coc-css
                \ coc-highlight
                \ coc-html
                \ coc-json
                \ coc-phpls
                \ coc-python
                \ coc-snippets
                \ coc-tsserver
                \ coc-vimlsp
                \ coc-yaml
endif
