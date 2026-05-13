#requires -Version 7.0
[CmdletBinding(SupportsShouldProcess)]
param(
    [switch] $Apply
)

# Opt-in registry tweaks. Run with -Apply (no -WhatIf) to actually modify.
# Each tweak is documented; comment out anything you don't want.

$ErrorActionPreference = 'Stop'

function Set-Reg {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)] [string] $Path,
        [Parameter(Mandatory)] [string] $Name,
        [Parameter(Mandatory)] $Value,
        [string] $Type = 'DWord',
        [string] $Description = ''
    )
    if (-not (Test-Path $Path)) {
        if ($PSCmdlet.ShouldProcess($Path, 'Create registry key')) {
            New-Item -Path $Path -Force | Out-Null
        }
    }
    if ($PSCmdlet.ShouldProcess("$Path\$Name = $Value", $Description)) {
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force | Out-Null
        Write-Host "OK  $Description" -ForegroundColor Green
    }
}

$WhatIfPreference = -not $Apply

Set-Reg -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' `
        -Name 'HideFileExt' -Value 0 -Description 'Show file extensions'

Set-Reg -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' `
        -Name 'Hidden' -Value 1 -Description 'Show hidden files'

Set-Reg -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' `
        -Name 'LaunchTo' -Value 1 -Description 'File Explorer opens to This PC'

Set-Reg -Path 'HKCU:\Control Panel\Mouse' `
        -Name 'MouseSpeed' -Value 0 -Type String -Description 'Disable mouse acceleration (MouseSpeed)'
Set-Reg -Path 'HKCU:\Control Panel\Mouse' `
        -Name 'MouseThreshold1' -Value 0 -Type String -Description 'Disable mouse acceleration (Threshold1)'
Set-Reg -Path 'HKCU:\Control Panel\Mouse' `
        -Name 'MouseThreshold2' -Value 0 -Type String -Description 'Disable mouse acceleration (Threshold2)'

Set-Reg -Path 'HKCU:\Control Panel\Keyboard' `
        -Name 'KeyboardDelay' -Value 0 -Type String -Description 'Shortest keyboard repeat delay'

Set-Reg -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' `
        -Name 'LongPathsEnabled' -Value 1 -Description 'Enable long path support (requires admin)'

Set-Reg -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' `
        -Name 'EnableWebContentEvaluation' -Value 0 -Description 'Disable SmartScreen for store apps'

Set-Reg -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' `
        -Name 'ToastEnabled' -Value 1 -Description 'Keep toast notifications enabled'

if (-not $Apply) {
    Write-Host "`nDry run only. Pass -Apply to commit these changes." -ForegroundColor Yellow
}
