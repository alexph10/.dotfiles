#requires -Version 5.1
[CmdletBinding()]
param(
    [string] $Repo   = 'https://github.com/alexph10/.dotfiles.git',
    [string] $Branch = 'main',
    [switch] $NoApply
)

$ErrorActionPreference = 'Stop'
$ProgressPreference    = 'SilentlyContinue'

function Write-Step { param([string] $msg) Write-Host "==> $msg" -ForegroundColor Cyan }
function Test-Cmd   { param([string] $name) [bool](Get-Command $name -ErrorAction SilentlyContinue) }

if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Warning 'PowerShell 7+ is recommended. Continuing with Windows PowerShell.'
}

if (-not (Test-Cmd winget)) {
    throw 'winget is unavailable. Install "App Installer" from the Microsoft Store first.'
}

if (-not (Test-Cmd git)) {
    Write-Step 'Installing git'
    winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
    $env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')
}

if (-not (Test-Cmd chezmoi)) {
    Write-Step 'Installing chezmoi'
    winget install --id twpayne.chezmoi -e --accept-source-agreements --accept-package-agreements
    $env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')
}

if (-not (Test-Cmd chezmoi)) {
    throw 'chezmoi installation failed or not on PATH. Open a new shell and re-run.'
}

$chezmoiArgs = @('init', '--branch', $Branch)
if (-not $NoApply) { $chezmoiArgs += '--apply' }
$chezmoiArgs += $Repo

Write-Step "Running: chezmoi $($chezmoiArgs -join ' ')"
& chezmoi @chezmoiArgs

Write-Host ''
Write-Host 'Dotfiles bootstrapped.' -ForegroundColor Green
Write-Host 'Next steps:' -ForegroundColor Green
Write-Host '  1. Open a new PowerShell session to pick up the profile.' -ForegroundColor Green
Write-Host '  2. Run ".\scripts\install-packages.ps1" from the chezmoi source (chezmoi cd) to install tools.' -ForegroundColor Green
Write-Host '  3. (Optional) Run ".\scripts\windows-tweaks.ps1 -Apply" for registry tweaks.' -ForegroundColor Green
