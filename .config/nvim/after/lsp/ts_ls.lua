local vue_ls_path = vim.fn.expand('$MASON/packages/vue-language-server')
local vue_ts_plugin_location = vue_ls_path .. '/node_modules/@vue/language-server'

return {
  root_dir = function(bufnr, on_dir)
    local installed = vim.fs.find('node_modules/typescript/package.json', {
      path = vim.api.nvim_buf_get_name(bufnr),
      upward = true,
      limit = math.huge,
    })
    local package_json = installed[#installed]

    if not package_json then
      return
    end

    local ok, typescript = pcall(vim.json.decode, table.concat(vim.fn.readfile(package_json), '\n'))
    local major = ok and tonumber((typescript.version or ''):match('%d+'))

    if major and major < 7 then
      on_dir(vim.fs.dirname(vim.fs.dirname(vim.fs.dirname(package_json))))
    end
  end,
  single_file_support = false,
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_ts_plugin_location,
        languages = { 'javascript', 'typescript', 'vue' },
      },
    },
    preferences = {
      includeCompletionsWithSnippetText = true,
      includeCompletionsForImportStatements = true,
    },
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
  on_attach = function(client)
    if client.name == 'ts_ls' or client.name == 'typescript-tools' then
      client.server_capabilities.documentFormattingProvider = false
    end
  end,
}
