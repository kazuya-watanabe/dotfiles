$PSReadLineVersion = (Get-Module -Name PSReadLine).Version

If ($PSReadLineVersion -Lt 2.1) {
  Install-Module -Name PSReadLine -Scope CurrentUser -Force
}

Import-Module PSReadLine

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$True
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -Key Ctrl+b -Function BackwardChar
Set-PSReadLineKeyHandler -Key Ctrl+f -Function ForwardChar
Set-PSReadLineKeyHandler -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl+n -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+s -Function ForwardSearchHistory
Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory
Set-PSReadLineKeyHandler -Key Ctrl+h -Function BackwardDeleteChar
Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit
Set-PSReadLineKeyHandler -Key Ctrl+k -Function KillLine
Set-PSReadLineKeyHandler -Key Ctrl+m -Function ValidateAndAcceptLine
Set-PSReadLineKeyHandler -Key Ctrl+l -Function ClearScreen
Set-PSReadLineKeyHandler -Key Ctrl+[ -Function ViCommandMode

Remove-Item alias:cat
Remove-Item alias:cp
Remove-Item alias:curl
Remove-Item alias:diff -Force
Remove-Item alias:echo
Remove-Item alias:ls
Remove-Item alias:mv
Remove-Item alias:ps
Remove-Item alias:pwd
Remove-Item alias:rm
Remove-Item alias:rmdir
Remove-Item alias:sleep -Force
Remove-Item alias:sort -Force
Remove-Item alias:tee -Force
Remove-Item alias:type
Remove-Item alias:wget

if (Get-Command -Name bat 2>$null)
{
  function cat()
  {
    bat.exe $args
  }

  function less()
  {
    bat.exe $args
  }
}

if (Get-Command -Name delta 2>$null)
{
  function diff()
  {
    delta.exe $args
  }
}
elseif (Get-Command -Name colordiff >$null)
{
  function diff()
  {
    colordiff.exe $args
  }
}

function fd()
{
  fd.exe --follow --hidden $args
}

function d()
{
  fd --type d . $args
}

function ls()
{
  ls.exe --color=auto --classify --quoting-style=literal --show-control-chars $args
}

function l() {
  ls -l $args
}

function la() {
  ls -A $args
}

function ll() {
  ls -Al $args
}

If ($Env:WT_SESSION) {
  $Env:NERDFONT = 1

  if (Get-Command -Name lsd 2>$null)
  {
    function ls()
    {
        lsd.exe --color auto --classify --group-directories-first $args
    }
  }
}

Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })
