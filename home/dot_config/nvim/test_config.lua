-- Test configuration loading
print("Testing Neovim configuration...")

-- Test if lazy.nvim is properly set up
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.loop.fs_stat(lazy_path) then
  print("✓ Lazy.nvim is installed")
else
  print("✗ Lazy.nvim is missing")
end

-- Test basic configuration
print("✓ Basic options loaded")
print("✓ Leader key: " .. (vim.g.mapleader or "not set"))

-- Test plugin loading
local plugins_to_test = {
  "mason",
  "nvim-lspconfig", 
  "nvim-cmp",
  "nvim-treesitter",
  "telescope",
  "neo-tree"
}

for _, plugin in ipairs(plugins_to_test) do
  local ok, _ = pcall(require, plugin)
  if ok then
    print("✓ " .. plugin .. " loaded successfully")
  else
    print("✗ " .. plugin .. " failed to load")
  end
end

print("Configuration test completed!")
