#!/usr/bin/env bash
set -euo pipefail

REPO="${REPO:-https://github.com/alexph10/.dotfiles.git}"
BRANCH="${BRANCH:-main}"
NO_APPLY="${NO_APPLY:-0}"

step() { printf '\033[1;36m==> %s\033[0m\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

OS="$(uname -s)"

if ! have git; then
    case "$OS" in
        Darwin)
            if have brew; then brew install git; else xcode-select --install || true; fi
            ;;
        Linux)
            if   have apt-get; then sudo apt-get update -y && sudo apt-get install -y git
            elif have pacman;  then sudo pacman -Syu --noconfirm git
            elif have dnf;     then sudo dnf install -y git
            else echo 'Install git manually then re-run.' >&2; exit 1
            fi
            ;;
        *) echo "Unsupported OS: $OS" >&2; exit 1 ;;
    esac
fi

if ! have chezmoi; then
    step 'Installing chezmoi'
    case "$OS" in
        Darwin)
            if have brew; then brew install chezmoi
            else sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
            fi
            ;;
        Linux)
            sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
            export PATH="$HOME/.local/bin:$PATH"
            ;;
    esac
fi

if ! have chezmoi; then
    echo 'chezmoi install failed. Add ~/.local/bin to PATH and re-run.' >&2
    exit 1
fi

args=(init --branch "$BRANCH")
if [ "$NO_APPLY" != "1" ]; then args+=(--apply); fi
args+=("$REPO")

step "Running: chezmoi ${args[*]}"
chezmoi "${args[@]}"

cat <<'EOF'

Dotfiles bootstrapped.
Next steps:
  1. Open a new shell (zsh or bash) to pick up your rc files.
  2. Run scripts/install-packages.sh inside `chezmoi cd` to install tools.
EOF
