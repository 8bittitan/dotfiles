return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    ---@module 'snacks'
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    --- @type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = 'tmux',
        tmux = {
          options = '-h -l 33%',
        },
      },
      ask = {
        blink_cmp_sources = { 'lsp' },
      },
    }

    vim.o.autoread = true

    local wk = require('which-key')

    wk.add({
      {
        '<leader>oa',
        "<cmd>lua require('opencode').ask('@this: ', { submit = true })<CR>",
        desc = '[O]pencode [A]sk',
        mode = { 'n', 'x' },
      },
      {
        '<leader>od',
        "<cmd>lua require('opencode').prompt('diagnostics', { submit = true })<CR>",
        desc = '[O]pencode explain [D]iagnostics',
        mode = { 'n', 'x' },
      },
      {
        '<leader>os',
        "<cmd>lua require('opencode').select()<CR>",
        desc = '[O]pencode [S]elect action',
        mode = { 'n', 'x' },
      },
      {
        '<leader>ot',
        "<cmd>lua require('opencode').toggle()<CR>",
        desc = '[O]pencode [T]oggle',
        mode = { 'n', 't' },
      },
    })
  end,
}
