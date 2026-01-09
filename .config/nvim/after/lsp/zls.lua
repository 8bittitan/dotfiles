return {
  settings = {
    zls = {
      semantic_tokens = 'partial',
      build_on_save_args = { '-fincremental' },
    },
  },
  on_attach = function()
    vim.g.zig_fmt_parse_errors = 0

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = { '*.zig', '*.zon' },
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
}
