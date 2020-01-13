@ECHO OFF
SETLOCAL

SET TARGETDIR=%~dp0..\

PUSHD "%USERPROFILE%"
MKLINK /D .pip              "%TARGETDIR%.pip"
MKLINK /D .ssh              "%TARGETDIR%.ssh"
MKLINK /D .vim              "%TARGETDIR%.vim"
MKLINK /D vimfiles          "%TARGETDIR%.vim"
MKLINK    .bashrc           "%TARGETDIR%.bashrc"
MKLINK    .ctags            "%TARGETDIR%.ctags"
MKLINK    .curlrc           "%TARGETDIR%.curlrc"
MKLINK    .gitconfig        "%TARGETDIR%.gitconfig"
MKLINK    .gitignore.global "%TARGETDIR%.gitignore.global"
MKLINK    .inputrc          "%TARGETDIR%.inputrc"
MKLINK    .tigrc            "%TARGETDIR%.tigrc"
MKLINK    .tmux.conf        "%TARGETDIR%.tmux.conf"
MKLINK    .wgetrc           "%TARGETDIR%.wgetrc"
POPD

SETX MSYS "winsymlinks:nativestrict"

regedit %TARGETDIR%windows\caps2ctrl.reg
regedit %TARGETDIR%windows\guestauth.reg
regedit %TARGETDIR%windows\longpath.reg
