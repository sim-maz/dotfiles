return {
  {
    'michaelb/sniprun',
    branch = 'master',

    build = 'sh install.sh',
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

    config = function()
      require('sniprun').setup {
        -- your options
      }
    end,
  },
  {
    'otavioschwanck/arrow.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    opts = {
      show_icons = true,
      leader_key = ';', -- Recommended to be a single key
      buffer_leader_key = 'm', -- Per Buffer Mappings
    },
  },
  {
    'sim-maz/codeowners.nvim',
    config = function()
      require('codeowners').setup()
    end,
  },
  {
    'sim-maz/copycat.nvim',
    config = function()
      require('copycat').setup {
        notification_plugin = 'mini.notify',
      }
    end,
  },
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
  },
  --nvim.other
  {
    'rgroli/other.nvim',
    lazy = false,
    config = function()
      require('other-nvim').setup {
        mappings = {
          'golang',
          'python',
          {
            pattern = '/app/(.*)/(.*).rb',
            target = {
              { context = 'test', target = '/spec/%1/%2_spec.rb' },
            },
          },
          {
            pattern = '(.+)/spec/(.*)/(.*)_spec.rb',
            target = {
              { target = '%1/app/%2/%3.rb' },
            },
          },
        },
      }
    end,
    keys = {
      {
        '<leader>co',
        function()
          require('other-nvim').open()
        end,
        mode = 'n',
        desc = '[C]ode [o]ther spec file in same window',
      },
      {
        '<leader>cO',
        function()
          require('other-nvim').openVSplit()
        end,
        mode = 'n',
        desc = '[C]ode [O]ther spec file in split window',
      },
    },
  },
  { 'elliotxx/copypath.nvim' },
  {
    'sim-maz/show-type.nvim',
    dependencies = { 'echasnovski/mini.nvim' },
    opts = {
      notification_provider = 'mini.notify',
    },
  },
  {
    'atiladefreitas/lazyclip',
    config = function()
      require('lazyclip').setup {
        -- your custom config here (optional)
      }
    end,
    keys = {
      { '<leader>Cw', desc = 'Open Clipboard Manager' },
    },
    -- Optional: Load plugin when yanking text
    event = { 'TextYankPost' },
  },
  { 'chrisgrieser/nvim-genghis' },
  {
    'chrisgrieser/nvim-early-retirement',
    config = true,
    event = 'VeryLazy',
  },
}