if (Test-Path Alias:cat) { Remove-Item Alias:cat -Force }
if (Test-Path Alias:ls)  { Remove-Item Alias:ls  -Force -ErrorAction SilentlyContinue }

function Invoke-Bat { param([Parameter(ValueFromRemainingArguments)] $args) bat @args }
function Invoke-Eza { param([Parameter(ValueFromRemainingArguments)] $args) eza --group-directories-first --icons @args }
function Invoke-Rg  { param([Parameter(ValueFromRemainingArguments)] $args) rg --smart-case @args }

if (Get-Command bat -ErrorAction SilentlyContinue) {
    Set-Alias -Name cat   -Value Invoke-Bat -Option AllScope
    Set-Alias -Name less  -Value Invoke-Bat -Option AllScope
}

if (Get-Command eza -ErrorAction SilentlyContinue) {
    Set-Alias -Name ls -Value Invoke-Eza -Option AllScope
    function ll  { eza --long --git --group-directories-first --icons @args }
    function la  { eza --long --all --git --group-directories-first --icons @args }
    function lt  { eza --tree --level=2 --icons @args }
    function lta { eza --tree --level=3 --all --icons @args }
} else {
    function ll { Get-ChildItem -Force @args }
    function la { Get-ChildItem -Force -Hidden @args }
}

if (Get-Command rg -ErrorAction SilentlyContinue) {
    Set-Alias -Name grep -Value Invoke-Rg -Option AllScope
}

if (Get-Command lazygit -ErrorAction SilentlyContinue) { Set-Alias -Name lg -Value lazygit }
if (Get-Command nvim    -ErrorAction SilentlyContinue) { Set-Alias -Name vi -Value nvim; Set-Alias -Name vim -Value nvim -Force }

function g    { git @args }
function gs   { git status --short --branch @args }
function gd   { git diff @args }
function gds  { git diff --staged @args }
function ga   { git add @args }
function gaa  { git add --all @args }
function gc   { git commit -v @args }
function gca  { git commit -v --amend @args }
function gco  { git checkout @args }
function gcb  { git checkout -b @args }
function gp   { git push @args }
function gpl  { git pull --rebase --autostash @args }
function gl   { git log --oneline --graph --decorate --all -30 @args }
function glg  { git log --oneline --graph --decorate --all @args }
function gst  { git stash @args }
function gstp { git stash pop @args }

function which { param([Parameter(Mandatory)] [string] $name) (Get-Command $name -ErrorAction SilentlyContinue).Source }
function touch { param([Parameter(Mandatory, ValueFromRemainingArguments)] [string[]] $paths)
    foreach ($p in $paths) {
        if (Test-Path $p) { (Get-Item $p).LastWriteTime = Get-Date }
        else { New-Item -ItemType File -Path $p -Force | Out-Null }
    }
}
function mkcd { param([Parameter(Mandatory)] [string] $path) New-Item -ItemType Directory -Path $path -Force | Out-Null; Set-Location $path }
function take { param([Parameter(Mandatory)] [string] $path) mkcd $path }

function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }

if (Get-Command rg -ErrorAction SilentlyContinue) {
    function rgf { rg --files | rg @args }
    function rgi { rg --no-heading --color=always --smart-case @args }
}

function reload-profile { . $PROFILE }
function edit-profile    { & $env:EDITOR (Split-Path -Parent $PROFILE) }

if (Get-Command tldr -ErrorAction SilentlyContinue) {
    function help-cmd { param([Parameter(Mandatory)] [string] $name) tldr $name }
}
if (Get-Command just -ErrorAction SilentlyContinue) {
    Set-Alias -Name j -Value just
    function jl { just --list }
}
if (Get-Command glow -ErrorAction SilentlyContinue) {
    function md { param([Parameter(Mandatory)] [string] $path) glow -p $path }
}
if (Get-Command az -ErrorAction SilentlyContinue) {
    function azwhoami { az account show --query '{name:user.name, subscription:name, tenant:tenantId}' -o table }
}
