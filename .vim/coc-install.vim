if exists(':CocInstall')
    function! s:coc_install(extension)
        echomsg 'Installing ' . a:extension . '. Please wait a moment.'
        silent execute('CocInstall -sync ' . a:extension)
    endfunction

    call s:coc_install('coc-css')
    call s:coc_install('coc-eslint')
    call s:coc_install('coc-highlight')
    call s:coc_install('coc-html')
    call s:coc_install('coc-snippets')
    call s:coc_install('coc-sql')
    call s:coc_install('coc-tsserver')
    call s:coc_install('coc-vimlsp')
    call s:coc_install('coc-xml')
    call s:coc_install('coc-yaml')
    if executable('clangd')
        call s:coc_install('coc-clangd')
    endif
    if executable('cmake')
        call s:coc_install('coc-cmake')
    endif
    if executable('java')
        call s:coc_install('coc-java')
    endif
    call s:coc_install('coc-json')
    if executable('php')
        call s:coc_install('coc-phpls')
    endif
    if executable('python')
        call s:coc_install('coc-python')
    endif
    if executable('bash')
        call s:coc_install('coc-sh')
    endif
endif
