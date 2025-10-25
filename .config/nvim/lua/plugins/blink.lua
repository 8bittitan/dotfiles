return {
  {
    'saghen/blink.compat',
    version = '*',
    lazy = true,
    opts = {},
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    version = '1.*',
    event = 'VimEnter',
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      enabled = function()
        local filetype = vim.bo[0].filetype

        if filetype == 'TelescopePrompt' then
          return false
        end

        return true
      end,
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        accept = {
          create_undo_point = false,
        },
        menu = {
          border = 'rounded',
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = { border = 'rounded' },
        },
      },
      signature = { enabled = true },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        per_filetype = { sql = { 'snippets', 'buffer' } },
        providers = {
          lsp = {
            name = 'lsp',
            enabled = true,
            kind = 'LSP',
            score_offset = 90,
          },
          path = {
            name = 'Path',
            score_offset = 25,
            fallbacks = { 'snippets', 'buffer' },
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
          buffer = {
            name = 'Buffer',
            enabled = true,
            max_items = 3,
            min_keyword_length = 1,
            score_offset = 15,
          },
          snippets = {
            name = 'snippets',
            enabled = true,
            max_items = 15,
            score_offset = 85,
            min_keyword_length = 2,
          },
          lazydev = {
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
    cmdline = {
      enabled = true,
      keymap = {
        preset = 'inherit',
      },
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },
  },
}
