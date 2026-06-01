#### Dotfiles

<img width="2559" height="1439" alt="Pasted image 20260601035156" src="https://github.com/user-attachments/assets/e52aa24b-8f09-42d2-a0db-61547a8fdf48" />

#### Install (Windows)

Requirements: PowerShell 7+ (`pwsh`), `winget`, and either Administrator
rights or Windows Developer Mode (for symlinks; copy mode is the fallback).

`bash/`, `zsh/`, `ghostty/`, `equibop/`, and `flow/` are skipped by default
on Windows. Pass `-Exclude @()` to include them or `-Only` to target a
specific tool.

Use [`stow`](https://www.gnu.org/software/stow/) or `chezmoi` to materialize
the per-tool directories into `$HOME` (the layout is compatible with both).

#### Update

```powershell
cd $HOME\.dotfiles
git pull
pwsh -File .\scripts\link-dotfiles.ps1 -Force
```
