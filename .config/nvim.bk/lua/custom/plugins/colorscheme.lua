return {

  -- Dracula for dark mode
  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
    name = 'dracula',
  },

  -- Github light high contrast for light mode
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    priority = 1000,
  },

  -- Auto theme detection
  {
    'f-person/auto-dark-mode.nvim',
    priority = 1000,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.o.background = 'dark'
        vim.cmd 'colorscheme dracula'

        vim.defer_fn(function()
          vim.cmd 'colorscheme dracula'
        end, 10)
      end,

      set_light_mode = function()
        vim.o.background = 'light'
        vim.cmd 'colorscheme github_light'

        vim.defer_fn(function()
          vim.cmd 'colorscheme github_light'
        end, 10)
      end,
    },
  },
}
