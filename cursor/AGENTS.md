# AGENTS.md

Global conventions for any AI coding agent working on this user's machines.

## Operating environment

- Primary host: Windows 11. Default shell is PowerShell 7. When running shell commands, write PowerShell-compatible syntax (`Get-ChildItem`, `Where-Object`, `Select-Object`, etc.), not bash. WSL or Git Bash is available only when explicitly requested.
- Cross-platform code should run on Windows, macOS, and Linux. Avoid hard-coded `/` or `\` separators in scripts; prefer language-native path joining.
- Dotfiles are managed by [chezmoi](https://www.chezmoi.io/). Files in `~/` may be templated; edit the source in the dotfiles repo (`chezmoi cd`) rather than the materialized copy.

## Code style

- TypeScript/JavaScript: single quotes, semicolons, 100-col print width, trailing commas (`all`). Formatter: Prettier.
- Python: format with `ruff format`, lint with `ruff check --fix`. 4-space indent. Type-hint new code.
- Rust: `cargo fmt` + `cargo clippy --all-targets -- -D warnings`.
- Go: `gofmt -s` + `golangci-lint run`.
- Shell (POSIX): `shellcheck` clean. PowerShell: pass `Invoke-ScriptAnalyzer` with the bundled rule set; use approved verb-noun cmdlet names for functions.
- Line endings: LF everywhere except `.ps1`/`.psm1`/`.bat`/`.cmd` which use CRLF (see `.gitattributes`).

## Editing rules

- Do NOT add narrating comments such as `// Import foo` or `// Increment i`. Comments must explain non-obvious intent, constraints, or trade-offs only.
- Preserve existing indentation style (tabs vs. spaces) when modifying a file.
- After substantive edits, run the project's lint and format commands. If the project has no scripts, run language-default tools (`prettier --write`, `ruff format`, `cargo fmt`, `gofmt -w`).
- Never commit secrets. Use environment variables or 1Password CLI references.

## Git

- Default branch is `main`. Commit messages are short imperative sentences ("Add X", "Fix Y"). No prefixes required.
- Prefer rebase over merge for personal branches. Use `git pull --rebase --autostash`.
- Never `--force` push to `main`/`master`. Use `git push --force-with-lease` on feature branches.
- Do not skip pre-commit hooks (no `--no-verify`).

## Tooling preferences

- Search: `rg` (ripgrep) over `grep`. Find files: `fd` over `find`.
- Read files: `bat` over `cat`. List: `eza` over `ls`.
- JSON: `jq`. YAML: `yq`. HTTP: `curl` or `Invoke-RestMethod`.
- Process manager for Node: `pnpm` (enabled via corepack). Python deps: `uv` and `uvx` for tools. Language versions: `mise`.
- Git UI: `lazygit` (`lg`).

## Cursor / AI specifics

- Hooks at `~/.cursor/hooks.json` are enabled; do not propose changes that bypass them.
- Skills live under `~/.cursor/skills-cursor` and `~/.agents/skills`. Read a relevant skill's `SKILL.md` IMMEDIATELY when it applies; do not paraphrase it without reading.
- MCP servers are configured at `~/.cursor/mcp.json`. Before calling an MCP tool, read its descriptor in `~/.cursor/projects/.../mcps/<server>/tools/`.

## Repository conventions

- Each repo should have its own `AGENTS.md` for project-specific rules; this file is the global fallback.
- Prefer Justfiles or npm-style task runners over README-only instructions.
