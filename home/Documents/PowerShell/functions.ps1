function Get-PublicIP {
    (Invoke-RestMethod -Uri 'https://api.ipify.org?format=json').ip
}

function Get-Weather {
    param([string] $location = '')
    Invoke-RestMethod -Uri "https://wttr.in/$location`?format=3"
}

function New-Password {
    param([int] $Length = 24)
    -join ((33..126) | Get-Random -Count $Length | ForEach-Object { [char]$_ })
}

function Resolve-PathAbsolute {
    param([Parameter(Mandatory)] [string] $Path)
    (Resolve-Path -LiteralPath $Path -ErrorAction Stop).Path
}

function Get-DirSize {
    param([string] $Path = '.')
    $bytes = (Get-ChildItem -LiteralPath $Path -Recurse -Force -ErrorAction SilentlyContinue |
              Measure-Object -Property Length -Sum).Sum
    '{0:N2} MB' -f ($bytes / 1MB)
}

function Find-File {
    param([Parameter(Mandatory)] [string] $Pattern, [string] $Root = '.')
    if (Get-Command fd -ErrorAction SilentlyContinue) {
        fd --hidden --follow $Pattern $Root
    } else {
        Get-ChildItem -LiteralPath $Root -Recurse -Force -Filter $Pattern -ErrorAction SilentlyContinue
    }
}

function Find-InFiles {
    param([Parameter(Mandatory)] [string] $Pattern, [string] $Root = '.')
    if (Get-Command rg -ErrorAction SilentlyContinue) {
        rg --smart-case --color=always $Pattern $Root
    } else {
        Select-String -Path (Join-Path $Root '*') -Pattern $Pattern -SimpleMatch
    }
}

function Repo-Root {
    git rev-parse --show-toplevel 2>$null
}

function cdr {
    $root = Repo-Root
    if ($root) { Set-Location $root } else { Write-Warning 'Not in a git repo.' }
}

function gclone {
    param([Parameter(Mandatory)] [string] $Repo, [string] $Dir)
    if (-not $Dir) {
        $Dir = ($Repo -replace '\.git$','') -split '[/:]' | Select-Object -Last 1
    }
    git clone $Repo $Dir
    if (Test-Path $Dir) { Set-Location $Dir }
}

function Update-Dotfiles {
    if (Get-Command chezmoi -ErrorAction SilentlyContinue) {
        chezmoi update --apply
    } else {
        Write-Warning 'chezmoi not installed.'
    }
}

function Edit-Dotfiles {
    if (Get-Command chezmoi -ErrorAction SilentlyContinue) {
        chezmoi cd
    } else {
        Write-Warning 'chezmoi not installed.'
    }
}

function Format-Json {
    param([Parameter(ValueFromPipeline)] [string] $Json)
    process { $Json | ConvertFrom-Json | ConvertTo-Json -Depth 64 }
}
