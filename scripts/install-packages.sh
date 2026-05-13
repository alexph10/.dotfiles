#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$(cd "$DIR/../packages" && pwd)"

step() { printf '\033[1;36m==> %s\033[0m\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

OS="$(uname -s)"
case "$OS" in
    Darwin)
        if ! have brew; then
            step 'Installing Homebrew'
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
        fi
        step 'Installing brew packages'
        pkgs=$(grep -vE '^\s*#|^\s*$' "$PKG_DIR/brew.txt" | tr '\n' ' ')
        # shellcheck disable=SC2086
        brew install $pkgs || true
        step 'Installing JetBrainsMono Nerd Font'
        brew install --cask font-jetbrains-mono-nerd-font || true
        ;;
    Linux)
        if have apt-get; then
            step 'Updating apt index'
            sudo apt-get update -y
            step 'Installing apt packages'
            pkgs=$(grep -vE '^\s*#|^\s*$' "$PKG_DIR/apt.txt" | tr '\n' ' ')
            # shellcheck disable=SC2086
            sudo apt-get install -y $pkgs
        elif have pacman; then
            step 'Installing pacman packages (best effort)'
            sudo pacman -Syu --noconfirm git github-cli git-lfs ripgrep bat fd jq fzf zsh tmux htop btop neovim shellcheck shfmt eza zoxide lazygit
        elif have dnf; then
            step 'Installing dnf packages (best effort)'
            sudo dnf install -y git gh git-lfs ripgrep bat fd-find jq fzf zsh tmux htop neovim ShellCheck
        else
            echo 'Unsupported Linux distro; install packages manually.' >&2
        fi

        if ! have mise; then
            step 'Installing mise'
            curl -fsSL https://mise.run | sh
            export PATH="$HOME/.local/bin:$PATH"
        fi
        if ! have oh-my-posh; then
            step 'Installing oh-my-posh'
            curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "$HOME/.local/bin"
        fi
        if ! have chezmoi; then
            step 'Installing chezmoi'
            sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
        fi
        ;;
    *)
        echo "Unsupported OS: $OS" >&2
        exit 1
        ;;
esac

if have mise; then
    step 'Installing language toolchains via mise'
    mise install || true
    mise reshim   || true
fi

step 'Done. Open a new shell to pick up shell config.'
