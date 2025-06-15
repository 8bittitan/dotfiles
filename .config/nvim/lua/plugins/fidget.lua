return {
  'j-hui/fidget.nvim',
  event = 'LspAttach',
  opts = {
    progress = {
      display = {
        done_ttl = 1,
      },
    },
    notification = {
      window = {
        winblend = 0,
      },
    },
  },
}
