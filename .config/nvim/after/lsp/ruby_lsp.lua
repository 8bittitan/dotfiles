---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.ruby_lsp
  settings = {
    rubyLsp = {
      formatter = 'none',
      pullDiagnosticsOn = 'save',
      featureFlags = {
        all = true,
      },
    },
  },
}
