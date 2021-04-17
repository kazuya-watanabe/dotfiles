$ScriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent

scoop bucket add extras
scoop bucket add java

scoop install aria2
scoop install autohotkey
scoop install bzip2
scoop install cmake
scoop install composer
scoop install ctags
scoop install docker
scoop install draw.io
scoop install fd
scoop install ffmpeg
scoop install fzf
scoop install gimp
scoop install gzip
scoop install imagemagick
scoop install inkscape
scoop install llvm
scoop install make
scoop install nodejs
scoop install openjdk
scoop install php
scoop install python
scoop install ripgrep
scoop install unzip
scoop install vim
scoop install zip

python3 -m pip install autopep8
python3 -m pip install pylint

npm install -g eslint
npm install -g yarn

New-Item -ItemType Directory -Path $env:USERPROFILE\vimfiles\autoload
Invoke-WebRequest -Uri https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -OutFile $env:USERPROFILE\vimfiles\autoload\plug.vim
New-Item -ItemType Junction -Path $env:USERPROFILE\vimfiles\after -Value $ScriptDir\.vim\after
New-Item -ItemType Junction -Path $env:USERPROFILE\vimfiles\UltiSnips -Value $ScriptDir\.vim\UltiSnips
New-Item -ItemType HardLink -Path $env:USERPROFILE\vimfiles\coc-settings.json -Value $ScriptDir\.vim\coc-settings.json
New-Item -ItemType HardLink -Path $env:USERPROFILE\vimfiles\gvimrc -Value $ScriptDir\.vim\gvimrc
New-Item -ItemType HardLink -Path $env:USERPROFILE\vimfiles\vimrc -Value $ScriptDir\.vim\vimrc
New-Item -ItemType HardLink -Path $env:USERPROFILE\.gitconfig -Value $ScriptDir\.gitconfig
New-Item -ItemType HardLink -Path $env:USERPROFILE\.gitignore.global -Value $ScriptDir\.gitignore.global

vim -S $ScriptDir\.vim\install-vimplugins.vim
vim -S $ScriptDir\.vim\install-cocextensions.vim
