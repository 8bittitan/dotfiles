local function augroup(name)
  return vim.api.nvim_create_augroup('group' .. name, { clear = true })
end
local aucmd = vim.api.nvim_create_autocmd

aucmd('BufEnter', {
  pattern = { '*.zsh', '*.sh' },
  group = augroup('zsh_as_bash'),
  command = 'silent! set filetype=sh',
})

aucmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

aucmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup('DisableEslintOnNodeModules'),
  pattern = { '**/node_modules/**', 'node_modules', '/node_modules/' },
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

aucmd({ 'BufEnter' }, {
  callback = function()
    vim.cmd('set formatoptions-=cro')
    vim.cmd('setlocal formatoptions-=cro')
  end,
})

-- close some filetypes with <q>
aucmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'checkhealth',
    'help',
    'lspinfo',
    'qf',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Quickfix List
aucmd('FileType', {
  group = augroup('qf'),
  pattern = 'qf',
  callback = function()
    vim.cmd('set nobuflisted')
  end,
})

aucmd('BufReadPost', {
  pattern = 'quickfix',
  command = [[nnoremap <buffer> <CR> <CR><cmd>cclose<CR>]],
})

aucmd({ 'BufRead' }, {
  group = augroup('LazyLoadedGitPlugins'),
  callback = function()
    vim.fn.jobstart({ 'git', '-C', vim.fn.getcwd(), 'rev-parse' }, {
      on_exit = function(_, return_code)
        if return_code == 0 then
          vim.schedule(function()
            require('lazy').load({ plugins = { 'mini-git' } })
          end)
        end
      end,
    })
  end,
})

aucmd('User', {
  pattern = 'MiniGitUpdated',
  callback = function(data)
    local summary = vim.b[data.buf].minigit_summary
    vim.b[data.buf].minigit_summary_string = summary.head_name or ''
  end,
})

aucmd({ 'WinEnter', 'BufEnter' }, {
  group = augroup('MyStatusLine'),
  pattern = '*',
  callback = function()
    vim.o.statusline = "%!v:lua.require'status-line'.load()"
  end,
})
