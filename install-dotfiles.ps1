$DotFiles = @(
  '.config\git'
  '.config\pip'
  '.config\tig'
  '.config\starship.toml'
  '.curlrc'
)

function Link-Dotfile() {
  Param (
    [String]
    $Value,

    [String]
    $Path
  )

  Process {
    $IsDirectory = (Get-Item -Path $Value).PSIsContainer

    If (Test-Path -Path $Path) {
      $Item = (Get-Item -Path $Path)

      If (((-Not $IsDirectory) -And ($Item.LinkType -Eq 'HardLink')) -Or ($IsDirectory -And ($Item.LinkType -Eq 'Junction'))) {
        $Item.Delete()
      } Else {
        If (Test-Path -Path "$Path~") {
          (Get-Item -Path "$Path~").Delete()
        }

        $Item.MoveTo("$Path~")
      }
    }

    $DirName = Split-Path -Path $Path -Parent

    If ($DirName -Ne '') {
      New-Item -Force -Path $DirName -ItemType Directory
    }

    If ($IsDirectory) {
      New-Item -ItemType Junction -Value $Value -Path $Path
    } Else {
      New-Item -ItemType HardLink -Value $Value -Path $Path
    }
  }
}


$Dir = (Split-Path $MyInvocation.MyCommand.Path -Parent)

Foreach ($i in $DotFiles) {
  Link-Dotfile -Value (Join-Path -Path $Dir -ChildPath $i) -Path (Join-Path -Path $HOME -ChildPath $i)
}

Link-Dotfile -Value (Join-Path -Path $Dir -ChildPath '.config\bat') -Path (Join-Path -Path $env:APPDATA -ChildPath 'bat')
Link-Dotfile -Value (Join-Path -Path $Dir -ChildPath '.vim') -Path (Join-Path -Path $HOME -ChildPath 'vimfiles')
Link-Dotfile -Value (Join-Path -Path $Dir -ChildPath 'windows\posh') -Path (Join-Path $HOME -ChildPath 'Documents\WindowsPowerShell')
