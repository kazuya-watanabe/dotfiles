if exists(':CocInstall')
    echomsg 'Installing coc extensions. Please wait a moment.'
    CocInstall -sync
                \ coc-clangd
                \ coc-cmake
                \ coc-css
                \ coc-eslint
                \ coc-highlight
                \ coc-html
                \ coc-java
                \ coc-json
                \ coc-phpls
                \ coc-python
                \ coc-sh
                \ coc-snippets
                \ coc-sql
                \ coc-tsserver
                \ coc-vimlsp
                \ coc-xml
                \ coc-yaml
endif
