#### Dotfiles

<img width="2559" height="1439" alt="Pasted image 20260601034942" src="https://github.com/user-attachments/assets/f92385a4-6751-466a-9657-25a37d41c1a4" />

#### Install (Windows)

Requirements: PowerShell 7+ (`pwsh`), `winget`, and either Administrator
rights or Windows Developer Mode (for symlinks; copy mode is the fallback).

```powershell
git clone https://github.com/alexph10/.dotfiles $HOME\.dotfiles
cd $HOME\.dotfiles

# Install tools (winget + scoop + PSModules + mise toolchains).
pwsh -File .\scripts\install-packages.ps1

# Link (or copy) config files into $HOME.
pwsh -File .\scripts\link-dotfiles.ps1 -DryRun       # preview
pwsh -File .\scripts\link-dotfiles.ps1                # apply (symlinks if elevated/devmode, otherwise copies)
pwsh -File .\scripts\link-dotfiles.ps1 -Force         # back up existing files and replace
pwsh -File .\scripts\link-dotfiles.ps1 -Only git,nvim # subset

# Optional: Windows tweaks (registry).
pwsh -File .\scripts\windows-tweaks.ps1 -Apply

# Verify.
pwsh -File .\scripts\verify.ps1
```

`bash/`, `zsh/`, `ghostty/`, `equibop/`, and `flow/` are skipped by default
on Windows. Pass `-Exclude @()` to include them or `-Only` to target a
specific tool.

Use [`stow`](https://www.gnu.org/software/stow/) or `chezmoi` to materialize
the per-tool directories into `$HOME` (the layout is compatible with both).

#### Layout

| Directory               | Target                                                  |
| ----------------------- | ------------------------------------------------------- |
| `powershell/`           | `$HOME\Documents\PowerShell\`                           |
| `powertoys/`            | `$HOME\AppData\Local\Microsoft\PowerToys\`              |
| `windows-terminal/`     | `$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbcwe\LocalState\` |
| `git/`, `ssh/`          | `$HOME\.gitconfig`, `$HOME\.ssh\config`                 |
| `nvim/`, `wezterm/`     | `$HOME\.config\nvim\`, `$HOME\.config\wezterm\`         |
| `atuin/`, `bat/`, `btop/`, `fd/`, `gh/`, `mise/`, `ohmyposh/`, `ripgrep/`, `tealdeer/`, `lazygit/`, `gitu/`, `direnv/` | `$HOME\.config\<tool>\` |
| `claude/`, `opencode/`, `pi/` | agent configs under `$HOME\.claude\`, `$HOME\.config\opencode\`, `$HOME\.pi\` |
| `bash/`, `zsh/`         | shell rc files for WSL or Git Bash                      |
| `packages/`             | tool manifests (`winget.json`, `scoop.txt`, `brew.txt`, `apt.txt`) |
| `scripts/`              | install, link, verify, tweaks                           |
| `templates/`            | starter `justfile`, `pre-commit-config.yaml`            |

#### Update

```powershell
cd $HOME\.dotfiles
git pull
pwsh -File .\scripts\link-dotfiles.ps1 -Force
```
