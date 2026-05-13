# Shared aliases for bash and zsh. Sourced from .bashrc and .zshrc.

if command -v eza >/dev/null 2>&1; then
    alias ls='eza --group-directories-first --icons'
    alias ll='eza --long --git --group-directories-first --icons'
    alias la='eza --long --all --git --group-directories-first --icons'
    alias lt='eza --tree --level=2 --icons'
    alias lta='eza --tree --level=3 --all --icons'
else
    alias ll='ls -lh'
    alias la='ls -lah'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never'
    alias less='bat'
fi

if command -v rg >/dev/null 2>&1; then
    alias grep='rg --smart-case'
fi

if command -v fd >/dev/null 2>&1; then
    alias find='fd'
fi

if command -v lazygit >/dev/null 2>&1; then
    alias lg='lazygit'
fi

if command -v nvim >/dev/null 2>&1; then
    alias vi='nvim'
    alias vim='nvim'
fi

alias g='git'
alias gs='git status --short --branch'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gp='git push'
alias gpl='git pull --rebase --autostash'
alias gl='git log --oneline --graph --decorate --all -30'
alias glg='git log --oneline --graph --decorate --all'
alias gst='git stash'
alias gstp='git stash pop'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

mkcd() { mkdir -p "$1" && cd "$1" || return; }
take() { mkcd "$1"; }

cdr() {
    local root
    root="$(git rev-parse --show-toplevel 2>/dev/null)"
    if [ -n "$root" ]; then cd "$root" || return; else echo "Not in a git repo." >&2; return 1; fi
}

reload-shell() { exec "$SHELL" -l; }

if command -v chezmoi >/dev/null 2>&1; then
    alias dot='chezmoi'
    alias dotup='chezmoi update --apply'
    alias dotcd='chezmoi cd'
fi

if command -v just >/dev/null 2>&1; then
    alias j='just'
    alias jl='just --list'
fi

if command -v glow >/dev/null 2>&1; then
    alias md='glow -p'
fi

if command -v az >/dev/null 2>&1; then
    alias azwhoami='az account show --query "{name:user.name, subscription:name, tenant:tenantId}" -o table'
fi
