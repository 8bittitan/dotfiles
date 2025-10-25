return {
  settings = {
    zls = {
      semantic_tokens = 'partial',
    },
  },
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.zig', '*.zon' },
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, async = false })
      end,
    })
  end,
}
