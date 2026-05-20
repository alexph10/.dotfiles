# Neovim Hotkeys & Commands Reference

> **Leader key: `Space`** | Local leader: `\`

---

## General

| Key | Mode | Action |
|-----|------|--------|
| `<Space>w` | Normal | Save file |
| `<Space>q` | Normal | Quit |
| `<Space>x` | Normal | Save and quit |
| `<Space>nh` | Normal | Clear search highlighting |
| `u` | Normal | Undo |
| `<C-r>` | Normal | Redo |
| `.` | Normal | Repeat last command |

---

## Navigation & Motion

| Key | Mode | Action |
|-----|------|--------|
| `h/j/k/l` | Normal | Left / Down / Up / Right |
| `w` / `b` | Normal | Next / Previous word |
| `e` | Normal | End of word |
| `0` / `$` | Normal | Start / End of line |
| `^` | Normal | First non-blank character |
| `gg` / `G` | Normal | Top / Bottom of file |
| `{` / `}` | Normal | Previous / Next paragraph |
| `%` | Normal | Jump to matching bracket |
| `<C-d>` | Normal | Scroll down half page (centered) |
| `<C-u>` | Normal | Scroll up half page (centered) |
| `n` | Normal | Next search result (centered) |
| `N` | Normal | Previous search result (centered) |
| `zz` | Normal | Center cursor on screen |
| `zt` / `zb` | Normal | Cursor to top / bottom of screen |

---

## Window Management

| Key | Mode | Action |
|-----|------|--------|
| `<C-h>` | Normal | Go to left window |
| `<C-j>` | Normal | Go to lower window |
| `<C-k>` | Normal | Go to upper window |
| `<C-l>` | Normal | Go to right window |
| `<C-Up>` | Normal | Increase window height |
| `<C-Down>` | Normal | Decrease window height |
| `<C-Left>` | Normal | Decrease window width |
| `<C-Right>` | Normal | Increase window width |
| `:split` | Command | Horizontal split |
| `:vsplit` | Command | Vertical split |

---

## Buffer Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<Space>bn` | Normal | Next buffer |
| `<Space>bp` | Normal | Previous buffer |
| `<Space>bd` | Normal | Delete buffer |
| Click tab in bufferline | Mouse | Switch buffer |
| Middle-click tab | Mouse | Close buffer |

---

## File Explorer (Neo-tree)

| Key | Mode | Action |
|-----|------|--------|
| `<Space>e` | Normal | Toggle Neo-tree |
| `<Space>o` | Normal | Focus Neo-tree |

### Inside Neo-tree:

| Key | Action |
|-----|--------|
| `<CR>` / `o` | Open file (with window picker) |
| `<Space>` | Toggle node expand/collapse |
| `P` | Toggle preview (floating) |
| `S` | Open in horizontal split |
| `s` | Open in vertical split |
| `t` | Open in new tab |
| `a` | Create new file |
| `A` | Create new directory |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `c` | Copy |
| `m` | Move |
| `R` | Refresh |
| `q` | Close Neo-tree |
| `z` | Close all nodes |
| `H` | Toggle hidden files |
| `/` | Fuzzy finder |
| `<BS>` | Navigate up |
| `.` | Set root |
| `[` / `]` | Prev / Next git modified file |
| `?` | Show help |

---

## Oil.nvim (File Manager as Buffer)

| Key | Mode | Action |
|-----|------|--------|
| `-` | Normal | Open parent directory in Oil |
| `<Space>-` | Normal | Open current directory in Oil |

### Inside Oil:

| Key | Action |
|-----|--------|
| `<CR>` | Select / Open |
| `-` | Go to parent |
| `<C-s>` | Open in vertical split |
| `<C-h>` | Open in horizontal split |
| `<C-t>` | Open in tab |
| `<C-p>` | Preview |
| `<C-c>` | Close |
| `<C-l>` | Refresh |
| `g.` | Toggle hidden files |
| `g?` | Show help |

