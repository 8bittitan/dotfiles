local wk = require('which-key')
local key = vim.api.nvim_set_keymap
local silent_no_remap = { noremap = true, silent = true }
local noremap = { noremap = true }

-- Telescope
wk.add({
  {
    '<leader>r',
    "<cmd>lua require('telescope.builtin').resume()<CR>",
    desc = '[R]esume last Telescope search',
  },
  {
    '<leader>fd',
    "<cmd>lua require('telescope.builtin').diagnostics()<CR>",
    desc = '[F]ind [D]iagnostics',
  },
  {
    '<leader>fb',
    "<cmd>lua require('telescope.builtin').buffers()<CR>",
    desc = '[F]ind open [B]uffers',
  },
  {
    '<leader>ff',
    "<cmd>lua require('telescope.builtin').find_files()<CR>",
    desc = '[F]ind [F]iles',
  },
  {
    '<leader>fg',
    "<cmd>lua require('telescope.builtin').live_grep()<CR>",
    desc = '[F]ind with [G]rep',
  },
  {
    '<leader>fo',
    "<cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>",
    desc = '[F]ind within [O]pen files',
  },
  {
    '<leader>fh',
    "<cmd>lua require('telescope.builtin').help_tags()<CR>",
    desc = '[F]ind [H]elp',
  },
  {
    '<leader><leader>',
    '<C-^>',
    desc = 'Switch to recent file',
  },
  {
    '<C-p>',
    '<cmd>Telescope git_files<CR>',
    desc = 'Find Git files',
  },
  {
    '<leader>fn',
    "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })<CR>",
    desc = '[F]ind [N]eovim config files',
  },
})

-- Neotree
key('n', '<C-n>', '<cmd>Neotree toggle<CR>', { noremap = false })
key('n', '<leader>bf', '<cmd>Neotree toggle buffers<CR>', { noremap = false })

-- General
key('i', '<CR>', 'v:lua.MUtils.completion_confirm()', { expr = true, noremap = true })
wk.add({
  {
    'jk',
    '<ESC>',
    noremap = true,
    mode = { 'i', 't' },
  },
})
-- key('i', 'jk', '<ESC>', noremap)
key('n', '+', '<c-a>', silent_no_remap)
key('n', '-', '<c-x>', silent_no_remap)
key('n', '<leader>/', '<cmd>noh<cr>', silent_no_remap)

vim.keymap.set('n', '<leader>w', '<cmd>w<CR>')
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>')
vim.keymap.set('n', '<leader>x', '<cmd>wq<CR>')

-- Splits
wk.add({
  { '<leader>sv', '<C-w>v', desc = 'Split window vertically' },
  { '<leader>sh', '<C-w>s', desc = 'Split window horizontally' },
  { '<leader>se', '<C-w>=', desc = 'Make splits equal size' },
  { '<leader>sx', '<cmd>close<CR>', desc = 'Close current split' },
})

wk.add({
  '<leader>cp',
  function()
    -- local path = vim.fn.expand('%:~')
    local path = vim.fn.expand('%:.')
    vim.fn.setreg('+', path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
  end,
  desc = 'Copy file path to clipboard',
})

-- Marko
vim.keymap.set('n', '"', '<cmd>Marko<CR>')
