Import-Module PSReadLine

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$True
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

function which() {
  Param (
    [String]
    $Name
  )

  $Command = Get-Command -Name $Name
  $Result = $?

  Write-Output ($Name + ": " + $Command.CommandType + " " + $Command.Source)

  return $Result >$Null
}

If (which('zoxide')) {
  Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
  })
}

Remove-Item alias:cat
Remove-Item alias:cp
Remove-Item alias:curl
Remove-Item alias:diff -Force
Remove-Item alias:echo
Remove-Item alias:ls
Remove-Item alias:md
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

function ls() {
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

Set-Alias -Name md -Value 'mkdir.exe'
Set-Alias -Name type -Value which

Invoke-Expression (&starship init powershell)
