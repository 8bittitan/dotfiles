return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('ts_context_commentstring').setup({})

      require('nvim-treesitter.install').prefer_git = true
      local treesitter = require('nvim-treesitter.configs')

      treesitter.setup({
        ignore_install = {},
        ensure_installed = require('utils').parsers,
        auto_install = true,
        sync_install = false,
        highlight = { enable = true, additional_vim_regex_highlighting = { 'ruby' } },
        indent = { enable = true, disable = { 'ruby' } },
        endwise = { enable = true },
        autopairs = { enable = true },
      })
    end,
  },
}
