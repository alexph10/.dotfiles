#requires -Version 7.0

$ErrorActionPreference = 'Continue'
$ProgressPreference    = 'SilentlyContinue'

$env:DOTFILES_PROFILE_DIR = Split-Path -Parent $PROFILE

if ($env:TERM_PROGRAM -eq 'vscode' -or $env:CURSOR_TRACE_ID) {
    $env:EDITOR = 'code --wait'
} elseif (Get-Command nvim -ErrorAction SilentlyContinue) {
    $env:EDITOR = 'nvim'
} else {
    $env:EDITOR = 'notepad'
}

if (Get-Module -ListAvailable -Name PSReadLine) {
    Import-Module PSReadLine

    Set-PSReadLineOption -EditMode Emacs
    Set-PSReadLineOption -BellStyle None
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineOption -HistoryNoDuplicates
    Set-PSReadLineOption -MaximumHistoryCount 50000
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    Set-PSReadLineOption -PredictionViewStyle ListView

    Set-PSReadLineKeyHandler -Key UpArrow   -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineKeyHandler -Key Tab       -Function MenuComplete
    Set-PSReadLineKeyHandler -Key Ctrl+d    -Function DeleteCharOrExit
    Set-PSReadLineKeyHandler -Key Ctrl+w    -Function BackwardKillWord
    Set-PSReadLineKeyHandler -Key Alt+.     -Function YankLastArg
}

foreach ($mod in @('Terminal-Icons', 'z')) {
    if (Get-Module -ListAvailable -Name $mod) {
        Import-Module $mod -ErrorAction SilentlyContinue
    }
}

if (Get-Module -ListAvailable -Name PSFzf) {
    Import-Module PSFzf -ErrorAction SilentlyContinue
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
    $env:FZF_DEFAULT_OPTS = '--height 40% --reverse --border --ansi'
    if (Get-Command fd -ErrorAction SilentlyContinue) {
        $env:FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
        $env:FZF_CTRL_T_COMMAND  = $env:FZF_DEFAULT_COMMAND
    }
}

if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    $themePath = Join-Path $HOME '.config/ohmyposh/theme.omp.json'
    if (Test-Path $themePath) {
        oh-my-posh init pwsh --config $themePath | Invoke-Expression
    } else {
        oh-my-posh init pwsh | Invoke-Expression
    }
}

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })
}

if (Get-Command mise -ErrorAction SilentlyContinue) {
    mise activate pwsh | Out-String | Invoke-Expression
}

if (Get-Command gh -ErrorAction SilentlyContinue) {
    gh completion -s powershell | Out-String | Invoke-Expression
}

foreach ($helper in @('aliases.ps1', 'functions.ps1')) {
    $p = Join-Path $env:DOTFILES_PROFILE_DIR $helper
    if (Test-Path $p) { . $p }
}

$localProfile = Join-Path $env:DOTFILES_PROFILE_DIR 'profile.local.ps1'
if (Test-Path $localProfile) { . $localProfile }
