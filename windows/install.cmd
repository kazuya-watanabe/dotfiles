@ECHO OFF
SETLOCAL

SET TARGETDIR=%~dp0..\

PUSHD "%USERPROFILE%"

MKDIR   .config\coc\ultisnips
MKLINK  .config\coc\ultisnips\all.snippets "%TARGETDIR%.config\coc\ultisnips\all.snippets"

MKDIR   .pip
MKLINK  .pip\pip.conf               "%TARGETDIR%.pip\pip.conf"

MKDIR   .ssh
MKLINK  .ssh\aws-keypair-1.pem      "%TARGETDIR%.ssh\aws-keypair-1.pem"
MKLINK  .ssh\config                 "%TARGETDIR%.ssh\config"
MKLINK  .ssh\github-keypair-1.pem   "%TARGETDIR%.ssh\github-keypair-1.pem"

MKDIR   .vim
MKLINK  .vim\coc-insall.vim         "%TARGETDIR%.vim\coc-install.vim"
MKLINK  .vim\coc-settings.json      "%TARGETDIR%.vim\coc-settings.json"
MKLINK  .vim\gvimrc                 "%TARGETDIR%.vim\gvimrc"
MKLINK  .vim\vimrc                  "%TARGETDIR%.vim\vimrc"
MKLINK  /D vimfiles .vim

MKLINK  .bash_profile               "%TARGETDIR%.bash_profile"
MKLINK  .bashrc                     "%TARGETDIR%.bashrc"
MKLINK  .ctags                      "%TARGETDIR%.ctags"
MKLINK  .curlrc                     "%TARGETDIR%.curlrc"
MKLINK  .gitconfig                  "%TARGETDIR%.gitconfig"
MKLINK  .gitignore.global           "%TARGETDIR%.gitignore.global"
MKLINK  .inputrc                    "%TARGETDIR%.inputrc"
MKLINK  .profile                    "%TARGETDIR%.profile"
MKLINK  .tigrc                      "%TARGETDIR%.tigrc"
MKLINK  .wgetrc                     "%TARGETDIR%.wgetrc"

POPD

SETX MSYS "winsymlinks:nativestrict"

regedit %TARGETDIR%windows\caps2ctrl.reg
regedit %TARGETDIR%windows\guestauth.reg
regedit %TARGETDIR%windows\longpath.reg
