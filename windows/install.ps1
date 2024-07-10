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

    if (-not ($Pathes.Contains($Path))) {
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

    If (-not (scoop bucket list).Name.Contains($Name)) {
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

    if (((scoop list).Name -eq $Null) -or (-not (scoop list).Name.Contains("$Name"))) {
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

function Add-NodeModule() {
  Param (
    [String]
    $Name
  )

  Process {
    Write-Host -Object "node: $Name"

    If (-not (npm list -g --depth=0 | Select-String -Pattern $Name)) {
      npm install -g $Name
    }
  }
}

If (-not (Get-Command -Name 'scoop')) {
  Write-Host -Object 'scoop'

  Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

Add-ScoopApp -Name 'git'

git config --system --unset credential.helper
git config --system --unset credential.helperselector.selected
git config --system core.autocrlf false
git config --global core.autocrlf false

Add-ScoopBucket -Name 'extras'
Add-ScoopBucket -Name 'versions'

# gui apps
Add-ScoopApp -Name '7zip'
Add-ScoopApp -Name 'autohotkey'
Add-ScoopApp -Name 'ueli'
Add-ScoopApp -Name 'vim'

# console utils
Add-ScoopApp -Name 'coreutils'
Add-ScoopApp -Name 'everything-cli'
Add-ScoopApp -Name 'fd'
Add-ScoopApp -Name 'fzf'
Add-ScoopApp -Name 'less'
Add-ScoopApp -Name 'lf'
Add-ScoopApp -Name 'lsd'
Add-ScoopApp -Name 'starship'
Add-ScoopApp -Name 'zoxide'

# text utils
Add-ScoopApp -Name 'bat'
Add-ScoopApp -Name 'delta'
Add-ScoopApp -Name 'gawk'
Add-ScoopApp -Name 'jq'
Add-ScoopApp -Name 'pandoc'
Add-ScoopApp -Name 'poppler'
Add-ScoopApp -Name 'ripgrep'
Add-ScoopApp -Name 'sed'
Add-ScoopApp -Name 'universal-ctags'

# network utils

# database utils
Add-ScoopApp -Name 'mysql'
Add-ScoopApp -Name 'sqlite'

# program language
Add-ScoopApp -Name 'nodejs-lts'
Add-ScoopApp -Name 'python'
Add-ScoopApp -Name 'php'
Add-ScoopApp -Name 'composer'

# development tools
Add-ScoopApp -Name 'cmake'
Add-ScoopApp -Name 'tig'

# dotfiles
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

# fzf
Set-EnvVar -Name 'FZF_DEFAULT_COMMAND' -Value 'fd --hidden --follow --type f --exclude .git/'

# nodejs
Add-Path -Path (Split-Path -Path (npm root -g) -Parent)

Add-NodeModule -Name 'corepack'

# python
Add-Path -Path (Join-Path -Path $HOME -ChildPath '.local\Scripts')

Add-PythonModule -Name 'pip3-autoremove'
Add-PythonModule -Name 'pip_search'

# ripgrep
Set-EnvVar -Name 'RIPGREP_CONFIG_PATH' -Value (Join-Path -Path $DotDir -ChildPath ".config\rg\ripgreprc")

# windows terminal
$OriginFile = (Join-Path -Path "$HOME" -ChildPath 'AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json')
$PatchFile = (Join-Path -Path $DotDir -ChildPath 'windows\terminal\settings.json')
$TempFile = 'tmp.json'

if (Test-Path -Path $OriginFile)
{
  jq -as '.[0] * .[1]' "$OriginFile" "$PatchFile" | Out-File -Encoding utf8 -FilePath $TempFile
  Copy-Item -Force -Path $TempFile -Destination $OriginFile
  Remove-Item -Force -Path $TempFile
}
