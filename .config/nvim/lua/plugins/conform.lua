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
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        return { timeout_ms = 1000, lsp_format = 'never' }
      end,
      notify_no_formatters = false,
    })

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
        vim.notify('Conform autoformat disabled for current buffer', vim.log.levels.WARN)
      else
        vim.g.disable_autoformat = true
        vim.notify('Conform autoformat disabled', vim.log.levels.WARN)
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false

      vim.notify('Conform autoformat enabled', vim.log.levels.INFO)
    end, {
      desc = 'Re-enable autoformat-on-save',
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
      conform.format({
        lsp_fallback = 'never',
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = 'Format whole file or range (visual mode)' })

    vim.keymap.set({ 'n', 'v' }, '<leader>tf', function()
      if vim.b.disable_autoformat or vim.g.disable_autoformat then
        vim.cmd('FormatEnable')
      else
        vim.cmd('FormatDisable')
      end
    end, { desc = 'Toggle Conform format_on_save' })

    vim.keymap.set({ 'n', 'v' }, '<leader>tb', function()
      if vim.b.disable_autoformat then
        vim.cmd('FormatEnable')
      else
        vim.cmd('FormatDisable!')
      end
    end, { desc = 'Toggle Conform format_on_save for current buffer' })
  end,
}
