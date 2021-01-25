if exists(':PlugInstall')
    echomsg 'Installing vim plugins.'
    PlugInstall --sync
endif
quitall
