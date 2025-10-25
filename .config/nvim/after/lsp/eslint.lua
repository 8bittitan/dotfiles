local opts = {}
local cwd = vim.fn.getcwd()

if string.find(cwd, 'AlgoliaWeb') then
  opts.rulePaths = { './_client/.eslint_rules' }
end

if string.find(cwd, '_client') then
  opts.rulePaths = { './.eslint_rules' }
end

if string.find(cwd, '_client_admin') then
  opts.rulePaths = { './eslint_rules' }
end

return {
  settings = {
    packageManager = 'yarn',
    options = opts,
  },
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        require('utils').override_lsp_notify()

        local current_diagnostics = vim.lsp.diagnostic.from(vim.diagnostic.get(bufnr))

        vim.lsp.buf.code_action({
          context = { only = { 'source.fixAll' }, diagnostics = current_diagnostics },
          apply = true,
        })
      end,
    })
  end,
}
