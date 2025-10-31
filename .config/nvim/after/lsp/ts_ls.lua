return {
  single_file_support = false,
  init_options = {
    preferences = {
      includeCompletionsWithSnippetText = true,
      includeCompletionsForImportStatements = true,
    },
  },
  on_attach = function(client)
    if client.name == 'ts_ls' or client.name == 'typescript-tools' then
      client.server_capabilities.documentFormattingProvider = false
    end
  end,
}
