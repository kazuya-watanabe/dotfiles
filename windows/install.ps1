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
    Write-Host -Object "env: $Name"

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
    Write-Host -Object "bucket: $Name"

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
    Write-Host -Object "app: $Name"

    if (-Not (scoop list).Name.Contains("$Name")) {
      scoop install "$Name"
    }
  }
}

function Add-PythonModule() {
  Param (
    [String]
    $Name
  )

  Process {
    Write-Host -Object "python: $Name"

    If (pip3 show "$Name" 2>&1 | Select-String -Pattern 'not found') {
      pip3 install $Name
    }
  }
}

If (-Not (Get-Command -Name 'scoop')) {
  Write-Host -Object 'scoop'

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
Add-ScoopApp -Name 'ueli'
Add-ScoopApp -Name 'vim-nightly'

# console utils
Add-ScoopApp -Name 'bat'
Add-ScoopApp -Name 'coreutils'
Add-ScoopApp -Name 'everything-cli'
Add-ScoopApp -Name 'fd'
Add-ScoopApp -Name 'fzf'
Add-ScoopApp -Name 'less'
Add-ScoopApp -Name 'lsd'
Add-ScoopApp -Name 'navi'
Add-ScoopApp -Name 'starship'
Add-ScoopApp -Name 'tldr'
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
Add-ScoopApp -Name 'delta'
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
Add-ScoopApp -Name 'composer'
Add-ScoopApp -Name 'mysql'
Add-ScoopApp -Name 'postgresql'
Add-ScoopApp -Name 'redis'
Add-ScoopApp -Name 'sqlite'

# media
Add-ScoopApp -Name 'ffmpeg-shared'
Add-ScoopApp -Name 'imagemagick'

# fzf
Set-EnvVar -Name 'FZF_DEFAULT_COMMAND' -Value 'fd --hidden --follow --type f --exclude .git/'

# node
Add-Path -Path (Split-Path -Path (npm root -g) -Parent)

# python
Set-EnvVar -Name 'PYTHONHOME' -Value (scoop prefix python)

Add-PythonModule -Name 'pip3-autoremove'
Add-PythonModule -Name 'pip_search'
Add-PythonModule -Name 'httpie'

# dotfiles
$GitDir = (Join-Path -Path $HOME -ChildPath 'Documents\Conceal')

If (-Not (Test-Path -Path $GitDir)) {
  git clone --recursive https://github.com/kazuya-watanabe/dotfiles.conceal.git "$GitDir"

  Push-Location -Path $GitDir
  git remote set-url origin git@github.com:kazuya-watanabe/dotfiles.conceal.git
  .\install-dotfiles.ps1
  Pop-Location
}

$GitDir = (Join-Path -Path $HOME -ChildPath 'Documents\Dotfiles')

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

if (Test-Path -Path $OriginFile)
{
  jq -as '.[0] * .[1]' "$OriginFile" "$PatchFile" | Out-File -Encoding utf8 -FilePath $TempFile
  Copy-Item -Force -Path $TempFile -Destination $OriginFile
  Remove-Item -Force -Path $TempFile
}
