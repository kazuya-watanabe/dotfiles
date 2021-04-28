Import-Module PSReadLine

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Prompt

Set-PSReadLineKeyHandler -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -Key Ctrl+b -Function BackwardChar
Set-PSReadLineKeyHandler -Key Ctrl+f -Function ForwardChar

Set-PSReadLineKeyHandler -Key Ctrl+p -Function PreviousHistory
Set-PSReadLineKeyHandler -Key Ctrl+n -Function NextHistory
Set-PSReadLineKeyHandler -Key Ctrl+s -Function ForwardSearchHistory
Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory

Set-PSReadLineKeyHandler -Key Ctrl+h -Function BackwardDeleteChar
Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit
Set-PSReadLineKeyHandler -Key Ctrl+k -Function KillLine
Set-PSReadLineKeyHandler -Key Ctrl+m -Function ValidateAndAcceptLine

Set-PSReadLineKeyHandler -Key Ctrl+l -Function ClearScreen
Set-PSReadLineKeyHandler -Key Ctrl+[ -Function ViCommandMode

function prompt() {
    if ((Get-Location).Path -eq $HOME) {
        $Path = '~'
    } else {
        $Path = (Split-Path (Get-Location) -Leaf)
    }
    Write-Host $env:USERNAME'@'$env:COMPUTERNAME
    return $Path + ' > '
}

Set-Alias -Name ll -Value Get-ChildItem
