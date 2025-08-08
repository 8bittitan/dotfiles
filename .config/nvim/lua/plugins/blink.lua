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
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    version = '1.*',
    event = 'VimEnter',
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
      },
      fuzzy = {
        implementation = 'rust',
        sorts = {
          'exact',
          'score',
          'kind',
          'sort_text',
        },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        accept = {
          create_undo_point = false,
        },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
      signature = { enabled = true },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        per_filetype = { sql = { 'snippets', 'buffer' } },
        providers = {
          dadbod = { module = 'vim_dadbod_completion.blink' },
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
