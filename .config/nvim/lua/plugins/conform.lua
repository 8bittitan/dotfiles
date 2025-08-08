return {
  'stevearc/conform.nvim',
  lazy = false,
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters = {
        -- TODO: Fix when there is better support for V2
        -- biome = {
        --   require_cwd = true,
        --   command = 'biome',
        --   args = { 'check', '--fix', '--assist-enabled=true', '--stdin-file-path=$RELATIVE_FILEPATH$EXTENSION' },
        -- },
        zig = {
          command = 'zig',
          args = { 'fmt', '--stdin' },
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        ruby = { 'rubocop', timeout_ms = 1500 },
        go = { 'gofmt', 'goimports' },
        zig = { 'zig' },
        json = { 'biome' },
        php = { 'pint' },
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
