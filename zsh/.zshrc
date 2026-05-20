export DOTFILES_NAME="Alex Y"
export DOTFILES_EMAIL="alex@example.com"

export EDITOR="${EDITOR:-nvim}"
export VISUAL="$EDITOR"
export PAGER="${PAGER:-less}"
export LANG="${LANG:-en_US.UTF-8}"

typeset -U path PATH
path=(
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.cargo/bin"
    "$HOME/go/bin"
    $path
)
export PATH

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_VERIFY INC_APPEND_HISTORY EXTENDED_HISTORY HIST_REDUCE_BLANKS
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt INTERACTIVE_COMMENTS GLOB_DOTS NO_BEEP
setopt PROMPT_SUBST

autoload -Uz compinit && compinit -d "$HOME/.cache/zsh/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[.' insert-last-word
bindkey '^W' backward-kill-word

if [ -d "$HOME/.zsh/plugins/zsh-autosuggestions" ]; then
    source "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
if [ -d "$HOME/.zsh/plugins/zsh-syntax-highlighting" ]; then
    source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --cmd cd)"
fi

if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
    if [ -f "$HOME/.fzf.zsh" ]; then
        source "$HOME/.fzf.zsh"
    elif command -v fzf-share >/dev/null 2>&1; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
    fi
    export FZF_DEFAULT_OPTS='--height 40% --reverse --border --ansi'
    if command -v fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
fi

if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/theme.omp.json)"
fi

if command -v gh >/dev/null 2>&1; then
    eval "$(gh completion -s zsh)"
fi

[ -f "$HOME/.aliases.sh" ] && source "$HOME/.aliases.sh"

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
