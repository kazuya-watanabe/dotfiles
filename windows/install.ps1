function _Link() {
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

      If (($Item.LinkType -Eq 'HardLink') -Or ($Item.LinkType -Eq 'Junction')) {
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
      New-Item -Force -Path $DirName -ItemType Directory >$null
    }

    If ($IsDirectory) {
      New-Item -ItemType Junction -Value $Value -Path $Path >$null
    } Else {
      New-Item -ItemType HardLink -Value $Value -Path $Path >$null
    }
  }
}

function Install-Dotfiles() {
  gh auth login

  $GitDir= (Join-Path -Path $HOME -ChildPath '.conceal')

  If (-not (Test-Path -Path $GitDir)) {
    gh repo clone dotfiles.conceal $GitDir -- --recursive
    Push-Location -Path $GitDir
    gh auth setup-git
    Pop-Location
  }

  _Link -Value (Join-Path -Path $GitDir -ChildPath '.config\openai.token')    -Path (Join-Path -Path $HOME -ChildPath '.config\openai.token')
  _Link -Value (Join-Path -Path $GitDir -ChildPath '.config\textlint')        -Path (Join-Path -Path $HOME -ChildPath '.config\textlint')
  _Link -Value (Join-Path -Path $GitDir -ChildPath '.ssh\aws')                -Path (Join-Path -Path $HOME -ChildPath '.ssh\aws')
  _Link -Value (Join-Path -Path $GitDir -ChildPath '.ssh\azure')              -Path (Join-Path -Path $HOME -ChildPath '.ssh\azure')
  _Link -Value (Join-Path -Path $GitDir -ChildPath '.ssh\backlog')            -Path (Join-Path -Path $HOME -ChildPath '.ssh\backlog')
  _Link -Value (Join-Path -Path $GitDir -ChildPath '.ssh\config.win')         -Path (Join-Path -Path $HOME -ChildPath '.ssh\config')
  _Link -Value (Join-Path -Path $GitDir -ChildPath 'intelephense')            -Path (Join-Path -Path $HOME -ChildPath 'intelephense')

  $GitDir= (Join-Path -Path $HOME -ChildPath '.dotfiles')

  If (-not (Test-Path -Path $GitDir)) {
    gh repo clone dotfiles $GitDir -- --recursive
    Push-Location -Path $GitDir
    gh auth setup-git
    Pop-Location
  }

  _Link -Value (Join-Path -Path $GitDir -ChildPath '.config\git')             -Path (Join-Path -Path $HOME -ChildPath '.config\git')
  _Link -Value (Join-Path -Path $GitDir -ChildPath '.config\git\config.win')  -Path (Join-Path -Path $HOME -ChildPath '.config\git\config')
  _Link -Value (Join-Path -Path $GitDir -ChildPath '.config\pip')             -Path (Join-Path -Path $HOME -ChildPath '.config\pip')
  _Link -Value (Join-Path -Path $GitDir -ChildPath '.config\tig')             -Path (Join-Path -Path $HOME -ChildPath '.config\tig')
  _Link -Value (Join-Path -Path $GitDir -ChildPath '.textlintrc')             -Path (Join-Path -Path $HOME -ChildPath '.textlintrc')
  _Link -Value (Join-Path -Path $GitDir -ChildPath '.vim')                    -Path (Join-Path -Path $HOME -ChildPath 'vimfiles')
  _Link -Value (Join-Path -Path $GitDir -ChildPath 'windows\posh')            -Path (Join-Path -Path $HOME -ChildPath 'Documents\WindowsPowerShell')

  Copy-Item -Path (Join-Path -Path $GitDir -ChildPath 'windows\terminal\settings.json') -Destination (Join-Path -Path $HOME -ChildPath 'AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json') -Force
}

function Install-Winget-Package() {
  Param (
    [String]
    $Id
  )

  if (-not (winget list --id $Id | Select-String -Pattern $Id)) {
    winget install --interactive --id $Id
  }
}

function Install-Scoop-Package() {
  Param (
    [String]
    $Name
  )

  if (-not (scoop list | Select-String -Pattern $Name)) {
    scoop install $Name
  }
}

function Install-Cargo-Package() {
  Param (
    [String]
    $Name
  )

  if (-not (cargo install --list | Select-String -Pattern $Name)) {
    cargo install $Name
  }
}

function Install-Npm-Package() {
  Param (
    [String]
    $Name
  )

  if (-not (npm --global list $Name | Select-String -Pattern $Name)) {
    npm --global install $Name
  }
}

function Install-Pip-Package() {
  Param (
    [String]
    $Name
  )

  if (-not (pip list $Name | Select-String -Pattern $Name)) {
    pip install $Name
  }
}

Install-Winget-Package Git.Git
Install-Winget-Package GitHub.cli

Install-Dotfiles

Install-Winget-Package 7zip.7zip
Install-Winget-Package AdGuard.AdGuard
Install-Winget-Package AdGuard.AdGuardVPN
Install-Winget-Package AgileBits.1Password
Install-Winget-Package Amazon.Games
Install-Winget-Package Atlassian.Sourcetree
Install-Winget-Package Docker.DockerCLI
Install-Winget-Package Docker.DockerCompose
Install-Winget-Package Electrum.Electrum
Install-Winget-Package EpicGames.EpicGamesLauncher
Install-Winget-Package Eraser.Eraser
Install-Winget-Package GOG.Galaxy
Install-Winget-Package GeekUninstaller.GeekUninstaller
Install-Winget-Package GnuPG.Gpg4win
Install-Winget-Package Golang.Go
Install-Winget-Package HeidiSQL.HeidiSQL
Install-Winget-Package IrfanSkiljan.IrfanView
Install-Winget-Package IrfanSkiljan.IrfanView.PlugIns
Install-Winget-Package Libretro.RetroArch
Install-Winget-Package Microsoft.VisualStudioCode
Install-Winget-Package Mozilla.Thunderbird
Install-Winget-Package MusicBee.MusicBee
Install-Winget-Package OliverSchwendener.ueli
Install-Winget-Package Oracle.VirtualBox
Install-Winget-Package Postman.Postman
Install-Winget-Package Python.Python.3.12
Install-Winget-Package Rustlang.Rustup
Install-Winget-Package Starship.Starship
Install-Winget-Package Valve.Steam
Install-Winget-Package VideoLAN.VLC
Install-Winget-Package ajeetdsouza.zoxide
Install-Winget-Package junegunn.fzf
Install-Winget-Package vim.vim

if (-not (Get-Command -Name scoop -ErrorAction SilentlyContinue)) {
  irm get.scoop.sh -OutFile 'install.ps1'
  .\install.ps1 -ScoopDir 'C:\Scoop'
  Remove-Item -Path 'install.ps1' -Force
  scoop bucket add versions
}

Install-Scoop-Package php82
Install-Scoop-Package php83
Install-Scoop-Package nodejs18
Install-Scoop-Package nodejs20
Install-Scoop-Package composer

scoop reset php83
scoop reset nodejs20

Install-Cargo-Package bat
Install-Cargo-Package cargo-update
Install-Cargo-Package fd-find
Install-Cargo-Package git-delta
Install-Cargo-Package lsd
Install-Cargo-Package ripgrep
Install-Cargo-Package zoxide

Install-Npm-Package corepack

Install-Pip-Package httpie
Install-Pip-Package pip3-autoremove
Install-Pip-Package pip_search

Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck
