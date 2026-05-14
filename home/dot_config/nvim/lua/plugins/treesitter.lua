-- Treesitter for syntax highlighting
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      -- Windows-specific configuration
      local is_windows = (vim.uv or vim.loop).os_uname().sysname == "Windows_NT"
      
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "query",
          "javascript", "typescript", "python", "rust",
          "go", "html", "css", "json", "yaml",
          "markdown", "markdown_inline", "bash",
          "cpp", "cmake", "make", "dockerfile", "toml"
        },
        auto_install = true,
        sync_install = false,
        ignore_install = {},
        
        -- Windows-specific compiler configuration
        compilers = is_windows and { "clang", "gcc", "zig" } or nil,
        prefer_git = not is_windows,
        
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          -- Disable for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall((vim.uv or vim.loop).fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        
        indent = {
          enable = true,
          -- Disable for problematic languages
          disable = { "python", "yaml" },
        },
        
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },

  -- nvim-treesitter-textobjects - Treesitter-based text objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Select outer function" },
              ["if"] = { query = "@function.inner", desc = "Select inner function" },
              ["ac"] = { query = "@class.outer", desc = "Select outer class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner class" },
              ["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner parameter" },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = { query = "@function.outer", desc = "Next function start" },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]a"] = { query = "@parameter.inner", desc = "Next parameter" },
            },
            goto_next_end = {
              ["]F"] = { query = "@function.outer", desc = "Next function end" },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@function.outer", desc = "Previous function start" },
              ["[c"] = { query = "@class.outer", desc = "Previous class start" },
              ["[a"] = { query = "@parameter.inner", desc = "Previous parameter" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@function.outer", desc = "Previous function end" },
              ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sp"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
            },
            swap_previous = {
              ["<leader>sP"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
            },
          },
        },
      })
    end,
  },
}
