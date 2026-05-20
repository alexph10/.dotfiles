-- Neovim Configuration - Modular Setup
-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Core settings (leader key must be set before lazy.nvim loads)
require("core.options")
require("core.gui")

-- Setup plugins (auto-imports all files from lua/plugins/)
require("lazy").setup({
  { import = "plugins" },
})

-- Post-plugin setup
require("core.keymaps")
require("core.autocmds")
require("core.providers")
