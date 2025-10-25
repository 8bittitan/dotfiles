return {
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = require('utils').servers,
    },
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = {
          ui = {
            border = 'single',
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
          PATH = 'append',
        },
      },
      'neovim/nvim-lspconfig',
      'b0o/schemastore.nvim',
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = require('utils').linters,
    },
    dependencies = {
      'williamboman/mason.nvim',
    },
  },
}
