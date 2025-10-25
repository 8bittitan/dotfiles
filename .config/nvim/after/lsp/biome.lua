return {
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        require('utils').override_lsp_notify()

        local current_diagnostics = vim.lsp.diagnostic.from(vim.diagnostic.get(bufnr))

        vim.lsp.buf.code_action({
          context = {
            ---@diagnostic disable-next-line: assign-type-mismatch
            only = { 'source.fixAll.biome' },
            diagnostics = current_diagnostics,
          },
          apply = true,
        })
      end,
    })
  end,
}
