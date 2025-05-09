-- This is a kickstart config for Neovim.
--
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.env.PATH = os.getenv 'PATH'

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
--
--
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true
-- Set default size for the file tree window

vim.opt.termguicolors = true

-- Fold configs
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<A-Left>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<A-Right>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<A-Down>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<A-Up>', '<C-w>k', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<A-S-Left>', '<cmd>bN<CR>', { desc = 'Move buffer to the left' })
vim.keymap.set('n', '<A-S-Right>', '<cmd>bn<CR>', { desc = 'Move buffer to the right' })
vim.keymap.set('n', '<CR>', 'm`o<Esc>``')
vim.keymap.set('n', '<S-CR>', 'm`O<Esc>``')
vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>', '<cmd>move-2<CR>', { desc = 'Move current line up' })
vim.keymap.set('n', '<C-Down>', '<cmd>move+<CR>', { desc = 'Move current line down' })
vim.keymap.set('v', '<C-Up>', ":m '<-2'<CR>gv=gv", { desc = 'Move selected lines up' })
vim.keymap.set('v', '<C-Down>', ":m '>+1'<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent selected lines right' })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent selected lines left' })

local scroll_lines = 5

-- Map PageDown to scroll down by 'scroll_lines'
-- 'n' stands for Normal mode
-- '<C-e>' is the command to scroll the window down one line
-- We prepend the count to scroll multiple lines
vim.keymap.set('n', '<PageDown>', scroll_lines .. '<C-e>', {
  noremap = true, -- Use non-recursive mapping
  silent = true, -- Don't show the command being executed
  desc = 'Scroll window down by ' .. scroll_lines .. ' lines', -- Optional description
})

-- Map PageUp to scroll up by 'scroll_lines'
-- '<C-y>' is the command to scroll the window up one line
vim.keymap.set('n', '<PageUp>', scroll_lines .. '<C-y>', {
  noremap = true,
  silent = true,
  desc = 'Scroll window up by ' .. scroll_lines .. ' lines',
})
-- Apply the same mapping for Visual and Select modes
-- 'v' for Visual mode, 's' for Select mode
vim.keymap.set({ 'v', 's' }, '<PageDown>', scroll_lines .. '<C-e>', { noremap = true, silent = true })
vim.keymap.set({ 'v', 's' }, '<PageUp>', scroll_lines .. '<C-y>', { noremap = true, silent = true })
-- Map a key to copy the current file path to the clipboard

vim.keymap.set('n', '<leader>cp', [[:let @+ = expand('%:p')<CR>]], { desc = 'Copy current file path', noremap = true, silent = true })
-- Open file explorer on the side
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })
-- SnipRun keymaps
vim.keymap.set('v', '<leader>r', '<Plug>SnipRun', { silent = true })
vim.keymap.set('n', '<leader>r', '<Plug>SnipRun', { silent = true })
vim.keymap.set('n', '<leader>f', '<Plug>SnipRunOperator', { silent = true })
vim.keymap.set('n', '<leader>o', function()
  require('illuminate').goto_next_reference()
end, { desc = 'Go to next reference of underline text' })
vim.keymap.set('n', '<leader>O', function()
  require('illuminate').goto_prev_reference()
end, { desc = 'Go to previous reference of underline text' })
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_augroup('AutoSave', { clear = true })
-- Create an augroup for autosave

-- Define the autocommand for autosaving
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertLeave' }, {
  group = 'AutoSave',
  pattern = '*',
  command = 'silent! wall',
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.rb',
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.autopairs',

  -- This is where the plugins are defined: /lua/custom/plugins/init.lua
  { import = 'custom.plugins' },
}
ui = {
  icons = vim.g.have_nerd_font and {} or {
    cmd = '⌘',
    config = '🛠',
    event = '📅',
    ft = '📂',
    init = '⚙',
    keys = '🗝',
    plugin = '🔌',
    runtime = '💻',
    require = '🌙',
    source = '📄',
    start = '🚀',
    task = '📌',
    lazy = '💤 ',
  },
}

vim.cmd [[colorscheme dracula]]
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
