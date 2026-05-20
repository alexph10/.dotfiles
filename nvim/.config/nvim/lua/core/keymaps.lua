-- Key mappings

-- File Explorer
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus Neo-tree" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Terminal
vim.keymap.set("n", "<C-\\>", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })
vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>:ToggleTerm<CR>", { desc = "Toggle Terminal" })
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Telescope fuzzy finder
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })
vim.keymap.set("n", "<leader>fc", ":Telescope commands<CR>", { desc = "Commands" })
vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fs", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in current buffer" })

-- DAP Debugging
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>", { desc = "Debug: Continue" })
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>", { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>", { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>", { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = "Debug: Conditional Breakpoint" })
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", { desc = "Debug: Open REPL" })
vim.keymap.set("n", "<leader>dl", ":lua require'dap'.run_last()<CR>", { desc = "Debug: Run Last" })
vim.keymap.set("n", "<leader>du", ":lua require'dapui'.toggle()<CR>", { desc = "Debug: Toggle UI" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Resize windows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==gv", { desc = "Move text down" })
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==gv", { desc = "Move text up" })
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move text down" })
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move text up" })
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", { desc = "Move text down" })
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", { desc = "Move text up" })

-- Clear search highlighting
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Quick save and quit
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>x", ":x<CR>", { desc = "Save and quit" })

-- AdvancedNewFile keymap
vim.keymap.set("n", "<leader>nf", ":AdvancedNewFile<CR>", { desc = "Create new file/folder" })

-- Oil.nvim - File manager as buffer
vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open parent directory in Oil" })
vim.keymap.set("n", "<leader>-", ":Oil .<CR>", { desc = "Open current directory in Oil" })

-- Telescope File Browser and Projects
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "File browser" })
vim.keymap.set("n", "<leader>fB", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "File browser (current file)" })
vim.keymap.set("n", "<leader>pp", ":Telescope projects<CR>", { desc = "Switch projects" })
vim.keymap.set("n", "<leader>pf", ":Telescope find_files<CR>", { desc = "Find project files" })

-- Harpoon - Quick file navigation
vim.keymap.set("n", "<leader>ha", function() require("harpoon"):list():append() end, { desc = "Harpoon add file" })
vim.keymap.set("n", "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, { desc = "Harpoon quick menu" })
vim.keymap.set("n", "<leader>h1", function() require("harpoon"):list():select(1) end, { desc = "Harpoon file 1" })
vim.keymap.set("n", "<leader>h2", function() require("harpoon"):list():select(2) end, { desc = "Harpoon file 2" })
vim.keymap.set("n", "<leader>h3", function() require("harpoon"):list():select(3) end, { desc = "Harpoon file 3" })
vim.keymap.set("n", "<leader>h4", function() require("harpoon"):list():select(4) end, { desc = "Harpoon file 4" })
vim.keymap.set("n", "<C-S-P>", function() require("harpoon"):list():prev() end, { desc = "Harpoon previous" })
vim.keymap.set("n", "<C-S-N>", function() require("harpoon"):list():next() end, { desc = "Harpoon next" })

-- Templates
vim.keymap.set("n", "<leader>ft", ":Template<CR>", { desc = "Insert template" })
vim.keymap.set("n", "<leader>fT", ":TemProject<CR>", { desc = "Project template" })

-- Colorscheme keymaps
vim.keymap.set("n", "<leader>cr", ":colorscheme rose-pine<CR>", { desc = "Rose Pine Dawn colorscheme" })
vim.keymap.set("n", "<leader>cg", function()
  vim.o.background = "light"
  vim.cmd("colorscheme gruvbox")
end, { desc = "Gruvbox Light colorscheme" })
vim.keymap.set("n", "<leader>cgd", function()
  vim.o.background = "dark"
  vim.cmd("colorscheme gruvbox")
end, { desc = "Gruvbox Dark colorscheme" })
vim.keymap.set("n", "<leader>cm", ":colorscheme monokai-pro<CR>", { desc = "Monokai Pro colorscheme" })
vim.keymap.set("n", "<leader>cme", ":colorscheme melange<CR>", { desc = "Melange colorscheme" })
vim.keymap.set("n", "<leader>ct", ":Telescope colorscheme<CR>", { desc = "Choose colorscheme" })

-- Centered scrolling and search navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- LuaSnip snippet navigation
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  local ls = require("luasnip")
  if ls.expand_or_jumpable() then ls.expand_or_jump() end
end, { silent = true, desc = "LuaSnip expand or jump forward" })
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  local ls = require("luasnip")
  if ls.jumpable(-1) then ls.jump(-1) end
end, { silent = true, desc = "LuaSnip jump backward" })
