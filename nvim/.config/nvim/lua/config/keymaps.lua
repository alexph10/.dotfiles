vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc><cmd>w<CR>a', { desc = 'Save file' })
vim.keymap.set('n', '<C-z>', 'u', { desc = 'Undo' })
vim.keymap.set('i', '<C-z>', '<Esc>ua', { desc = 'Undo' })
vim.keymap.set('n', '<C-y>', '<C-r>', { desc = 'Redo' })
vim.keymap.set('i', '<C-y>', '<Esc><C-r>a', { desc = 'Redo' })
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy' })
vim.keymap.set('n', '<C-v>', '"+p', { desc = 'Paste' })
vim.keymap.set('i', '<C-v>', '<C-r>+', { desc = 'Paste' })
vim.keymap.set('v', '<C-x>', '"+d', { desc = 'Cut' })

-- Cross-platform IDE-style bindings: Ctrl/Alt (Windows/Linux) and Cmd (macOS).
local function find_files()
  require('fff').find_files()
end
local function live_grep()
  require('fff').live_grep()
end
local function toggle_explorer()
  require('snacks').explorer()
end
local function pick_buffer()
  require('telescope.builtin').buffers()
end

vim.keymap.set({ 'n', 'i', 'v' }, '<C-p>', find_files, { desc = 'Find files' })
vim.keymap.set({ 'n', 'i', 'v' }, '<M-p>', find_files, { desc = 'Find files' })
vim.keymap.set({ 'n', 'i', 'v' }, '<D-p>', find_files, { desc = 'Find files' })

vim.keymap.set({ 'n', 'i', 'v' }, '<C-S-p>', live_grep, { desc = 'Grep workspace' })
vim.keymap.set({ 'n', 'i', 'v' }, '<M-S-p>', live_grep, { desc = 'Grep workspace' })
vim.keymap.set({ 'n', 'i', 'v' }, '<D-S-p>', live_grep, { desc = 'Grep workspace' })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-S-f>', live_grep, { desc = 'Grep workspace' })
vim.keymap.set({ 'n', 'i', 'v' }, '<D-S-f>', live_grep, { desc = 'Grep workspace' })

vim.keymap.set({ 'n', 'i', 'v' }, '<M-b>', toggle_explorer, { desc = 'Toggle sidebar' })
vim.keymap.set({ 'n', 'i', 'v' }, '<D-b>', toggle_explorer, { desc = 'Toggle sidebar' })

vim.keymap.set({ 'n', 'i', 'v' }, '<M-e>', pick_buffer, { desc = 'Switch buffer' })
vim.keymap.set({ 'n', 'i', 'v' }, '<D-e>', pick_buffer, { desc = 'Switch buffer' })

vim.keymap.set({ 'n', 'i' }, '<D-s>', '<Esc><cmd>w<CR>', { desc = 'Save' })
vim.keymap.set({ 'n', 'i' }, '<D-z>', '<Esc>ua', { desc = 'Undo' })
vim.keymap.set({ 'n', 'i' }, '<D-S-z>', '<Esc><C-r>a', { desc = 'Redo' })
vim.keymap.set('v', '<D-c>', '"+y', { desc = 'Copy' })
vim.keymap.set({ 'n', 'i' }, '<D-v>', '<C-r>+', { desc = 'Paste' })

vim.keymap.set('n', '<C-_>', 'gcc', { remap = true, desc = 'Toggle comment' })
vim.keymap.set('v', '<C-_>', 'gc', { remap = true, desc = 'Toggle comment' })
vim.keymap.set('n', '<D-/>', 'gcc', { remap = true, desc = 'Toggle comment' })
vim.keymap.set('v', '<D-/>', 'gc', { remap = true, desc = 'Toggle comment' })

vim.keymap.set({ 'n', 'i' }, '<M-w>', '<cmd>bd<CR>', { desc = 'Close buffer' })
vim.keymap.set({ 'n', 'i' }, '<D-w>', '<cmd>bd<CR>', { desc = 'Close buffer' })
