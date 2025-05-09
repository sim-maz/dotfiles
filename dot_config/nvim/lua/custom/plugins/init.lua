return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = '^1.0.0',
      },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!
      local telescope = require 'telescope'
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}

        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

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
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
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
  {
    'f-person/git-blame.nvim',
    lazy = false,
    config = function()
      require('gitblame').setup {
        enabled = true, -- if you want to enable the plugin
        message_template = ' <summary> • <date> • <author> • <<sha>>', -- template for the blame message, check the Message template section for more options
        date_format = '%m-%d-%Y %H:%M:%S', -- template for the date, check Date format section for more options
        virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        sections = {
          lualine_c = {
            {
              'filename',
              path = 0, -- 0: Just the filename, 1: Relative path, 2: Absolute path
            },
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
            },
          },
          lualine_x = {
            {
              'filetype',
              colored = true, -- Displays filetype icon in color if set to true
              icon_only = true, -- Display only an icon for filetype
              icon = { align = 'right' }, -- Align the icon to the right
            },
          },
          lualine_y = {
            function()
              local owner = require('codeowners').get_buf_owner()
              return owner
            end,
          },
        },
        options = {
          theme = 'dracula-nvim',
        },
      }
    end,
  },
  {
    'RRethy/vim-illuminate',
    providers = { 'nvim-lsp', 'treesitter', 'regex' },
  },
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    -- fill any relevant options here
  },
},
--  {
--    'nvim-neo-tree/neo-tree.nvim',
--    branch = 'v3.x',
--    dependencies = {
--      'nvim-lua/plenary.nvim',
--      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
--      'MunifTanjim/nui.nvim',
--      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
--      {
--        's1n7ax/nvim-window-picker', -- for open_with_window_picker keymaps
--        version = '2.*',
--        config = function()
--          require('window-picker').setup {
--            filter_rules = {
--              include_current_win = false,
--              autoselect_one = true,
--              -- filter using buffer options
--              bo = {
--                -- if the file type is one of following, the window will be ignored
--                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
--                -- if the buffer type is one of following, the window will be ignored
--                buftype = { 'terminal', 'quickfix' },
--              },
--            },
--          }
--        end,
--      },
--    },
--    lazy = false,
--    -----Instead of using `config`, you can use `opts` instead, if you'd like:
--    -----@module "neo-tree"
--    -----@type neotree.Config
--    --opts = {},
--    config = function()
--      -- If you want icons for diagnostic errors, you'll need to define them somewhere.
--      -- In Neovim v0.10+, you can configure them in vim.diagnostic.config(), like:
--      --
--      -- vim.diagnostic.config({
--      --   signs = {
--      --     text = {
--      --       [vim.diagnostic.severity.ERROR] = '',
--      --       [vim.diagnostic.severity.WARN] = '',
--      --       [vim.diagnostic.severity.INFO] = '',
--      --       [vim.diagnostic.severity.HINT] = '󰌵',
--      --     },
--      --   }
--      -- })
--      --
--      -- In older versions, you can define the signs manually:
--      -- vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
--      -- vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
--      -- vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
--      -- vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
--
--      require('neo-tree').setup {
--        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
--        popup_border_style = 'rounded',
--        enable_git_status = true,
--        source_selector = {
--          winbar = true,
--          padding = 0,
--          separator_active = '▌',
--          truncation_character = '..',
--          highlight_tab_active = 'NeoTreeTabActive',
--        },
--        enable_diagnostics = true,
--        open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' }, -- when opening files, do not use windows containing these filetypes or buftypes
--        open_files_using_relative_paths = false,
--        sort_case_insensitive = false, -- used when sorting files and directories in the tree
--        sort_function = nil, -- use a custom function for sorting files and directories in the tree
--        -- sort_function = function (a,b)
--        --       if a.type == b.type then
--        --           return a.path > b.path
--        --       else
--        --           return a.type > b.type
--        --       end
--        --   end , -- this sorts files and directories descendantly
--        default_component_configs = {
--          container = {
--            enable_character_fade = true,
--          },
--          indent = {
--            indent_size = 2,
--            padding = 1, -- extra padding on left hand side
--            -- indent guides
--            with_markers = true,
--            indent_marker = '│',
--            last_indent_marker = '└',
--            highlight = 'NeoTreeIndentMarker',
--            -- expander config, needed for nesting files
--            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
--            expander_collapsed = '',
--            expander_expanded = '',
--            expander_highlight = 'NeoTreeExpander',
--          },
--          modified = {
--            symbol = '[+]',
--            highlight = 'NeoTreeModified',
--          },
--          name = {
--            trailing_slash = false,
--            use_git_status_colors = true,
--            highlight = 'NeoTreeFileName',
--          },
--          git_status = {
--            symbols = {
--              -- Change type
--              added = '✚', -- or "✚", but this is redundant info if you use git_status_colors on the name
--              modified = '~', -- or "", but this is redundant info if you use git_status_colors on the name
--              deleted = '✖', -- this can only be used in the git_status source
--              renamed = 'R', -- this can only be used in the git_status source
--              -- Status type
--              untracked = '',
--              ignored = ' ',
--              unstaged = ' ',
--              staged = ' ',
--              conflict = 'conflict',
--            },
--          },
--          -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
--          file_size = {
--            enabled = true,
--            width = 12, -- width of the column
--            required_width = 64, -- min width of window required to show this column
--          },
--          type = {
--            enabled = true,
--            width = 10, -- width of the column
--            required_width = 122, -- min width of window required to show this column
--          },
--          last_modified = {
--            enabled = true,
--            width = 20, -- width of the column
--            required_width = 88, -- min width of window required to show this column
--          },
--          created = {
--            enabled = true,
--            width = 20, -- width of the column
--            required_width = 110, -- min width of window required to show this column
--          },
--          symlink_target = {
--            enabled = false,
--          },
--        },
--        -- A list of functions, each representing a global custom command
--        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
--        -- see `:h neo-tree-custom-commands-global`
--        commands = {},
--        window = {
--          position = 'left',
--          width = 30,
--          mapping_options = {
--            noremap = true,
--            nowait = true,
--          },
--          mappings = {
--            ['<space>'] = {
--              'toggle_node',
--              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
--            },
--            ['<2-LeftMouse>'] = 'open',
--            ['<cr>'] = 'open',
--            ['<esc>'] = 'cancel', -- close preview or floating neo-tree window
--            ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
--            -- Read `# Preview Mode` for more information
--            ['l'] = 'focus_preview',
--            ['S'] = 'open_split',
--            ['s'] = 'open_vsplit',
--            -- ["S"] = "split_with_window_picker",
--            -- ["s"] = "vsplit_with_window_picker",
--            ['t'] = 'open_tabnew',
--            -- ["<cr>"] = "open_drop",
--            -- ["t"] = "open_tab_drop",
--            ['w'] = 'open_with_window_picker',
--            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
--            ['C'] = 'close_node',
--            -- ['C'] = 'close_all_subnodes',
--            ['z'] = 'close_all_nodes',
--            --["Z"] = "expand_all_nodes",
--            ['a'] = {
--              'add',
--              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
--              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
--              config = {
--                show_path = 'none', -- "none", "relative", "absolute"
--              },
--            },
--            ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
--            ['d'] = 'delete',
--            ['r'] = 'rename',
--            ['b'] = 'rename_basename',
--            ['y'] = 'copy_to_clipboard',
--            ['x'] = 'cut_to_clipboard',
--            ['p'] = 'paste_from_clipboard',
--            ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
--            -- ["c"] = {
--            --  "copy",
--            --  config = {
--            --    show_path = "none" -- "none", "relative", "absolute"
--            --  }
--            --}
--            ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
--            ['q'] = 'close_window',
--            ['R'] = 'refresh',
--            ['?'] = 'show_help',
--            ['<'] = 'prev_source',
--            ['>'] = 'next_source',
--            ['i'] = 'show_file_details',
--            -- ["i"] = {
--            --   "show_file_details",
--            --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
--            --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
--            --   -- config = {
--            --   --   created_format = "%Y-%m-%d %I:%M %p",
--            --   --   modified_format = "relative", -- equivalent to the line below
--            --   --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
--            --   -- }
--            -- },
--          },
--        },
--        nesting_rules = {},
--        filesystem = {
--          find_by_full_path_words = false,
--          filtered_items = {
--            visible = false, -- when true, they will just be displayed differently than normal items
--            hide_dotfiles = true,
--            hide_gitignored = true,
--            hide_hidden = true, -- only works on Windows for hidden files/directories
--            hide_by_name = {
--              --"node_modules"
--            },
--            hide_by_pattern = { -- uses glob style patterns
--              --"*.meta",
--              --"*/src/*/tsconfig.json",
--            },
--            always_show = { -- remains visible even if other settings would normally hide it
--              --".gitignored",
--            },
--            always_show_by_pattern = { -- uses glob style patterns
--              --".env*",
--            },
--            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
--              --".DS_Store",
--              --"thumbs.db"
--            },
--            never_show_by_pattern = { -- uses glob style patterns
--              --".null-ls_*",
--            },
--          },
--          follow_current_file = {
--            enabled = true, -- This will find and focus the file in the active buffer every time
--            --               -- the current file is changed while the tree is open.
--            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
--          },
--          group_empty_dirs = false, -- when true, empty folders will be grouped together
--          hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
--          -- in whatever position is specified in window.position
--          -- "open_current",  -- netrw disabled, opening a directory opens within the
--          -- window like netrw would, regardless of window.position
--          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
--          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
--          -- instead of relying on nvim autocmd events.
--          window = {
--            mappings = {
--              ['<bs>'] = 'navigate_up',
--              ['.'] = 'set_root',
--              ['H'] = 'toggle_hidden',
--              ['/'] = 'fuzzy_finder',
--              ['D'] = 'fuzzy_finder_directory',
--              ['#'] = 'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
--              -- ["D"] = "fuzzy_sorter_directory",
--              ['f'] = 'filter_on_submit',
--              ['<c-x>'] = 'clear_filter',
--              ['[g'] = 'prev_git_modified',
--              [']g'] = 'next_git_modified',
--              ['o'] = {
--                'show_help',
--                nowait = false,
--                config = { title = 'Order by', prefix_key = 'o' },
--              },
--              ['oc'] = { 'order_by_created', nowait = false },
--              ['od'] = { 'order_by_diagnostics', nowait = false },
--              ['og'] = { 'order_by_git_status', nowait = false },
--              ['om'] = { 'order_by_modified', nowait = false },
--              ['on'] = { 'order_by_name', nowait = false },
--              ['os'] = { 'order_by_size', nowait = false },
--              ['ot'] = { 'order_by_type', nowait = false },
--              -- ['<key>'] = function(state) ... end,
--            },
--            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
--              ['<down>'] = 'move_cursor_down',
--              ['<C-n>'] = 'move_cursor_down',
--              ['<up>'] = 'move_cursor_up',
--              ['<C-p>'] = 'move_cursor_up',
--              ['<esc>'] = 'close',
--              -- ['<key>'] = function(state, scroll_padding) ... end,
--            },
--          },
--
--          commands = {}, -- Add a custom command or override a global one using the same function name
--        },
--        buffers = {
--          follow_current_file = {
--            enabled = true, -- This will find and focus the file in the active buffer every time
--            --              -- the current file is changed while the tree is open.
--            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
--          },
--          group_empty_dirs = true, -- when true, empty folders will be grouped together
--          show_unloaded = true,
--          window = {
--            mappings = {
--              ['d'] = 'buffer_delete',
--              ['bd'] = 'buffer_delete',
--              ['<bs>'] = 'navigate_up',
--              ['.'] = 'set_root',
--              ['o'] = {
--                'show_help',
--                nowait = false,
--                config = { title = 'Order by', prefix_key = 'o' },
--              },
--              ['oc'] = { 'order_by_created', nowait = false },
--              ['od'] = { 'order_by_diagnostics', nowait = false },
--              ['om'] = { 'order_by_modified', nowait = false },
--              ['on'] = { 'order_by_name', nowait = false },
--              ['os'] = { 'order_by_size', nowait = false },
--              ['ot'] = { 'order_by_type', nowait = false },
--            },
--          },
--        },
--        git_status = {
--          window = {
--            position = 'float',
--            mappings = {
--              ['A'] = 'git_add_all',
--              ['gu'] = 'git_unstage_file',
--              ['ga'] = 'git_add_file',
--              ['gr'] = 'git_revert_file',
--              ['gc'] = 'git_commit',
--              ['gp'] = 'git_push',
--              ['gg'] = 'git_commit_and_push',
--              ['o'] = {
--                'show_help',
--                nowait = false,
--                config = { title = 'Order by', prefix_key = 'o' },
--              },
--              ['oc'] = { 'order_by_created', nowait = false },
--              ['od'] = { 'order_by_diagnostics', nowait = false },
--              ['om'] = { 'order_by_modified', nowait = false },
--              ['on'] = { 'order_by_name', nowait = false },
--              ['os'] = { 'order_by_size', nowait = false },
--              ['ot'] = { 'order_by_type', nowait = false },
--            },
--          },
--        },
--      }
--    end,
--  },
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

  --Github Copilot
  { 'github/copilot.vim' },

  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {}
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        ruby_lsp = {
          mason = false,
          cmd = { 'mise', 'x', '--', 'ruby-lsp' },
          filetypes = { 'ruby' },
          root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git'),
          settings = {},
        },
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Down>'] = cmp.mapping.select_next_item(),
          ['<Up>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' },
        },
      }
    end,
  },

  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   config = function()
  --     ---@diagnostic disable-next-line: missing-fields
  --     require('tokyonight').setup {
  --       styles = {
  --         comments = { italic = false }, -- Disable italics in comments
  --       },
  --     }
  --
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-moon'
  --   end,
  -- },
  { 'Mofiqul/dracula.nvim', name = 'dracula' },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }
      require('mini.bracketed').setup()
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
      require('mini.move').setup {
        -- Move lines up and down with Alt-j/k (Alt is Meta)
        mappings = {
          left = '<C-A-Left>',
          right = '<C-A-Right>',
          down = '<C-A-Down>',
          up = '<C-A-Up>',
        },
      }
      require('mini.pairs').setup()

      require('mini.notify').setup()
      -- require('mini.indentscope').setup()
      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }
      --
      -- -- You can configure sections in the statusline by overriding their
      -- -- default behavior. For example, here we set the section for
      -- -- cursor location to LINE:COLUMN
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'ruby', 'hcl', 'terraform' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    
    config = function()
      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },
}
