-- Mouse-friendly and clickable UI plugins
return {
  -- bufferline.nvim - Clickable buffer/tab bar
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          themable = true,
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = "bdelete! %d",
          indicator = {
            icon = "|",
            style = "icon",
          },
          buffer_close_icon = "x",
          modified_icon = "*",
          close_icon = "x",
          left_trunc_marker = "<",
          right_trunc_marker = ">",
          max_name_length = 30,
          max_prefix_length = 30,
          tab_size = 21,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and "E " or "W "
            return " " .. icon .. count
          end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          separator_style = "slant",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
        },
      })
    end,
  },

  -- dropbar.nvim - Clickable breadcrumb navigation bar
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      require("dropbar").setup({
        bar = {
          enable = function(buf, win, _)
            -- Prevent E36 "Not enough room" by skipping winbar in small windows
            if not vim.api.nvim_win_is_valid(win)
              or vim.api.nvim_win_get_height(win) <= 3
              or vim.fn.win_gettype(win) ~= ""
            then
              return false
            end
            return vim.bo[buf].buftype == ""
          end,
        },
        icons = {
          enable = true,
        },
        menu = {
          quick_navigation = true,
        },
      })
    end,
  },

  -- dressing.nvim - Better vim.ui.select and vim.ui.input
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          enabled = true,
          default_prompt = "Input:",
          title_pos = "center",
          insert_only = true,
          start_in_insert = true,
          border = "rounded",
          relative = "cursor",
          prefer_width = 40,
          width = nil,
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },
          buf_options = {},
          win_options = {
            winblend = 10,
            wrap = false,
          },
          mappings = {
            n = {
              ["<Esc>"] = "Close",
              ["<CR>"] = "Confirm",
            },
            i = {
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
              ["<Up>"] = "HistoryPrev",
              ["<Down>"] = "HistoryNext",
            },
          },
        },
        select = {
          enabled = true,
          backend = { "telescope", "builtin" },
          trim_prompt = true,
          telescope = require("telescope.themes").get_dropdown({}),
          builtin = {
            border = "rounded",
            relative = "editor",
            buf_options = {},
            win_options = {
              winblend = 10,
              cursorline = true,
              cursorlineopt = "both",
            },
            width = nil,
            max_width = { 140, 0.8 },
            min_width = { 40, 0.2 },
            height = nil,
            max_height = 0.9,
            min_height = { 10, 0.2 },
            mappings = {
              ["<Esc>"] = "Close",
              ["<C-c>"] = "Close",
              ["<CR>"] = "Confirm",
            },
          },
        },
      })
    end,
  },

  -- nvim-scrollbar - Clickable scrollbar with diagnostics
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("scrollbar").setup({
        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000,
        max_lines = false,
        hide_if_all_visible = false,
        throttle_ms = 100,
        handle = {
          text = " ",
          blend = 30,
          color = nil,
          color_nr = nil,
          highlight = "CursorColumn",
          hide_if_all_visible = true,
        },
        marks = {
          Cursor = { text = "*", priority = 0, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "Normal" },
          Search = { text = { "-", "=" }, priority = 1, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "Search" },
          Error = { text = { "-", "=" }, priority = 2, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "DiagnosticVirtualTextError" },
          Warn = { text = { "-", "=" }, priority = 3, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "DiagnosticVirtualTextWarn" },
          Info = { text = { "-", "=" }, priority = 4, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "DiagnosticVirtualTextInfo" },
          Hint = { text = { "-", "=" }, priority = 5, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "DiagnosticVirtualTextHint" },
          Misc = { text = { "-", "=" }, priority = 6, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "Normal" },
          GitAdd = { text = "|", priority = 7, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "GitSignsAdd" },
          GitChange = { text = "|", priority = 7, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "GitSignsChange" },
          GitDelete = { text = "_", priority = 7, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "GitSignsDelete" },
        },
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true,
          handle = true,
          search = false,
        },
      })
    end,
  },
}
