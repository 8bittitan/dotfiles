return {
  'stevearc/conform.nvim',
  lazy = false,
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters = {
        prettier = {
          require_cwd = true,
        },
        oxfmt = {
          require_cwd = true,
        },
        ['golangci-lint'] = {
          require_cwd = true,
        },
        rubocop = {
          require_cwd = true,
          condition = function(_, ctx)
            return vim.fs.basename(ctx.filename) ~= 'Brewfile'
          end,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'oxfmt', 'prettier', lsp_format = 'last' },
        typescript = { 'oxfmt', 'prettier', lsp_format = 'last' },
        javascriptreact = { 'oxfmt', 'prettier', lsp_format = 'last' },
        typescriptreact = { 'oxfmt', 'prettier', lsp_format = 'last' },
        ruby = { 'rubocop', timeout_ms = 1500 },
        go = { 'golangci-lint', 'gofmt', 'goimports' },
        json = { 'oxfmt' },
        php = { 'pint' },
        python = { 'ruff_format' },
        rust = { 'rustfmt' },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = 'never',
      },
      notify_no_formatters = false,
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
