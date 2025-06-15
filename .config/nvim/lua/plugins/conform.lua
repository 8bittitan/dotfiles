return {
  'stevearc/conform.nvim',
  lazy = false,
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters = {
        biome = {
          require_cwd = true,
        },
        ['biome-organize-imports'] = {
          require_cwd = true,
        },
        zig = {
          command = 'zig',
          args = { 'fmt', '--stdin' },
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'biome', 'biome-organize-imports', 'prettier' },
        typescript = { 'biome', 'biome-organize-imports', 'prettier' },
        javascriptreact = { 'biome', 'biome-organize-imports', 'prettier' },
        typescriptreact = { 'biome', 'biome-organize-imports', 'prettier' },
        ruby = { 'rubocop', timeout_ms = 1500 },
        go = { 'gofmt', 'goimports' },
        zig = { 'zig' },
        json = { 'biome' },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = 'never',
      },
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
      conform.format({
        lsp_fallback = 'never',
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = 'Format whole file or range (visual mode)' })
  end,
}
