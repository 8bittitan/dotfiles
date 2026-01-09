local M = {}

M.servers = {
  'bashls',
  'biome',
  'cssls',
  'eslint',
  'gopls',
  'html',
  'intelephense',
  'jsonls',
  'lua_ls',
  'prismals',
  'pyright',
  'ruby_lsp',
  'tailwindcss',
  'ts_ls',
}

M.linters = {
  'erb-formatter',
  'erb-lint',
  'jsonlint',
  'markdownlint',
  'oxlint',
  'prettier',
  'rubocop',
  'shellharden',
  'stylua',
}

M.parsers = {
  'bash',
  'css',
  'dockerfile',
  'go',
  'html',
  'javascript',
  'json',
  'lua',
  'markdown',
  'markdown_inline',
  'prisma',
  'regex',
  'ruby',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'yaml',
  'zig',
}

M.icons = {
  diagnostics = {
    Error = ' ',
    Hint = ' ',
    Info = ' ',
    Warn = ' ',
  },
  lsp = {
    Array = ' ',
    Boolean = ' ',
    Class = ' ',
    Color = ' ',
    Constant = ' ',
    Constructor = ' ',
    Copilot = ' ',
    Enum = ' ',
    EnumMember = ' ',
    Event = ' ',
    Field = ' ',
    File = ' ',
    Folder = ' ',
    Function = ' ',
    Interface = ' ',
    Key = ' ',
    Keyword = ' ',
    Method = ' ',
    Module = ' ',
    Namespace = ' ',
    Null = ' ',
    Number = ' ',
    Object = ' ',
    Operator = ' ',
    Package = ' ',
    Property = ' ',
    Reference = ' ',
    Snippet = ' ',
    String = ' ',
    Struct = ' ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = ' ',
    Value = ' ',
    Variable = ' ',
  },
}

M.override_lsp_notify = function()
  local original = vim.notify

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.notify = function(msg, level, opts)
    if msg == 'No code actions available' then
      return
    end

    original(msg, level, opts)
  end
end

return M
