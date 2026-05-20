-- UI plugins: dashboard, statusline, indent guides, which-key
return {
  -- Alpha dashboard for home page
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- ASCII art from actual hill1.jpg image
      dashboard.section.header.val = {
        "%%%#+*+*******************=+**%##***#########*#####**#+*###*#############%%##%%%",
        "%%%#*+********************++**###**#################*####################%%##%%%",
        "%%###*************************###*##############*#####**##########%%%%##%%%##%%%",
        "%%*###***+********************#######################++*##########%%%%%%%%%#%%%%",
        "%#####**%##*************##****#####################*#+*###########%%%%%%%%%%%%%%",
        "%##*#***%%#+************###***##########*##%######*+#**############%%%%%%%%%%%%%",
        "%##*#****#+*************#%##**#####*##############**#++############%%%%%%%%###%%",
        "%*#*#**#*++*******=******#%#***%%%##**##*#%##########+=############%%%%%%%%%%%%%",
        "#+#*******=*******=*******#%#**%%%%%####*#%#####*#*+#***###########%%%%%%%%%%%%%",
        "%**#****=*****************#%#**%%%%%%###########+#*+###############%%%%##%%%%%%%",
        "%#+*##*#=*#****************%%**%#%%#%%%%####%%%##%###%#####*#######%%%%**%%%#%%%",
        "##**##*#+******************#%##%#%%%%%%%####%%%##%########**#####%%%%%%##%%##%%%",
        "#****#*#*******************#%##%%%%%%%%%%%##%%%##%##%#####**#####%%%%%%%#%%%%%#%",
        "#+=+*##+*++**************++*%##%%%%%%%##%%##%%###%######*##*+###%%%###%%*##%%%%%",
        "#+--+##*=+-*=-+*******+**++#%##%%#%%%%##%%*#%%####+#####+###*+##%%%####**=*%#%%%",
        "#+:.-**#+::=+:+*++****+=*=+*#%%%%###%%#%%#*%%%%##%*#####*#**#-*%%%%%%%%**++%#%%%",
        "#=-:-=-+*+-=-:=*+=++**==*-=+#%%%%#%#%%%%%#*%%%%##%##****+*#+=-=%#%%#*####+*%%%%%",
        "#+=-+++===--=:-+-=++-=:-:-=+*%%#%%%#%%%%%#*%#%%#%%#*+=**=*=--=-+#%%%%#*##*%%%%%%",
        "#++=:+**=.-=**-====*-:=-.-=+*#%%%%%%%%%%%##%%%##%%#**+++=**+#*+#%##%%%*%#%%%%%%%",
        "#*==-::--=+*=**===---++==-=+**#%%%%%%%%%%##%%%%#%####**#+--=*++++*##%*=*=+%%%%%%",
        "#*#+++-=:---++**-+=++---==*#***%%%%%%%%%%#%%%%%%##**#+*#*+=*%+=+*###%##+#%##%%%#",
        "#=+##*--=====*+#*=+#=-==#++#***%%%%%%%%%%#%#%#%######*##+++*%**###*#%***%%%%%%%%",
        "######---===-*-=#*+---==*+*####%%##%%%#%%%%%%##########*+**#%+-****%#+=*##%%%%%%",
        "####*+=---=-===**#=+=*+*%**#%%#%%##%%#%%%#%%%%%%########**++%*+##++#*+=%**%###%%",
        "#*+#+-=--::=*=+==**%%*-+**#%%%%%%%#%%%%%#*#%%%%%%##%%%##**++%****+-==+*#*++#%%%%",
        "#++**#+:----==*==+*%++**##%%%%%%%%%%%%%#%%#%%%%%%##%%%%%+***#*+**#+++**##+=*%%%%",
        "#*+***+-:---#*=-*#=++#***#%%%%%%%#%%%%#%%%%#%%#%##%%%%%%###*+*+*##*+++**##+=#%%%",
        "#+++==+-..:=%#+-**=*##***#%%%%%%%%#%%%%%%%%#%%#%%%%%%####%#*+**+***#+=*+#*+*#%#%",
        "##***=-.:===+=--*+=%##**#%%%%%#%%%%#%%%#%%%%%%#%%%%#%####%#***+:-+-=*******+**#%",
        "#+++--*:++-=*+:*=--+++**#%%%%###%%%%%%%#%#%%%%%%%%%%%#######-+*+++=*%%%#***-###%",
        "#*+#+:==#*=+++-*+===+***#%%%%#%#%%%%%%##%%#%%%#%%%%%####%##*+*+=*##%#+##*%**#%#%",
        "#*++---*#*+==+:=:==+****#%%%%%%%#%%%%%#%%%%%%%%%%%%%####%%#%#*+-*####*###*###%#%",
        "##+=*::*#**+*===--**++**%%%%**%%%%%#%%#%%%%#%%%##%%%%%%%%#####*=*####%%%%++=###%",
        "%**#+:-****+*+***-+****#%%%%+*%%%%%%%%%#%%%%%%#%%%%%%%%#######*+#####%%#%***#%%%",
        "%###-=+#*+*******=-**++#%%%%**%%%%#%%%%##%%%###%%%%%%%%##%#%##**#####%%#%%%#*%##",
        "%###-=+#***+*****=+++**#%%%##*%%%%%#%##%%%%%%%%%%%%%%%%##%#%#########%%%%#%%*%%%",
        "####=**#*********+*+***%%%%%#+%%%#%%%%%##%%%%%%%##%%%%##%%%%####+####%%%##%%*%%#",
        "####*##****************%##%%%#%%%%%%%%%##%%%%%#%**%%%%%%##%#%###=***#%*%#%%%#%%#",
        "#######****************%#*%%%#%%%%%%%%%%%%%%%%%###%%%##%##%#%###****#*+#%%%%#%%%",
        "%######***************#%#*%%%##%%#%%%%%%%%%##%%%#%%%%##%%%#%#%##*+****#%*+%%#%%%",
        "%######***************#%%%%%%##%%%%@%#%%%%%%#%%%%%%#%##%%%*%#%###**####%#+%%%%%%",
        "%########***#*+*******#%%##%%###%%%%%%%%%%%%%%%%%%%%%%##%%##%%#*##*##*#%%%%%%%%%",
        "%########***#*+*******#%*##%%%%#%%%%%%%%%%%%%%%%%##%%%#*#%%%%%#*#%###%*#%%%%%%%%",
        "%%#######****#********%%+%%%*%%%%%@@@@%%%%%%%%%%%#%%%####%%%%%%*#%%%#%=#%%%%%%%%",
        "%%########************%%#%%%*%#%%%%%%%%%%%%%%%%%%%######%%##%%%##%%%*%*%%%%%%%%%",
        "%%#########**********##%%%%%#%%%%%%%%%%%%%%%%#%%%%#####%%%####%##%%@@%%%%%%%%%%%",
        "%%%#######***********#%%#%%#%%%%%%%@%%%%%%%%%%%%%%%%###%%##%%%%##%%%%%###%%%%%#*",
        "%%%########**##*******%%%%##%%#%%%@@@@%%%%%%%%%%%%%####%%#%%%%#%*%+%###**%%@%%%+",
        "#%%%#########+********#%#%%%*##%%%%%@%%%%%%%%%%%%%%##%%%%%%%%%#%%%#%**%**#%@%%%%",
        "#%%%########*=+******#%%%#%%+#%%%%%%%%%%%#%%%%%%%%%**%%%%%%%%##%%%#%#%%##*%@%%%%",
      }

      -- Menu buttons
      dashboard.section.buttons.val = {
        dashboard.button("f", "[F] Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", "[E] New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "[R] Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "[T] Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "[C] Configuration", ":e $MYVIMRC <CR>"),
        dashboard.button("q", "[Q] Quit Neovim", ":qa<CR>"),
      }

      -- Footer
      local function footer()
        local datetime = os.date("%d-%m-%Y  %H:%M:%S")
        local version = vim.version()
        local nvim_version_info = "  v" .. version.major .. "." .. version.minor .. "." .. version.patch
        return datetime .. "   " .. nvim_version_info
      end

      dashboard.section.footer.val = footer()

      -- Custom highlight groups for REALLY RED ASCII art
      vim.api.nvim_set_hl(0, "AsciiRed", { fg = "#FF0000" })
      vim.api.nvim_set_hl(0, "AsciiOrange", { fg = "#FF2200" })
      vim.api.nvim_set_hl(0, "AsciiYellow", { fg = "#FF4400" })
      vim.api.nvim_set_hl(0, "AsciiGray", { fg = "#CC0000" })
      vim.api.nvim_set_hl(0, "AsciiDark", { fg = "#880000" })
      vim.api.nvim_set_hl(0, "DashboardButtons", { fg = "#FF3333" })
      vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#FF1111" })
      
      -- Apply color highlighting based on image analysis
      dashboard.section.header.opts.hl = "AsciiRed"
      dashboard.section.buttons.opts.hl = "DashboardButtons"
      dashboard.section.footer.opts.hl = "DashboardFooter"

      -- Layout
      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      -- Disable folding on alpha buffer
      vim.cmd([[
        autocmd FileType alpha setlocal nofoldenable
      ]])

      alpha.setup(dashboard.config)
    end,
  },

  -- Which-key for keybinding help
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      
      -- Modern which-key v3 setup
      wk.setup({
        preset = "modern",
        delay = 300,
        expand = 1,
        notify = true,
        triggers = {
          { "<auto>", mode = "nxsot" },
        },
        spec = {},
        icons = {
          breadcrumb = "»",
          separator = "->",
          group = "+",
          ellipsis = "…",
          mappings = false,
          rules = {},
          colors = true,
          keys = {
            Up = "Up ",
            Down = "Down ",
            Left = "Left ",
            Right = "Right ",
            C = "Ctrl ",
            M = "Alt ",
            D = "Del ",
            S = "Shift ",
            CR = "Enter ",
            Esc = "Esc ",
            ScrollWheelDown = "ScrollDown ",
            ScrollWheelUp = "ScrollUp ",
            NL = "NL ",
            BS = "BS ",
            Space = "Space ",
            Tab = "Tab ",
            F1 = "F1",
            F2 = "F2",
            F3 = "F3",
            F4 = "F4",
            F5 = "F5",
            F6 = "F6",
            F7 = "F7",
            F8 = "F8",
            F9 = "F9",
            F10 = "F10",
            F11 = "F11",
            F12 = "F12",
          },
        },
        win = {
          border = "rounded",
          padding = { 1, 2 },
          title = true,
          title_pos = "center",
          zindex = 1000,
          bo = {},
          wo = {},
        },
        layout = {
          width = { min = 20 },
          spacing = 3,
        },
        keys = {
          scroll_down = "<c-d>",
          scroll_up = "<c-u>",
        },
        sort = { "local", "order", "group", "alphanum", "mod" },
        replace = {
          key = {
            function(key)
              return require("which-key.view").format(key)
            end,
          },
          desc = {
            { "<Plug>%(.*)%)", "%1" },
            { "^%+", "" },
            { "<[cC]md>", "" },
            { "<[cC][rR]>", "" },
            { "<[sS]ilent>", "" },
            { "^lua%s+", "" },
            { "^call%s+", "" },
            { "^:%s*", "" },
          },
        },
      })
      
      -- Register key groups
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>b", group = "Buffer" },
        { "<leader>d", group = "Debug" },
        { "<leader>g", group = "Git" },
        { "<leader>gh", group = "Git Hunks" },
        { "<leader>gt", group = "Git Toggle" },
        { "<leader>h", group = "Harpoon" },
        { "<leader>l", group = "LSP" },
        { "<leader>n", group = "New/Create" },
        { "<leader>p", group = "Project" },
        { "<leader>s", group = "Search/Flash" },
        { "<leader>t", group = "Terminal" },
        { "<leader>w", group = "Window" },
        { "<leader>x", group = "Trouble" },
        { "<leader>c", group = "Colorscheme" },
      })
    end,
  },

  -- Lualine statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = "gruvbox",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      })
    end,
  },

  -- Indent blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = { enabled = false },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      })
    end,
  },
}
