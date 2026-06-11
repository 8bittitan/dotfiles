return {
  on_attach = function(client, bufnr)
    -- Taken from: https://github.com/neovim/nvim-lspconfig/blob/master/lsp/eslint.lua#L78
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        client:request_sync('workspace/executeCommand', {
          command = 'eslint.applyAllFixes',
          arguments = {
            {
              uri = vim.uri_from_bufnr(bufnr),
              version = vim.lsp.util.buf_versions[bufnr],
            },
          },
        }, nil, bufnr)
      end,
    })
  end,
}
