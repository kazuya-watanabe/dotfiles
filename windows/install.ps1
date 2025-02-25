winget search Git
winget install --interactive --id Git.Git
winget install --interactive --id GitHub.cli

gh auth login

$GitDir = (Join-Path -Path $HOME -ChildPath '.dotfiles')

If (-not (Test-Path -Path $GitDir)) {
  gh repo clone dotfiles $GitDir -- --recursive
}

New-Item -ItemType Directory -Force -Value (Join-Path -Path $HOME -ChildPath '.config')

New-Item -Force -ItemType HardLink -Value (Join-Path -Path $GitDir -ChildPath '.textlintrc') -Path (Join-Path -Path $HOME -ChildPath '.textlintrc')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath '.config\bat') -Path (Join-Path -Path $HOME -ChildPath 'AppData\Roaming\bat')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath '.config\fd') -Path (Join-Path -Path $HOME -ChildPath '.config\fd')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath '.config\git') -Path (Join-Path -Path $HOME -ChildPath '.config\git')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath '.config\lf') -Path (Join-Path -Path $HOME -ChildPath 'AppData\Local\lf')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath '.config\pip') -Path (Join-Path -Path $HOME -ChildPath '.config\pip')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath '.config\rg') -Path (Join-Path -Path $HOME -ChildPath '.config\rg')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath '.config\tig') -Path (Join-Path -Path $HOME -ChildPath '.config\tig')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath '.config\vim') -Path (Join-Path -Path $HOME -ChildPath 'vimfiles')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath 'windows\posh') -Path (Join-Path -Path $HOME -ChildPath 'Documents\WindowsPowerShell')

Copy-Item -Force -Path (Join-Path -Path $GitDir -ChildPath 'windows\terminal\settings.json') -Destination (Join-Path -Path $HOME -ChildPath 'AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json')

$GitDir = (Join-Path -Path $HOME -ChildPath '.conceal')

If (-not (Test-Path -Path $GitDir)) {
  gh repo clone dotfiles.conceal $GitDir -- --recursive
}

New-Item -Force -ItemType HardLink -Value (Join-Path -Path $GitDir -ChildPath '.config\openai.token') -Path (Join-Path -Path $HOME -ChildPath '.config\openai.token')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath '.config\textlint') -Path (Join-Path -Path $HOME -ChildPath '.config\textlint')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath '.ssh') -Path (Join-Path -Path $HOME -ChildPath '.ssh')
New-Item -Force -ItemType Junction -Value (Join-Path -Path $GitDir -ChildPath 'intelephense') -Path (Join-Path -Path $HOME -ChildPath 'intelephense')

winget install --interactive --id AdGuard.AdGuard
winget install --interactive --id AdGuard.AdGuardVPN
winget install --interactive --id Amazon.Games
winget install --interactive --id Atlassian.Sourcetree
winget install --interactive --id BurntSushi.ripgrep.MSVC
winget install --interactive --id Docker.DockerCLI
winget install --interactive --id Docker.DockerCompose
winget install --interactive --id EpicGames.EpicGamesLauncher
winget install --interactive --id GOG.Galaxy
winget install --interactive --id GeekUninstaller.GeekUninstaller
winget install --interactive --id GnuPG.Gpg4win
winget install --interactive --id HeidiSQL.HeidiSQL
winget install --interactive --id Libretro.RetroArch
winget install --interactive --id Mozilla.Thunderbird.ja
winget install --interactive --id OliverSchwendener.ueli
winget install --interactive --id Postman.Postman
winget install --interactive --id Python.Python.3.12
winget install --interactive --id Schniz.fnm
winget install --interactive --id Starship.Starship
winget install --interactive --id Valve.Steam
winget install --interactive --id VideoLAN.VLC
winget install --interactive --id ajeetdsouza.zoxide
winget install --interactive --id dandavison.delta
winget install --interactive --id facebook.watchman
winget install --interactive --id gokcehan.lf
winget install --interactive --id jftuga.less
winget install --interactive --id junegunn.fzf
winget install --interactive --id lsd-rs.lsd
winget install --interactive --id sharkdp.bat
winget install --interactive --id sharkdp.fd
winget install --interactive --id vim.vim
winget install --interactive --id UniversalCtags.Ctags

fnm install 22
fnm default 22

$env:PATH = ((Join-Path - Path $HOME -ChildPath 'AppData\Roaming\fnm\aliases\default') + ';' + [Environment]::GetEnvironmentVariable('PATH', 'User'))
[Environment]::SetEnvironmentVariable('PATH', $env:PATH, 'User')

npm --global install textlint
npm --global install textlint-rule-preset-ja-technical-writing
npm --global install textlint-rule-prh
npm --global install trash-cli

pip install httpie
pip install openai
pip install pip3-autoremove
pip install pipenv
pip install yt-dlp

[Environment]::SetEnvironmentVariable('RIPGREP_CONFIG_PATH', (Join-Path -Path $HOME -ChildPath '.config\rg\ripgreprc'), 'User')
