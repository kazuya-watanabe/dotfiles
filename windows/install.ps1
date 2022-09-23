function Test-Executable() {
  Param (
    [String]
    $Name
  )

  Process {
    Get-Command -Name $Name >$Null 2>&1

    Return $?
  }
}

function Set-EnvVar() {
  Param (
    [String]
    $Name,

    [String]
    $Value,

    [String]
    $Scope = 'User'
  )

  Process {
    Set-Item -Path Env:\$Name -Value $Value

    [System.Environment]::SetEnvironmentVariable($Name, $Value, $Scope)
  }
}

function Add-Path() {
  Param (
    [String]
    $Path,

    [String]
    $Scope = 'User'
  )

  Process {
    $Pathes = [System.Environment]::GetEnvironmentVariable('Path', $Scope)

    if (-Not ($Pathes.Contains($Path))) {
      Set-EnvVar -Name 'Path' -Value "$Path;$Pathes" -Scope $Scope
    }
  }
}

function Add-ScoopBucket() {
  Param (
    [String]
    $Name
  )

  Process {
    If (-Not (scoop bucket list).Name.Contains($Name)) {
      scoop bucket add "$Name"
    }
  }
}

function Add-ScoopApp() {
  Param (
    [String]
    $Name
  )

  Process {
    if (-Not (scoop info "$Name" | Select-String -Pattern 'Installed')) {
      scoop install "$Name"
    }
  }
}

function Add-PythonModule() {
  Param (
    [String]
    $Name,

    [String]
    $BinDir,

    [String]
    $ExeFile = $Null,

    [String]
    $VenvsDir = (Join-Path -Path $HOME -ChildPath '.venvs')
  )

  Process {
    New-Item -Force -ItemType Directory -Path $VenvsDir >$Null 2>&1

    $VenvDir = (Join-Path -Path $VenvsDir -ChildPath $Name)
    $PipPath = (Join-Path -Path $VenvDir -ChildPath 'Scripts\pip3.exe')

    If (-Not (Test-Path -Path $PipPath)) {
      python3 -m venv $VenvDir

      Start-Process -FilePath $PipPath -ArgumentList 'install',$Name -Wait -WindowStyle Hidden

      If ($ExeFile -Ne $Null) {
        New-Item -Force -ItemType HardLink -Path (Join-Path -Path $BinDir -ChildPath $ExeFile) -Value (Join-Path -Path $VenvDir -ChildPath $ExeFile) >$Null 2>&1
      }
    }
  }
}