---

## Telescope (Fuzzy Finder)

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ff` | Normal | Find files |
| `<Space>fg` | Normal | Live grep (search text) |
| `<Space>fb` | Normal | File browser |
| `<Space>fB` | Normal | File browser (current file dir) |
| `<Space>fh` | Normal | Help tags |
| `<Space>fr` | Normal | Recent files |
| `<Space>fc` | Normal | Commands |
| `<Space>fk` | Normal | Keymaps |
| `<Space>fs` | Normal | Search in current buffer |
| `<Space>pp` | Normal | Switch projects |
| `<Space>pf` | Normal | Find project files |
| `<Space>ct` | Normal | Choose colorscheme |

### Inside Telescope:

| Key | Mode | Action |
|-----|------|--------|
| `<C-n>` / `<C-p>` | Insert | Next / Previous item |
| `<CR>` | Both | Select |
| `<C-x>` | Both | Open in horizontal split |
| `<C-v>` | Both | Open in vertical split |
| `<C-t>` | Both | Open in tab |
| `<Tab>` | Both | Toggle selection |
| `<C-q>` | Both | Send to quickfix list |
| `<C-u>` / `<C-d>` | Both | Scroll preview up / down |
| `<Esc>` | Normal | Close |
| `<C-c>` | Insert | Close |
| `?` / `<C-_>` | Normal / Insert | Show which-key help |

### Telescope File Browser (Insert mode):

| Key | Action |
|-----|--------|
| `<Alt-c>` | Create file/folder |
| `<Alt-r>` | Rename |
| `<Alt-m>` | Move |
| `<Alt-y>` | Copy |
| `<Alt-d>` | Delete |
| `<C-g>` | Go to parent dir |
| `<C-f>` | Toggle browser mode |
| `<C-h>` | Toggle hidden |

---

## Harpoon (Quick File Navigation)

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ha` | Normal | Add file to Harpoon |
| `<Space>hh` | Normal | Toggle Harpoon quick menu |
| `<Space>h1` | Normal | Jump to Harpoon file 1 |
| `<Space>h2` | Normal | Jump to Harpoon file 2 |
| `<Space>h3` | Normal | Jump to Harpoon file 3 |
| `<Space>h4` | Normal | Jump to Harpoon file 4 |
| `<C-S-P>` | Normal | Previous Harpoon file |
| `<C-S-N>` | Normal | Next Harpoon file |

---

## Flash (Enhanced Search/Navigation)

| Key | Mode | Action |
|-----|------|--------|
| `s` | Normal, Visual, Operator | Flash jump |
| `S` | Normal, Visual, Operator | Flash treesitter select |
| `r` | Operator | Remote Flash |
| `R` | Operator, Visual | Treesitter search |
| `<C-s>` | Command | Toggle Flash search |

---

## LSP (Language Server Protocol)

### Global Diagnostics:

| Key | Mode | Action |
|-----|------|--------|
| `<Space>e` | Normal | Open diagnostic float |
| `[d` | Normal | Go to previous diagnostic |
| `]d` | Normal | Go to next diagnostic |
| `<Space>q` | Normal | Set diagnostic loclist |

### Buffer-local (when LSP attached):

| Key | Mode | Action |
|-----|------|--------|
| `gD` | Normal | Go to declaration |
| `gd` | Normal | Go to definition |
| `K` | Normal | Hover documentation |
| `gi` | Normal | Go to implementation |
| `<C-k>` | Normal | Signature help |
| `gr` | Normal | Go to references |
| `<Space>D` | Normal | Type definition |
| `<Space>rn` | Normal | Rename symbol |
| `<Space>ca` | Normal, Visual | Code actions (with preview) |
| `<Space>f` | Normal | Format document |
| `<Space>wa` | Normal | Add workspace folder |
| `<Space>wr` | Normal | Remove workspace folder |
| `<Space>wl` | Normal | List workspace folders |

### LSP Commands:

