return {
  {
    'rktjmp/lush.nvim',
    lazy = false,
    priority = 1003,
  },

  -- Upstream is mis-packaged: the theme lives in a nested `serendipity.nvim/`
  -- subdir and the `colors/` entry file has a broken `require` path, so we
  -- add the nested dir to `rtp` and apply lush directly.
  {
    'AustinMay1/Serendipity.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    lazy = false,
    priority = 1002,
    config = function()
      local nested = vim.fn.stdpath('data') .. '/lazy/Serendipity.nvim/serendipity.nvim'
      vim.opt.rtp:append(nested)

      vim.o.background = 'dark'
      vim.g.colors_name = 'serendipity'
      require('lush')(require('lush_theme.serendipity_midnight'))
    end,
  },
}