If (-Not (Test-Executable -Name 'scoop')) {
  Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

Add-ScoopApp -Name 'git'

git config --system --unset credential.helper
git config --system --unset credential.helperselector.selected
git config --system core.autocrlf false
git config --global core.autocrlf false

Add-ScoopBucket -Name 'extras'
Add-ScoopBucket -Name 'java'
Add-ScoopBucket -Name 'versions'

# gui apps
Add-ScoopApp -Name '7zip'
Add-ScoopApp -Name 'autohotkey'
Add-ScoopApp -Name 'vim-nightly'

# console utils
Add-ScoopApp -Name 'bat'
Add-ScoopApp -Name 'coreutils'
Add-ScoopApp -Name 'fd'
Add-ScoopApp -Name 'fzf'
Add-ScoopApp -Name 'less'
Add-ScoopApp -Name 'starship'
Add-ScoopApp -Name 'zoxide'

# compression/archive
Add-ScoopApp -Name 'bzip2'
Add-ScoopApp -Name 'gzip'
Add-ScoopApp -Name 'tar'
Add-ScoopApp -Name 'unzip'
Add-ScoopApp -Name 'xz'
Add-ScoopApp -Name 'zip'

# network
Add-ScoopApp -Name 'curl'
Add-ScoopApp -Name 'wget'

# text utils
Add-ScoopApp -Name 'diffutils'
Add-ScoopApp -Name 'gawk'
Add-ScoopApp -Name 'jq'
Add-ScoopApp -Name 'pandoc'
Add-ScoopApp -Name 'poppler'
Add-ScoopApp -Name 'ripgrep'
Add-ScoopApp -Name 'sed'
Add-ScoopApp -Name 'universal-ctags'

# program language
Add-ScoopApp -Name 'dotnet-sdk'
Add-ScoopApp -Name 'go'
Add-ScoopApp -Name 'nodejs-lts'
Add-ScoopApp -Name 'openjdk'
Add-ScoopApp -Name 'perl'
Add-ScoopApp -Name 'php'
Add-ScoopApp -Name 'python'

# development tools
Add-ScoopApp -Name 'cmake'

# vim
Set-EnvVar -Name 'EDITOR' -Value 'vim'
Set-EnvVar -Name 'VISUAL' -Value 'vim'

# fzf
Set-EnvVar -Name 'FZF_DEFAULT_COMMAND' -Value 'powershell.exe -NoLogo -NoProfile -Noninteractive -Command "Get-ChildItem -File -Recurse -Name"'
Set-EnvVar -Name 'FZF_DEFAULT_OPTS' -Value '--layout=reverse --info=inline --preview-window=hidden'

# less
Set-EnvVar -Name 'PAGER' -Value 'less'
Set-EnvVar -Name 'LESS' -Value '-iJMRX'

# node
Add-Path -Path (Join-Path -Path $HOME -ChildPath .npm)

# python
Set-EnvVar -Name 'PYTHONHOME' -Value (scoop prefix python)
Set-EnvVar -Name 'PYTHONUSERBASE' -Value (Join-Path -Path $HOME -ChildPath '.local')

$BinDir = (Join-Path -Path (Split-Path -Path (python3 -m site --user-site) -Parent) -ChildPath 'Scripts')

New-Item -Force -ItemType Directory -Path $BinDir >$Null 2>&1

Add-Path -Path $BinDir

Add-PythonModule -Name 'pip_search' -BinDir $BinDir -ExeFile 'pip_search.exe'
Add-PythonModule -Name 'yt-dlp' -BinDir $BinDir -ExeFile 'yt-dlp.exe'

# xdg
Set-EnvVar -Name 'XDG_CONFIG_HOME' -Value (Join-Path -Path $HOME -ChildPath .config)
Set-EnvVar -Name 'XDG_CACHE_HOME' -Value (Join-Path -Path $HOME -ChildPath .cache)
Set-EnvVar -Name 'XDG_DATA_HOME' -Value (Join-Path -Path $HOME -ChildPath '.local\share')
Set-EnvVar -Name 'XDG_STATE_HOME' -Value (Join-Path -Path $HOME -ChildPath '.local\state')

# dotfiles
$GitDir = (Join-Path -Path $HOME -ChildPath '.conceal')

If (-Not (Test-Path -Path $GitDir)) {
  git clone --recursive https://github.com/kazuya-watanabe/dotfiles.conceal.git "$GitDir"

  Push-Location -Path $GitDir
  git remote set-url origin git@github.com:kazuya-watanabe/dotfiles.conceal.git
  .\install-dotfiles.ps1
  Pop-Location
}

$GitDir = (Join-Path -Path $HOME -ChildPath '.dotfiles')

If (-Not (Test-Path -Path $GitDir)) {
  git clone --recursive git@github.com:kazuya-watanabe/dotfiles.git "$GitDir"

  Push-Location -Path $GitDir
  .\install-dotfiles.ps1
  Pop-Location
}

# windows terminal
$OriginFile = (Join-Path -Path "$HOME" -ChildPath 'AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json')
$PatchFile = (Join-Path -Path $GitDir -ChildPath 'windows\terminal\settings.json')
$TempFile = 'tmp.json'

jq -as '.[0] * .[1]' "$OriginFile" "$PatchFile" | Out-File -Encoding utf8 -FilePath $TempFile

Copy-Item -Force -Path $TempFile -Destination $OriginFile
Remove-Item -Force -Path $TempFile