| Command | Action |
|---------|--------|
| `:LspInfo` | Show active LSP clients |
| `:LspRestart` | Restart LSP servers |
| `:LspStart` | Start LSP server |
| `:LspStop` | Stop LSP server |
| `:Mason` | Open Mason package manager |

---

## Rust-Specific (rustaceanvim)

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ra` | Normal | Rust code action |
| `<Space>rd` | Normal | Rust debuggables |
| `<Space>rr` | Normal | Rust runnables |
| `<Space>rt` | Normal | Rust testables |
| `<Space>rm` | Normal | Expand macro |
| `<Space>rc` | Normal | Open Cargo.toml |
| `<Space>rp` | Normal | Parent module |
| `<Space>rj` | Normal | Join lines |
| `<Space>re` | Normal | Explain error |
| `K` | Normal | Rust hover actions |

### Crates.nvim (in Cargo.toml):

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ct` | Normal | Toggle crate info |
| `<Space>cv` | Normal | Show crate versions |
| `<Space>cf` | Normal | Show crate features |
| `<Space>cd` | Normal | Show crate dependencies |
| `<Space>cu` | Normal | Update crate |
| `<Space>cU` | Normal | Upgrade crate |
| `<Space>cA` | Normal | Upgrade all crates |

---

## Trouble (Diagnostics UI)

| Key | Mode | Action |
|-----|------|--------|
| `<Space>xx` | Normal | Toggle diagnostics |
| `<Space>xX` | Normal | Toggle buffer diagnostics |
| `<Space>cs` | Normal | Toggle symbols |
| `<Space>cl` | Normal | LSP definitions/references |
| `<Space>xL` | Normal | Toggle location list |
| `<Space>xQ` | Normal | Toggle quickfix list |

---

## Git (Gitsigns)

### Navigation:

| Key | Mode | Action |
|-----|------|--------|
| `]c` | Normal | Next git hunk |
| `[c` | Normal | Previous git hunk |

### Actions:

| Key | Mode | Action |
|-----|------|--------|
| `<Space>ghs` | Normal | Stage hunk |
| `<Space>ghr` | Normal | Reset hunk |
| `<Space>ghs` | Visual | Stage selected hunk |
| `<Space>ghr` | Visual | Reset selected hunk |
| `<Space>ghS` | Normal | Stage entire buffer |
| `<Space>ghu` | Normal | Undo stage hunk |
| `<Space>ghR` | Normal | Reset entire buffer |
| `<Space>ghp` | Normal | Preview hunk |
| `<Space>ghb` | Normal | Blame line (full) |
| `<Space>gtb` | Normal | Toggle line blame |
| `<Space>ghd` | Normal | Diff this |
| `<Space>ghD` | Normal | Diff this ~ |
| `<Space>gtd` | Normal | Toggle deleted |
| `ih` | Visual, Operator | Select hunk (text object) |

---

## Debugging (DAP)

| Key | Mode | Action |
|-----|------|--------|
| `<F5>` | Normal | Continue |
| `<F10>` | Normal | Step over |
| `<F11>` | Normal | Step into |
| `<F12>` | Normal | Step out |
| `<Space>b` | Normal | Toggle breakpoint |
| `<Space>B` | Normal | Conditional breakpoint |
| `<Space>dr` | Normal | Open REPL |
| `<Space>dl` | Normal | Run last |
| `<Space>du` | Normal | Toggle DAP UI |

### Inside DAP UI:

| Key | Action |
|-----|--------|
| `<CR>` / double-click | Expand |
| `o` | Open |
| `d` | Remove |
| `e` | Edit |
| `r` | REPL |
| `t` | Toggle |

---

## Completion (nvim-cmp)

| Key | Mode | Action |
|-----|------|--------|
| `<Tab>` | Insert | Next completion / Expand snippet |
| `<S-Tab>` | Insert | Previous completion |
| `<CR>` | Insert | Confirm completion |
| `<C-Space>` | Insert | Trigger completion |
| `<C-e>` | Insert | Abort completion |
| `<C-b>` | Insert | Scroll docs up |
| `<C-f>` | Insert | Scroll docs down |

