$ScriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
Push-Location -Path $ScriptDir

$env:DOCKER_HOST = 'tcp://nas40a97e.local:2376'
[System.Environment]::SetEnvironmentVariable('DOCKER_HOST', $env:DOCKER_HOST, 'User')

$env:DOCKER_TLS_VERIFY = 1
[System.Environment]::SetEnvironmentVariable('DOCKER_TLS_VERIFY', $env:DOCKER_TLS_VERIFY, 'User')

$env:MSYS = 'winsymlinks:nativestrict'
[System.Environment]::SetEnvironmentVariable('MSYS', $env:MSYS, 'User')

$env:PYTHONUSERBASE = '%USERPROFILE%\.local'
[System.Environment]::SetEnvironmentVariable('PYTHONUSERBASE', $env:PYTHONUSERBASE, 'User')

$USER_PATH = [System.Environment]::GetEnvironmentVariable('PATH', 'User')
$USER_PATH = ";" + $env:USERPROFILE + ".\.npm"
[System.Environment]::SetEnvironmentVariable('PATH', $USER_PATH, 'User')

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
scoop install windows-terminal
scoop install zip

$BASH = scoop prefix git
$BASH += "\bin\bash.exe ./install -d"
Invoke-Expression -Command $bash

pip3 install autopep8
pip3 install pylint
pip3 install virtualenv

mkdir $env:USERPROFILE\.npm
$env:PATH += ';'
$env:PATH += $env:USERPROFILE + ".\.npm"
npm install -g eslint
npm install -g yarn

mkdir $env:USERPROFILE\vimfiles\autoload
Invoke-WebRequest -Uri https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -OutFile $env:USERPROFILE\vimfiles\autoload\plug.vim
vim -S .vim\install-vimplugins.vim
vim -S .vim\install-cocextensions.vim

Pop-Location
