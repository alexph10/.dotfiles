# dotfiles

Cross-platform dotfiles managed by [chezmoi](https://www.chezmoi.io/). Windows-first, with macOS and Linux as first-class citizens. One repo bootstraps a productive setup: shell, terminal, editors, git, modern CLI, language toolchains, and AI/Cursor config.

## Quickstart

### Windows (PowerShell 7+)

```powershell
iwr -useb https://raw.githubusercontent.com/alexph10/.dotfiles/main/bootstrap.ps1 | iex
```

Or, if you've already cloned the repo:

```powershell
.\bootstrap.ps1
```

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/alexph10/.dotfiles/main/bootstrap.sh | bash
```

Both bootstraps install `chezmoi`, run `chezmoi init --apply <this repo>`, prompt you for name/email/machine kind, and materialize your dotfiles. The first apply also kicks off `scripts/install-packages.*` via a `run_once` hook to install all CLI tools and language runtimes.

## What you get

| Area | Highlights |
| --- | --- |
| Shell (PowerShell) | PSReadLine with predictive intellisense + list view, history-search arrow keys, `PSFzf`, `Terminal-Icons`, `z`, oh-my-posh, zoxide, mise activation, comprehensive aliases (`ll`, `cat`→`bat`, `grep`→`rg`) |
| Shell (zsh / bash) | Mirrored aliases, vi/Emacs friendly bindings, mise + zoxide + fzf + oh-my-posh, autosuggestions + syntax highlighting |
| Prompt | One shared Oh-My-Posh theme (`Tokyo Night` palette) across pwsh/zsh/bash |
| Terminal | Windows Terminal `settings.json` with JetBrainsMono Nerd Font + Tokyo Night; WezTerm config as a portable fallback with leader-key splits |
| Editor (Neovim) | Mirror of your existing `~/AppData/Local/nvim` config (modular `core/` + `plugins/` layout, Melange/Gruvbox/Rose Pine/Monokai Pro themes with custom syntax highlights, neo-tree, telescope, treesitter, Mason-managed LSPs, nvim-cmp, DAP/debug, gitsigns, which-key, indent-blankline, alpha dashboard, toggleterm, obsidian, rustaceanvim) plus two repo-only additions: `lazygit.nvim` (`<leader>gg`) and `conform.nvim` (format-on-save wired to your already-installed formatters: stylua, prettier, black/isort, rustfmt, clang-format, shfmt, taplo) |
| Git | delta diffs side-by-side, zdiff3 conflicts, `pull.rebase`, `rerere`, helpful aliases (`g s`, `g lg`, `g please`, `g sync`), per-OS credential helper |
| Modern CLI | fzf, ripgrep, bat, eza, fd, zoxide, gh, lazygit, jq, yq, btop, delta, hyperfine, dust — each with its config and shell wiring |
| Productivity meta-tools | `direnv` (per-project env, auto-`use uv`/`use mise`), `just` (modern Make), `tealdeer` (`tldr`), `glow` (markdown TUI), `atuin` (synced shell history) |
| Quality / security | `pre-commit` auto-installed into every `git clone` via `init.templateDir`, plus `gitleaks` for secret scanning. Starter `.pre-commit-config.yaml` and `justfile` in [templates/](templates/) |
| Cloud | Azure CLI (`az`), GitHub CLI (`gh`); easy to extend with `aws`/`gcloud` later |
| Languages | `mise` pins Node LTS, Python 3.12, Go stable, Rust stable; corepack auto-enables `pnpm`; `uv` for Python tools |
| Windows | PowerToys settings, optional registry tweaks (long paths, show extensions, no mouse accel) |

## Repository layout

```
.
├── README.md
├── .chezmoiroot                   # points to "home"
├── bootstrap.ps1 / bootstrap.sh   # one-liner entries
├── home/                          # chezmoi source state (applied to $HOME)
│   ├── .chezmoi.toml.tmpl         # asks name/email/machine kind on init
│   ├── .chezmoiignore             # OS-conditional ignores
│   ├── .chezmoiexternal.toml      # zsh plugins fetched on apply
│   ├── dot_gitconfig.tmpl
│   ├── dot_gitignore_global
│   ├── dot_zshrc.tmpl
│   ├── dot_bashrc.tmpl
│   ├── dot_aliases.sh
│   ├── dot_config/
│   │   ├── ohmyposh/theme.omp.json
│   │   ├── wezterm/wezterm.lua
│   │   ├── nvim/                  # lazy.nvim + telescope + Mason
│   │   ├── lazygit/config.yml
│   │   ├── bat/config
│   │   ├── mise/config.toml
│   │   ├── gh/config.yml
│   │   ├── fd/ignore
│   │   ├── ripgrep/ripgreprc
│   │   └── btop/btop.conf
│   ├── Documents/PowerShell/      # Windows pwsh profile + helpers
│   ├── AppData/Local/...          # Windows Terminal + PowerToys settings
│   └── run_once_before_*.tmpl     # chezmoi hooks for packages
├── packages/                      # declarative tool lists
│   ├── winget.json
│   ├── scoop.txt
│   ├── brew.txt
│   └── apt.txt
└── scripts/
    ├── install-packages.ps1
    ├── install-packages.sh
    ├── windows-tweaks.ps1
    └── verify.ps1
```

## Day-to-day workflow

```powershell
chezmoi cd                  # jump into the source repo
chezmoi diff                # preview pending changes
chezmoi apply -v            # apply current state
chezmoi update -v           # git pull + apply
chezmoi add ~/.somefile     # promote a file from $HOME into source state
chezmoi edit ~/.gitconfig   # edit the source for a target file
chezmoi managed             # list everything chezmoi controls
.\scripts\verify.ps1        # sanity-check installs (Windows)
```

POSIX aliases (`dot`, `dotup`, `dotcd`) are wired in [home/dot_aliases.sh](home/dot_aliases.sh).

## Working with the productivity stack

- **direnv** — drop a `.envrc` at any repo root, run `direnv allow` once. Convenience layouts in `~/.config/direnv/direnvrc`: `use mise`, `use uv 3.12`, `layout_node`, `dotenv_if_exists .env .env.local`, `strict_env VAR1 VAR2`.
- **just** — copy [templates/justfile](templates/justfile) into a new repo, edit, then run `j` (alias of `just`) or `jl` (`just --list`).
- **pre-commit** — copy [templates/pre-commit-config.yaml](templates/pre-commit-config.yaml) into a new repo as `.pre-commit-config.yaml`. If you said "yes" to the auto-install prompt during `chezmoi init`, the hook is installed automatically on every `git init`/`git clone` (via `init.templateDir`). Otherwise run `pre-commit install` once per repo.
- **atuin** — Ctrl+R opens the searchable history TUI. Offline by default. To sync across machines, run `atuin register` against a server you trust (or self-host).
- **tldr** — `tldr <command>` for quick examples; auto-refreshes the cache weekly.
- **glow** — `md README.md` (alias) opens a markdown file in a styled pager.
- **az** — `azwhoami` shows current subscription/tenant; standard `az` for everything else.

## Customization

- **Per-machine overrides:** drop a `profile.local.ps1`, `~/.zshrc.local`, or `~/.bashrc.local` — they are sourced last and never committed.
- **Re-prompt for chezmoi data:** `chezmoi init --data-prompt` (or delete `~/.config/chezmoi/chezmoi.toml`).

## Update workflow

```powershell
chezmoi update -v
```

That command does `git pull --rebase` in the source repo, re-evaluates templates with your current data, and applies any diffs. Bumped package lists trigger the install hook again.

## Uninstall

```powershell
chezmoi purge
```

Removes the chezmoi source dir and state. Files already materialized into `$HOME` are not deleted; remove them by hand if needed.

## License

MIT.
