vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function()
    local wk = require('which-key')

    wk.add({
      { 'K', '<cmd>lua vim.lsp.buf.hover({border = "single"})<CR>', desc = 'Show hover info' },
      { 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', desc = '[G]oto [D]efinition' },
      { 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", desc = '[G]oto [R]eferences' },
      { 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', desc = '[G]oto [I]mplementation' },
      { 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', desc = '[C]ode [A]ctions' },
      { 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', desc = '[R]e[n]ame' },
      { 'df', '<cmd>lua vim.diagnostic.open_float()<CR>', desc = '[D]iagnostics [F]loat' },
      { 'dq', "<cmd>lua require('telescope.builtin').diagnostics{}<CR>", desc = '[D]iagnostics [Q]uickfix' },
      {
        '<leader>ds',
        "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>",
        desc = '[D]ocument [S]ymbol',
      },
      { '<leader>lf', '<cmd>lua vim.lsp.buf.format()<CR>', desc = '[L]sp [F]ormat' },
    })
  end,
})

local severity = vim.diagnostic.severity

local signs = {
  [severity.ERROR] = '󰅚 ',
  [severity.WARN] = '󰀪 ',
  [severity.INFO] = '󰋽 ',
  [severity.HINT] = '󰌶 ',
}

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = signs,
  },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    prefix = function(diagnostic)
      return signs[diagnostic.severity]
    end,
    format = function(diagnostic)
      local diagnostic_message = {
        [severity.ERROR] = diagnostic.message,
        [severity.WARN] = diagnostic.message,
        [severity.INFO] = diagnostic.message,
        [severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})
