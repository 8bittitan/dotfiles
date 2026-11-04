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

local folds_group = augroup('RememberFolds')

aucmd('BufWinLeave', {
  group = folds_group,
  pattern = { '*.*' },
  command = 'mkview',
})

aucmd('BufWinEnter', {
  group = folds_group,
  pattern = { '*.*' },
  command = 'silent! loadview',
})

local progress = vim.defaulttable()
vim.api.nvim_create_autocmd('LspProgress', {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= 'table' then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ('[%3d%%] %s%s'):format(
            value.kind == 'end' and 100 or value.percentage or 100,
            value.title or '',
            value.message and (' **%s**'):format(value.message) or ''
          ),
          done = value.kind == 'end',
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(table.concat(msg, '\n'), 'info', {
      id = 'lsp_progress',
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and ' '
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
