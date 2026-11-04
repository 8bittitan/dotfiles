return {
  {
    'tpope/vim-fugitive',
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()

      vim.keymap.set('n', '<leader>gp', '<cmd>:Gitsigns preview_hunk_inline<CR>', {})
    end,
  },
  { 'echasnovski/mini-git', lazy = true, version = false, main = 'mini.git', opts = {} },
}
