# Dotfiles
$ConcDir = (Join-Path -Path $HOME -ChildPath 'Documents\Conceal')

If (-not (Test-Path -Path $ConcDir)) {
  git clone --recursive https://github.com/kazuya-watanabe/dotfiles.conceal.git "$ConcDir"

  Push-Location -Path $ConcDir
  git remote set-url origin git@github.com:kazuya-watanabe/dotfiles.conceal.git
  .\install-dotfiles.ps1
  Pop-Location
}

$DotDir = (Join-Path -Path $HOME -ChildPath 'Documents\Dotfiles')

If (-not (Test-Path -Path $DotDir)) {
  git clone --recursive git@github.com:kazuya-watanabe/dotfiles.git "$DotDir"

  Push-Location -Path $DotDir
  .\install-dotfiles.ps1
  Pop-Location
}

# Windows Terminal
$DestFile = (Join-Path -Path "$HOME" -ChildPath 'AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json')
$SourceFile = (Join-Path -Path $DotDir -ChildPath 'windows\terminal\settings.json')
Copy-Item -Force -Path $SourceFile -Destination $DestFile

# Apps
winget install --interactive --id 7zip.7zip
winget install --interactive --id Acronis.CyberProtectHomeOffice
winget install --interactive --id AdGuard.AdGuard
winget install --interactive --id AdGuard.AdGuardVPN
winget install --interactive --id AgileBits.1Password
winget install --interactive --id Amazon.Games
winget install --interactive --id Atlassian.Sourcetree
winget install --interactive --id AutoHotkey.AutoHotkey
winget install --interactive --id EpicGames.EpicGamesLauncher
winget install --interactive --id GOG.Galaxy
winget install --interactive --id GeekUnintaller.GeekUninstaller
winget install --interactive --id Git.Git
winget install --interactive --id GnuPG.Gpg4win
winget install --interactive --id HeidiSQL.HeidiSQL
winget install --interactive --id IrfanSkiljan.IrfanView
winget install --interactive --id IrfanSkiljan.IrfanView.PlugIns
winget install --interactive --id Libretro.RetroArch
winget install --interactive --id Microsoft.Office
winget install --interactive --id Microsoft.VisualStudioCode
winget install --interactive --id Mozilla.Thunderbird
winget install --interactive --id MusicBee.MusicBee
winget install --interactive --id OliverSchwendener.ueli
winget install --interactive --id OpenJS.NodeJS.LTS
winget install --interactive --id Oracle.VirtualBox
winget install --interactive --id PuTTY.PuTTY
winget install --interactive --id Python.Python.3.12
winget install --interactive --id RealVNC.VNCViewer
winget install --interactive --id Valve.Steam
winget install --interactive --id VideoLAN.VLC
winget install --interactive --id WinMerge.WinMerge
winget install --interactive --id WinSCP.WinSCP
winget install --interactive --id vim.vim
winget install --interactive --id voidtools.Everything
winget install --interactive --id voidtools.Everything.Cli
winget install --interactive --id Docker.DockerCLI
winget install --interactive --id Docker.DockerCompose
