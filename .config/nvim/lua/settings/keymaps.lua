local wk = require('which-key')
local key = vim.api.nvim_set_keymap
local silent_no_remap = { noremap = true, silent = true }

-- Snacks
wk.add({
  {
    '<leader>r',
    function()
      Snacks.picker.resume()
    end,
    desc = '[R]esume last picker search',
  },
  {
    '<leader>fb',
    function()
      Snacks.picker.buffers()
    end,
    desc = '[F]ind open [B]uffers',
  },
  {
    '<leader>ff',
    function()
      Snacks.picker.smart({ cwd = vim.fn.getcwd() })
    end,
    desc = '[F]ind [F]iles',
  },
  {
    '<leader>fg',
    function()
      Snacks.picker.grep()
    end,
    desc = '[F]ind with [G]rep',
  },
  {
    '<leader>fo',
    function()
      Snacks.picker.grep({ buffers = true })
    end,
    desc = '[F]ind within [O]pen files',
  },
  {
    '<leader>fh',
    function()
      Snacks.picker.help()
    end,
    desc = '[F]ind [H]elp',
  },
  {
    '<leader>fk',
    function()
      Snacks.picker.keymaps()
    end,
    desc = '[F]ind [K]eymaps',
  },
  {
    '<leader><leader>',
    '<C-^>',
    desc = 'Switch to recent file',
  },
  {
    '<C-p>',
    function()
      Snacks.picker.git_files()
    end,
    desc = 'Find Git files',
  },
  {
    '<leader>fn',
    function()
      Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
    end,
    desc = '[F]ind [N]eovim config files',
  },
  {
    '<leader>lg',
    function()
      Snacks.lazygit.open()
    end,
    desc = 'Open [L]azy[G]it',
  },
  {
    '<leader>gt',
    function()
      Snacks.git.blame_line()
    end,
    desc = '[G]it [T]oggle blame line',
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
key('n', '+', '<c-a>', silent_no_remap)
key('n', '-', '<c-x>', silent_no_remap)

-- Removes active search/highlight
key('n', '<leader>/', '<cmd>noh<cr>', silent_no_remap)

-- Move lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Moves lines down in visual mode' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Moves lines up in visual mode' })

-- Indents
vim.keymap.set('v', '<', '<gv', { desc = 'Unindent and keep selection' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent and keep selection' })

-- Write, quit, write + quit
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

if vim.env.REX_SESSION ~= nil and vim.env.REX_SESSION ~= '' then
  vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
  vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom split' })
  vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top split' })
  vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })
end

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
