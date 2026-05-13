return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "C:/User/alexy/Desktop/Website",
      },
    },

    -- Use telescope for pickers if you have it installed
    picker = {
      name = "telescope.nvim",
    },

    -- Completion for [[links]] and #tags
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- Note ID format: use the note title as the filename
    note_id_func = function(title)
      return title ~= nil and title:gsub(" ", "-"):lower() or tostring(os.time())
    end,

    -- Where new notes go by default
    notes_subdir = "notes",

    -- Daily notes config
    daily_notes = {
      folder = "dailies",
      date_format = "%Y-%m-%d",
    },

    ui = {
      enable = true,
    },
  },
}