---

## Snippets (LuaSnip)

| Key | Mode | Action |
|-----|------|--------|
| `<C-j>` | Insert, Select | Expand or jump forward |
| `<C-k>` | Insert, Select | Jump backward |

---

## Terminal (ToggleTerm)

| Key | Mode | Action |
|-----|------|--------|
| `<C-\>` | Normal | Toggle floating terminal |
| `<C-\>` | Terminal | Toggle terminal (close) |
| `<Esc>` | Terminal | Exit terminal mode |

---

## Text Editing

### Surround (nvim-surround):

| Key | Mode | Action |
|-----|------|--------|
| `ys{motion}{char}` | Normal | Add surround |
| `ds{char}` | Normal | Delete surround |
| `cs{old}{new}` | Normal | Change surround |
| `S{char}` | Visual | Surround selection |

### Commenting (Comment.nvim):

| Key | Mode | Action |
|-----|------|--------|
| `gcc` | Normal | Toggle line comment |
| `gbc` | Normal | Toggle block comment |
| `gc` | Visual | Toggle line comment |
| `gb` | Visual | Toggle block comment |

### Indenting:

| Key | Mode | Action |
|-----|------|--------|
| `<` | Visual | Indent left (stays in visual) |
| `>` | Visual | Indent right (stays in visual) |

### Moving Lines:

| Key | Mode | Action |
|-----|------|--------|
| `<Alt-j>` | Visual | Move line(s) down |
| `<Alt-k>` | Visual | Move line(s) up |
| `J` | Visual block | Move text down |
| `K` | Visual block | Move text up |

---

## Marks

| Key | Mode | Action |
|-----|------|--------|
| `m{a-zA-Z}` | Normal | Set mark |
| `'{a-zA-Z}` | Normal | Jump to mark (line) |
| `` `{a-zA-Z} `` | Normal | Jump to mark (exact position) |

---

## Colorscheme

| Key | Mode | Action |
|-----|------|--------|
| `<Space>cr` | Normal | Rose Pine |
| `<Space>cg` | Normal | Gruvbox Light |
| `<Space>cgd` | Normal | Gruvbox Dark |
| `<Space>cm` | Normal | Monokai Pro |
| `<Space>cme` | Normal | Melange |
| `<Space>ct` | Normal | Telescope colorscheme picker |

---

## File Creation

| Key | Mode | Action |
|-----|------|--------|
| `<Space>nf` | Normal | Create new file/folder (AdvancedNewFile) |
| `<Space>ft` | Normal | Insert template |
| `<Space>fT` | Normal | Project template |

---

## Useful Commands

| Command | Action |
|---------|--------|
| `:Lazy` | Open plugin manager |
| `:Mason` | Open LSP/tool installer |
| `:checkhealth` | Run health checks |
| `:Telescope keymaps` | Search all keymaps |
| `:Telescope commands` | Search all commands |
| `:Telescope help_tags` | Search help docs |
| `:Neotree toggle` | Toggle file explorer |
| `:Trouble diagnostics toggle` | Toggle diagnostics panel |
| `:ToggleTerm` | Toggle terminal |
| `:Alpha` | Show dashboard |
| `:LspRestart` | Restart LSP servers |
| `:LspInfo` | Show LSP status |
| `:RustLsp runnables` | Run Rust targets |
| `:RustLsp debuggables` | Debug Rust targets |

---

## Tips

- Press `<Space>` and wait for **which-key** popup to see available key groups
- Use `<Space>fk` to search all keymaps with Telescope
- In Telescope, press `?` (normal mode) or `<C-_>` (insert mode) for help
- Use `<C-d>`/`<C-u>` for centered half-page scrolling
- `s` activates Flash for quick jumping to any visible text
