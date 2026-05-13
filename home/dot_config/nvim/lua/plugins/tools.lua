-- Shared dependencies and utility plugins
return {
  -- Plenary (required by many plugins)
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },

  -- Web devicons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
      })
    end,
  },

  -- UI component library
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
}
