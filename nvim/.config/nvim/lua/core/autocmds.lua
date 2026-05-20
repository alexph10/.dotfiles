-- Autocommands

-- Auto-save: save modified buffers on focus lost, idle, or buffer leave
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
})

-- Set up autocmds for file system events
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- Automatically refresh file tree when files change
vim.api.nvim_create_autocmd({ "BufWritePost", "BufNewFile", "BufDelete" }, {
  pattern = "*",
  callback = function()
    -- Refresh Neo-tree if it's open
    local neo_tree = require("neo-tree.command")
    if neo_tree then
      vim.schedule(function()
        neo_tree.execute({ action = "refresh" })
      end)
    end
  end,
})

-- Watch for external file changes and refresh
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO)
    -- Refresh Neo-tree
    local neo_tree = require("neo-tree.command")
    if neo_tree then
      vim.schedule(function()
        neo_tree.execute({ action = "refresh" })
      end)
    end
  end,
})

-- Enhanced file system monitoring for real-time updates
vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged", "BufEnter" }, {
  pattern = "*",
  callback = function()
    -- Trigger project root detection
    vim.schedule(function()
      local project_nvim = require("project_nvim.project")
      if project_nvim then
        project_nvim.set_pwd()
      end
    end)
  end,
})

-- Monitor for new files created externally (like with touch command)
vim.api.nvim_create_autocmd({ "FocusGained" }, {
  pattern = "*",
  callback = function()
    -- Force refresh of file tree and project detection
    vim.schedule(function()
      -- Refresh Neo-tree
      local neo_tree = require("neo-tree.command")
      if neo_tree then
        neo_tree.execute({ action = "refresh" })
      end
      
      -- Update project root if needed
      local project_nvim = require("project_nvim.project")
      if project_nvim then
        project_nvim.set_pwd()
      end
    end)
  end,
})

-- Transparent background configuration
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Make background transparent
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLineSel", { bg = "none" })
    vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
    vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    
    -- Make Neo-tree transparent
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })
    
    -- Make Telescope transparent
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
    
    -- Make popup menus transparent
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "none" })
    
    -- Make which-key transparent
    vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "none" })
    
    -- Make diagnostic floats transparent
    vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { bg = "none" })
    vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { bg = "none" })
    vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { bg = "none" })
    vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { bg = "none" })
  end,
})

-- Apply transparent background immediately
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalFloat guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight StatusLine guibg=NONE ctermbg=NONE
  highlight StatusLineNC guibg=NONE ctermbg=NONE
  highlight TabLine guibg=NONE ctermbg=NONE
  highlight TabLineFill guibg=NONE ctermbg=NONE
  highlight TabLineSel guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
  highlight WinSeparator guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])
