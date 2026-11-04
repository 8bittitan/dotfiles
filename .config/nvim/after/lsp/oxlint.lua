---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local config =
      vim.fs.find({ '.oxlintrc.json', '.oxlintrc.jsonc', 'oxlint.config.ts' }, { path = fname, upward = true })[1]
    if config then
      on_dir(vim.fs.dirname(config))
    end
    -- No oxlint config found: do not call on_dir, so the server won't attach.
  end,
  on_attach = function(client, bufnr)
    -- Taken from https://github.com/neovim/nvim-lspconfig/blob/master/lsp/oxlint.lua#L73
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        client:exec_cmd({
          title = 'Apply Oxlint automatic fixes',
          command = 'oxc.fixAll',
          arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
        })
      end,
    })
  end,
  settings = {
    oxlint = {
      fixKind = 'all',
      disableNestedConfig = false,
    },
  },
}
