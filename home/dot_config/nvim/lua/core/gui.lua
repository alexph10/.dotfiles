-- Font settings for GUI Neovim (Neovide, nvim-qt, etc.)
if vim.g.neovide then
  -- Neovide-specific font settings
  vim.o.guifont = "JetBrainsMono Nerd Font:h9"
  vim.g.neovide_scale_factor = 0.75
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_no_idle = true

  -- Force redraw on startup to fix blank buffer rendering
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.defer_fn(function()
        vim.cmd("mode")
        vim.cmd("redraw!")
      end, 100)
    end,
  })
elseif vim.g.fvim_loaded then
  -- FVim-specific font settings
  vim.o.guifont = "JetBrainsMono Nerd Font:h9"
elseif vim.g.nvui then
  -- Nvui-specific font settings
  vim.o.guifont = "JetBrainsMono Nerd Font:h9"
else
  -- General GUI font setting (works with nvim-qt and others)
  vim.o.guifont = "JetBrainsMono Nerd Font:h9"
end
