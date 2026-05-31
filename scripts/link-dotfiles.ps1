#requires -Version 7.0
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]   $Root    = (Split-Path -Parent $PSScriptRoot),
    [string]   $Target  = $HOME,
    [string[]] $Only,
    [string[]] $Exclude = @('bash', 'zsh', 'ghostty', 'equibop', 'flow'),
    [switch]   $Copy,
    [switch]   $Force,
    [switch]   $DryRun
)

$ErrorActionPreference = 'Stop'

if ($DryRun) { $WhatIfPreference = $true }

$Root   = (Resolve-Path -LiteralPath $Root).Path
$Target = (Resolve-Path -LiteralPath $Target).Path

$skipTop = @(
    '.git', '.husky', 'assets', 'node_modules', 'packages', 'scripts',
    'templates', 'README.md', '.gitignore', '.gitattributes',
    'bun.lock', 'index.ts', 'package.json', 'tsconfig.json'
) + $Exclude

function Test-Admin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    (New-Object Security.Principal.WindowsPrincipal($id)).IsInRole(
        [Security.Principal.WindowsBuiltinRole]::Administrator)
}

function Test-DeveloperMode {
    try {
        $key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
        if (-not (Test-Path $key)) { return $false }
        (Get-ItemProperty -Path $key -Name 'AllowDevelopmentWithoutDevLicense' -ErrorAction Stop).AllowDevelopmentWithoutDevLicense -eq 1
    } catch { return $false }
}

$canSymlink = $Copy -or (Test-Admin) -or (Test-DeveloperMode)
if (-not $Copy -and -not $canSymlink) {
    Write-Warning 'Symlink creation requires Administrator or Windows Developer Mode. Falling back to file copy (use -Copy to silence this).'
    $Copy = $true
}

function New-Backup {
    param([Parameter(Mandatory)] [string] $Path)
    if (-not (Test-Path -LiteralPath $Path)) { return }
    $stamp  = Get-Date -Format 'yyyyMMdd-HHmmss'
    $backup = "$Path.bak-$stamp"
    if ($PSCmdlet.ShouldProcess($Path, "Backup to $backup")) {
        Move-Item -LiteralPath $Path -Destination $backup -Force
    }
}

function Install-One {
    param(
        [Parameter(Mandatory)] [string] $Source,
        [Parameter(Mandatory)] [string] $Link
    )
    $linkDir = Split-Path -Parent $Link
    if ($linkDir -and -not (Test-Path -LiteralPath $linkDir)) {
        if ($PSCmdlet.ShouldProcess($linkDir, 'mkdir -p')) {
            New-Item -ItemType Directory -Path $linkDir -Force | Out-Null
        }
    }

    if (Test-Path -LiteralPath $Link) {
        $existing = Get-Item -LiteralPath $Link -Force
        if ($existing.LinkType -and $existing.Target -and ($existing.Target -contains $Source)) {
            Write-Host "  = $Link" -ForegroundColor DarkGray
            return
        }
        if (-not $Force) {
            Write-Warning "  ! $Link already exists (use -Force to back up & replace)"
            return
        }
        New-Backup -Path $Link
    }

    if ($Copy) {
        if ($PSCmdlet.ShouldProcess($Link, "copy from $Source")) {
            Copy-Item -LiteralPath $Source -Destination $Link -Force
            Write-Host "  + $Link  (copy)" -ForegroundColor Green
        }
    } else {
        if ($PSCmdlet.ShouldProcess($Link, "symlink to $Source")) {
            New-Item -ItemType SymbolicLink -Path $Link -Value $Source -Force | Out-Null
            Write-Host "  + $Link  -> $Source" -ForegroundColor Green
        }
    }
}

$topDirs = Get-ChildItem -LiteralPath $Root -Directory -Force |
    Where-Object { $skipTop -notcontains $_.Name } |
    Where-Object { -not $Only -or $Only -contains $_.Name }

foreach ($dir in $topDirs) {
    Write-Host "==> $($dir.Name)" -ForegroundColor Cyan
    $files = Get-ChildItem -LiteralPath $dir.FullName -File -Recurse -Force
    foreach ($file in $files) {
        $rel  = $file.FullName.Substring($dir.FullName.Length + 1)
        $link = Join-Path $Target $rel
        Install-One -Source $file.FullName -Link $link
    }
}

Write-Host "`nDone. Open a new shell to pick up changes." -ForegroundColor Cyan
if ($DryRun) { Write-Host 'Dry run only. Re-run without -DryRun to apply.' -ForegroundColor Yellow }
