-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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
vim.keymap.set('n', '<leader>wbe', ':%bd|e#<CR>', { desc = 'Close all buffers except current' })
vim.keymap.set('n', '<S-CR>', 'm`O<Esc>``')
vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, { noremap = true, silent = true })
vim.keymap.set('n', '<A-S-Up>', '<cmd>move-2<CR>', { desc = 'Move current line up' })
vim.keymap.set('n', '<A-S-Down>', '<cmd>move+<CR>', { desc = 'Move current line down' })
vim.keymap.set('v', '<A-S-Up>', ":m '<-2'<CR>gv=gv", { desc = 'Move selected lines up' })
vim.keymap.set('v', '<A-S-Down>', ":m '>+1'<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', '<A-S-Right>', '>gv', { desc = 'Indent selected lines right' })
vim.keymap.set('v', '<A-S-Left>', '<gv', { desc = 'Indent selected lines left' })
vim.keymap.set('n', '<A-S-<>', '>gv', { desc = 'Indent selected lines right' })
vim.keymap.set('n', '<A-S->>', '>gv', { desc = 'Indent selected lines right' })
vim.keymap.set('n', 'gt', '<cmd>ShowType<CR>', { desc = 'Show type of the symbol under the cursor' })
vim.keymap.set('n', '<leader>sw', '<cmd>FzfLua grep_cword<CR>', { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', '<cmd>FzfLua live_grep<CR>', { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sr', '<cmd>FzfLua resume<CR>', { desc = '[S]earch [R]esume' })
vim.keymap.set('v', '<leader>sw', '<cmd>FzfLua grep_visual<CR>', { desc = '[S]earch [W]ord' })
vim.keymap.set('n', '<\\>', '*', { desc = 'Search for word under cursor' })

-- git-conflict.nvim keymaps
vim.keymap.set('n', '<leader>mo', '<Plug>(git-conflict-ours)', { desc = 'Choose [O]urs in a git conflict' })
vim.keymap.set('n', '<leader>mt', '<Plug>(git-conflict-theirs)', { desc = 'Choose [T]heirs in a git conflict' })
vim.keymap.set('n', '<leader>mb', '<Plug>(git-conflict-both)', { desc = 'Choose [B]oth in a git conflict' })
vim.keymap.set('n', '<leader>mn', '<Plug>(git-conflict-none)', { desc = 'Choose [N]one in a git conflict' })
vim.keymap.set('n', '<leader>m[', '<Plug>(git-conflict-prev-conflict)', { desc = 'Go to previous git conflict' })
vim.keymap.set('n', '<leader>m]', '<Plug>(git-conflict-next-conflict)', { desc = 'Go to next git conflict' })

vim.keymap.set('n', '<leader>n', function()
  require('nvim-navbuddy').open()
end, { desc = 'Open Navbuddy' })

-- Alternative keymap for opening navbuddy at current cursor position
vim.keymap.set('n', '<leader>N', function()
  require('nvim-navbuddy').open(vim.api.nvim_get_current_win())
end, { desc = 'Open Navbuddy at current position' })

local scroll_lines = 5

-- Map PageDown to scroll down by 'scroll_lines'/
-- 'n' stands for Normal mode
-- '<C-e>' is the command to scroll the window down one line
-- We prepend the count to scroll multiple lines
vim.keymap.set('n', '<PageDown>', scroll_lines .. '<C-e>', {
  noremap = true, -- Use non-recursive mapping
  silent = true, -- Don't show the command being executed
  desc = 'Scroll window down by ' .. scroll_lines .. ' lines', -- Optional description
})

vim.keymap.set('n', '<S-Down>', scroll_lines .. '<C-e>', {
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

vim.keymap.set('n', '<S-Up>', scroll_lines .. '<C-y>', {
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
