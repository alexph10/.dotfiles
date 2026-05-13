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
| Editor (Cursor / VS Code) | Format-on-save, ruler at 100, telemetry off, Tokyo Night, per-language formatters; AI hooks for prettier/ruff/rustfmt/gofmt |
| Editor (Neovim) | Mirror of your existing `~/AppData/Local/nvim` config (modular `core/` + `plugins/` layout, Melange/Gruvbox/Rose Pine/Monokai Pro themes with custom syntax highlights, neo-tree, telescope, treesitter, Mason-managed LSPs, nvim-cmp, DAP/debug, gitsigns, which-key, indent-blankline, alpha dashboard, toggleterm, obsidian, rustaceanvim) plus two repo-only additions: `lazygit.nvim` (`<leader>gg`) and `conform.nvim` (format-on-save wired to your already-installed formatters: stylua, prettier, black/isort, rustfmt, clang-format, shfmt, taplo) |
| Git | delta diffs side-by-side, zdiff3 conflicts, `pull.rebase`, `rerere`, helpful aliases (`g s`, `g lg`, `g please`, `g sync`), per-OS credential helper |
| Modern CLI | fzf, ripgrep, bat, eza, fd, zoxide, gh, lazygit, jq, yq, btop, delta, hyperfine, dust — each with its config and shell wiring |
| Languages | `mise` pins Node LTS, Python 3.12, Go stable, Rust stable; corepack auto-enables `pnpm`; `uv` for Python tools |
| AI / Cursor | Global `AGENTS.md`, rule files for shell/git, hooks.json for formatters, MCP server template |
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
├── cursor/                        # Cursor IDE assets
│   ├── AGENTS.md
│   ├── settings.json
│   ├── keybindings.json
│   ├── mcp.json.tmpl
│   ├── hooks.json
│   └── rules/                     # .mdc rule files
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

## Cursor-specific deployment

The `cursor/` directory is not auto-applied by chezmoi (Cursor stores config in user-scoped roaming dirs that vary by build). Sync it manually:

- Windows: `cursor/settings.json` and `cursor/keybindings.json` → `%APPDATA%\Cursor\User\`
- macOS:   → `~/Library/Application Support/Cursor/User/`
- Linux:   → `~/.config/Cursor/User/`

`AGENTS.md`, `mcp.json.tmpl`, `hooks.json`, and `rules/` live wherever your Cursor user-scoped agent context expects them (commonly `~/.cursor/`).

## Customization

- **Per-machine overrides:** drop a `profile.local.ps1`, `~/.zshrc.local`, or `~/.bashrc.local` — they are sourced last and never committed.
- **Per-repo agent rules:** add an `AGENTS.md` at the repo root; the global one in `cursor/AGENTS.md` is a fallback.
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
