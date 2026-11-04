return {
  'chrisgrieser/nvim-origami',
  event = 'VeryLazy',
  opts = {
    foldtext = {
      padding = {
        width = 1,
      },
      lineCount = {
        template = ' %d lines',
        hlgroup = 'Comment',
      },
    },
  },
  init = function()
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
  end,
}
