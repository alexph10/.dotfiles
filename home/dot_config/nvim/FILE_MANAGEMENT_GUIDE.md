# 🚀 File & Project Management Guide

Your Neovim configuration now includes powerful file and project management plugins! Here's everything you need to know:

## 📦 Installed Plugins

### 1. **AdvancedNewFile.nvim** - Quick File Creation
- **Purpose**: Create files and folders quickly with automatic directory creation
- **Keymaps**:
  - `<leader>nf` - Create new file/folder
- **Usage**: 
  - Type filename for files: `config.lua`
  - End with `/` for folders: `src/`
  - Create nested paths: `src/components/Button.jsx`

### 2. **Oil.nvim** - File Manager as Buffer
- **Purpose**: Edit your filesystem like a text buffer
- **Keymaps**:
  - `-` - Open parent directory in Oil
  - `<leader>-` - Open current directory in Oil
- **Usage**: Navigate, create, rename, delete files by editing text
- **Oil Keymaps** (inside Oil buffer):
  - `<CR>` - Open file/directory
  - `<C-s>` - Open in vertical split
  - `<C-h>` - Open in horizontal split
  - `g.` - Toggle hidden files
  - `R` - Refresh

### 3. **Telescope File Browser** - Enhanced File Navigation
- **Purpose**: Powerful file browser with Telescope integration
- **Keymaps**:
  - `<leader>fb` - Open file browser
  - `<leader>fB` - File browser (current file location)
- **File Browser Keymaps**:
  - `c` - Create file/folder
  - `r` - Rename
  - `d` - Delete
  - `y` - Copy
  - `m` - Move

### 4. **Project.nvim** - Automatic Project Detection
- **Purpose**: Automatically detect and switch between projects
- **Keymaps**:
  - `<leader>pp` - Switch projects
  - `<leader>pf` - Find files in project
- **Auto-detects**: `.git`, `package.json`, `Cargo.toml`, `go.mod`, etc.

### 5. **Harpoon** - Quick File Navigation
- **Purpose**: Mark and quickly jump between important files
- **Keymaps**:
  - `<leader>ha` - Add current file to Harpoon
  - `<leader>hh` - Toggle Harpoon quick menu
  - `<leader>h1-4` - Jump to Harpoon file 1-4
  - `<C-S-P>` - Previous Harpoon file
  - `<C-S-N>` - Next Harpoon file

### 6. **Templates.nvim** - File Templates
- **Purpose**: Create files from templates
- **Keymaps**:
  - `<leader>ft` - Insert template
  - `<leader>fT` - Project template
- **Templates Available**: Lua, JavaScript, Python, HTML
- **Location**: `~/.config/nvim/templates/`

### 7. **Mkdir.nvim** - Auto-Directory Creation
- **Purpose**: Automatically creates missing directories when saving files
- **Usage**: Automatic - no keymaps needed

## 🎯 Quick Reference - Key Combinations

### File Creation & Management
| Keymap | Action | Plugin |
|--------|--------|--------|
| `<leader>nf` | Create new file/folder | AdvancedNewFile |
| `-` | Open parent directory | Oil |
| `<leader>fb` | File browser | Telescope |
| `<leader>ft` | Insert template | Templates |

### Project Management
| Keymap | Action | Plugin |
|--------|--------|--------|
| `<leader>pp` | Switch projects | Project.nvim |
| `<leader>pf` | Find project files | Telescope |

### Quick Navigation
| Keymap | Action | Plugin |
|--------|--------|--------|
| `<leader>ha` | Add to Harpoon | Harpoon |
| `<leader>hh` | Harpoon menu | Harpoon |
| `<leader>h1-4` | Jump to file 1-4 | Harpoon |

### Enhanced Neo-tree (existing)
| Keymap | Action |
|--------|--------|
| `<leader>e` | Toggle Neo-tree |
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |

## 🔧 Workflow Examples

### Creating a New Project Structure
1. `<leader>nf` → `my-project/`
2. `<leader>nf` → `my-project/src/`
3. `<leader>nf` → `my-project/src/main.js`
4. `<leader>ft` → Select JavaScript template

### Quick File Navigation
1. `<leader>ha` → Add important files to Harpoon
2. `<leader>h1` → Jump to first file
3. `<leader>hh` → See all Harpoon files

### File Management with Oil
1. `-` → Open current directory
2. Edit the buffer like text (add/remove lines)
3. `:w` → Save changes to filesystem

### Project Switching
1. `<leader>pp` → See all projects
2. Select project → Auto-change directory
3. `<leader>pf` → Find files in new project

## 🎨 Template Variables

When using templates, these variables are automatically replaced:
- `{{_file_name_}}` - Full filename
- `{{_file_name_without_ext_}}` - Filename without extension
- `{{_date_}}` - Current date
- `{{_author_}}` - Your name (configure in init.lua)
- `{{_email_}}` - Your email (configure in init.lua)

## 🚀 Next Steps

1. **Restart Neovim** or run `:Lazy sync` to install all plugins
2. **Try the keymaps** - Start with `<leader>nf` and `-`
3. **Customize templates** - Edit files in `~/.config/nvim/templates/`
4. **Update author info** - Edit the Templates.nvim config in init.lua

## 💡 Pro Tips

- Use Oil (`-`) for bulk file operations
- Harpoon is perfect for switching between 2-4 main files
- Project.nvim automatically detects when you're in a Git repo
- Telescope File Browser (`<leader>fb`) is great for exploring new codebases
- Templates save time - create your own for common file types

Happy coding! 🎉
