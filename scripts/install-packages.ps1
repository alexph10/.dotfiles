#requires -Version 7.0
[CmdletBinding()]
param(
    [string] $WingetManifest = (Join-Path $PSScriptRoot '..' 'packages' 'winget.json'),
    [string] $ScoopList      = (Join-Path $PSScriptRoot '..' 'packages' 'scoop.txt'),
    [switch] $SkipScoop,
    [switch] $SkipModules,
    [switch] $SkipMise
)

$ErrorActionPreference = 'Stop'
$WingetManifest = (Resolve-Path -LiteralPath $WingetManifest).Path
$ScoopList      = (Resolve-Path -LiteralPath $ScoopList).Path

function Write-Step { param([string] $msg) Write-Host "==> $msg" -ForegroundColor Cyan }
function Test-Cmd   { param([string] $name) [bool](Get-Command $name -ErrorAction SilentlyContinue) }

if (-not (Test-Cmd winget)) {
    throw 'winget is not installed. Install "App Installer" from the Microsoft Store, then re-run.'
}

Write-Step "Importing winget manifest: $WingetManifest"
winget import --import-file $WingetManifest --accept-source-agreements --accept-package-agreements --ignore-unavailable --ignore-versions

if (-not $SkipScoop) {
    if (-not (Test-Cmd scoop)) {
        Write-Step 'Installing scoop'
        Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
        Invoke-RestMethod -Uri 'https://get.scoop.sh' | Invoke-Expression
    }
    Write-Step 'Adding scoop buckets'
    scoop bucket add main       2>$null | Out-Null
    scoop bucket add extras     2>$null | Out-Null
    scoop bucket add nerd-fonts 2>$null | Out-Null

    Write-Step "Installing scoop packages from $ScoopList"
    foreach ($line in Get-Content $ScoopList) {
        $pkg = ($line -split '#', 2)[0].Trim()
        if (-not $pkg) { continue }
        Write-Host "  scoop install $pkg"
        scoop install $pkg 2>$null
    }
}

if (-not $SkipModules) {
    Write-Step 'Installing PowerShell modules'
    $modules = @('PSReadLine', 'Terminal-Icons', 'z', 'PSFzf', 'posh-git')
    foreach ($m in $modules) {
        if (-not (Get-Module -ListAvailable -Name $m)) {
            Write-Host "  Install-Module $m"
            Install-Module -Name $m -Scope CurrentUser -Force -AllowClobber -SkipPublisherCheck
        } else {
            Write-Host "  $m already installed" -ForegroundColor DarkGray
        }
    }
}

if (-not $SkipMise) {
    if (Test-Cmd mise) {
        Write-Step 'Installing language toolchains via mise'
        mise install
        mise reshim
    } else {
        Write-Warning 'mise not found on PATH yet; open a new shell and run `mise install`.'
    }
}

Write-Step 'Done. Open a new shell to pick up profile changes.'
