$GitDir = (Join-Path -Path $HOME -ChildPath '.dotfiles')

If (-not (Test-Path -Path $GitDir)) {
  gh repo clone dotfiles $GitDir -- --recursive
}

New-Item -ItemType Directory -Force -Value (Join-Path -Path $HOME -ChildPath '.config')

New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.textlintrc') -Path (Join-Path -Path $HOME -ChildPath '.textlintrc')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.config\bat') -Path (Join-Path -Path $HOME -ChildPath 'AppData\Roaming\bat')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.config\fd') -Path (Join-Path -Path $HOME -ChildPath '.config\fd')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.config\git') -Path (Join-Path -Path $HOME -ChildPath '.config\git')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.config\lf') -Path (Join-Path -Path $HOME -ChildPath 'AppData\Local\lf')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.config\pip') -Path (Join-Path -Path $HOME -ChildPath '.config\pip')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.config\rg') -Path (Join-Path -Path $HOME -ChildPath '.config\rg')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.config\tig') -Path (Join-Path -Path $HOME -ChildPath '.config\tig')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.config\vim') -Path (Join-Path -Path $HOME -ChildPath 'vimfiles')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath 'windows\posh') -Path (Join-Path -Path $HOME -ChildPath 'Documents\WindowsPowerShell')

Copy-Item -Force -Path (Join-Path -Path $GitDir -ChildPath 'windows\terminal\settings.json') -Destination (Join-Path -Path $HOME -ChildPath 'AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json')

$GitDir = (Join-Path -Path $HOME -ChildPath '.conceal')

If (-not (Test-Path -Path $GitDir)) {
  gh repo clone dotfiles.conceal $GitDir -- --recursive
}

New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.config\openai.token') -Path (Join-Path -Path $HOME -ChildPath '.config\openai.token')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.config\textlint') -Path (Join-Path -Path $HOME -ChildPath '.config\textlint')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath '.ssh') -Path (Join-Path -Path $HOME -ChildPath '.ssh')
New-Item -Force -ItemType SymbolicLink -Value (Join-Path -Path $GitDir -ChildPath 'intelephense') -Path (Join-Path -Path $HOME -ChildPath 'intelephense')
