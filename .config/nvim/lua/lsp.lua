local default_capabilities = require('blink.cmp').get_lsp_capabilities({}, true)

default_capabilities.textDocument.completion.completionItem.snippetSupport = true
default_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

vim.lsp.config('*', {
  on_attach = function(_, bufnr)
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
  end,
  capabilities = default_capabilities,
  flags = { debounce_text_changes = 200 },
})

vim.lsp.config('laravel_lsp', {
  cmd = { 'laravel-lsp' },
  filetypes = { 'php', 'blade' },
  root_markers = { 'artisan', 'composer.json', '.git' },
})

vim.lsp.enable('rust_analyzer', false)

vim.lsp.enable({ 'zls', 'elixirls', 'laravel_lsp', 'tsc', 'vue_ls', 'oxlint', 'buf_ls' })

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function()
    local wk = require('which-key')

    local goto_definition_in_split = function()
      vim.cmd('vsplit')
      vim.lsp.buf.definition()
    end

    wk.add({
      { 'K', '<cmd>lua vim.lsp.buf.hover({border = "single"})<CR>', desc = 'Show hover info' },
      { 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', desc = '[G]oto [D]efinition' },
      { 'gs', goto_definition_in_split, desc = '[G]oto definition in [S]plit' },
      {
        'gr',
        function()
          Snacks.picker.lsp_references()
        end,
        desc = '[G]oto [R]eferences',
      },
      { 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', desc = '[G]oto [I]mplementation' },
      { 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', desc = '[C]ode [A]ctions' },
      { 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', desc = '[R]e[n]ame' },
      { 'df', '<cmd>lua vim.diagnostic.open_float()<CR>', desc = '[D]iagnostics [F]loat' },
      {
        'dq',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = '[D]iagnostics [Q]uickfix',
      },
      {
        '<leader>ds',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = '[D]ocument [S]ymbol',
      },
      { '<leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>', desc = '[L]sp [F]ormat' },
    })
  end,
})

local severity = vim.diagnostic.severity

-- local signs = {
--   [severity.ERROR] = '󰅚 ',
--   [severity.WARN] = '󰀪 ',
--   [severity.INFO] = '󰋽 ',
--   [severity.HINT] = '󰌶 ',
-- }

local signs = {
  [severity.ERROR] = 'E',
  [severity.WARN] = 'W',
  [severity.INFO] = 'I',
  [severity.HINT] = 'H',
}

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  -- underline = { severity = vim.diagnostic.severity.ERROR },
  underline = true,
  signs = {
    text = signs,
  },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    -- prefix = '●',
    prefix = function(diagnostic)
      return '[' .. signs[diagnostic.severity] .. ']'
    end,
    hl_mode = 'combine',
    -- prefix = function(diagnostic)
    --   return signs[diagnostic.severity]
    -- end,
    -- format = function(diagnostic)
    --   local diagnostic_message = {
    --     [severity.ERROR] = diagnostic.message,
    --     [severity.WARN] = diagnostic.message,
    --     [severity.INFO] = diagnostic.message,
    --     [severity.HINT] = diagnostic.message,
    --   }
    --   return diagnostic_message[diagnostic.severity]
    -- end,
  },
})
