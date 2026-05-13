#requires -Version 7.0
[CmdletBinding()]
param([switch] $Quiet)

$ErrorActionPreference = 'Continue'
$results = @()

function Add-Result {
    param([string] $Name, [bool] $Ok, [string] $Detail = '')
    $script:results += [pscustomobject]@{
        Component = $Name
        Status    = if ($Ok) { 'OK' } else { 'MISS' }
        Detail    = $Detail
    }
}

function Test-Cmd { param([string] $name) [bool](Get-Command $name -ErrorAction SilentlyContinue) }

$expectedCommands = @(
    'chezmoi','git','gh','pwsh','oh-my-posh','mise','node','python','go','cargo',
    'fzf','rg','bat','fd','eza','zoxide','jq','yq','lazygit','delta','nvim','wezterm'
)

foreach ($c in $expectedCommands) {
    $ok = Test-Cmd $c
    $detail = if ($ok) { (Get-Command $c).Source } else { 'not found on PATH' }
    Add-Result -Name $c -Ok $ok -Detail $detail
}

$expectedFiles = @(
    "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1",
    "$HOME\Documents\PowerShell\aliases.ps1",
    "$HOME\Documents\PowerShell\functions.ps1",
    "$HOME\.gitconfig",
    "$HOME\.gitignore_global",
    "$HOME\.config\ohmyposh\theme.omp.json",
    "$HOME\.config\mise\config.toml",
    "$HOME\.config\wezterm\wezterm.lua",
    "$HOME\.config\nvim\init.lua"
)

foreach ($f in $expectedFiles) {
    $ok = Test-Path -LiteralPath $f
    Add-Result -Name (Split-Path $f -Leaf) -Ok $ok -Detail $f
}

$expectedModules = @('PSReadLine','Terminal-Icons','PSFzf','z')
foreach ($m in $expectedModules) {
    $ok = [bool](Get-Module -ListAvailable -Name $m)
    $detail = if ($ok) { 'installed' } else { 'install with Install-Module' }
    Add-Result -Name "module:$m" -Ok $ok -Detail $detail
}

if (-not $Quiet) {
    $results | Format-Table -AutoSize
    $missing = ($results | Where-Object { $_.Status -eq 'MISS' }).Count
    $color = if ($missing -eq 0) { 'Green' } else { 'Yellow' }
    Write-Host "`n$missing missing component(s)." -ForegroundColor $color
}

return $results
