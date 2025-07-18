return {
  'numtostr/FTerm.nvim',
  event = 'VeryLazy',
  config = function()
    require('FTerm').setup({
      dimensions = {
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,
      },
      border = 'single',
    })
  end,
}
