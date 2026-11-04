return {
  'folke/snacks.nvim',
  priority = 999,
  lazy = false,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      preset = {
        header = [[██╗  ██╗ █████╗ ███╗   ███╗██╗   ██╗██╗
██║ ██╔╝██╔══██╗████╗ ████║██║   ██║██║
█████╔╝ ███████║██╔████╔██║██║   ██║██║
██╔═██╗ ██╔══██║██║╚██╔╝██║██║   ██║██║
██║  ██╗██║  ██║██║ ╚═╝ ██║╚██████╔╝██║
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝
                                       ]],
      },
      example = 'doom',
    },
    explorer = { enabled = false },
    git = { enabled = true },
    indent = { enabled = true, animate = { enabled = false } },
    input = { enabled = true },
    lazygit = { enabled = true, configure = true },
    picker = {
      enabled = true,
      layout = { preset = 'telescope' },
      ui_select = true,
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            ['<S-Tab>'] = { 'list_up', mode = { 'i', 'n' } },
            ['<Tab>'] = { 'list_down', mode = { 'i', 'n' } },
          },
        },
      },
    },
    notifier = { enabled = true, top_down = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = {
      enabled = true,
      left = { 'mark', 'sign' },
      right = { 'fold', 'git' },
      git = { patterns = { 'GitSign' } },
      folds = { open = false, git_hl = false },
      refresh = 50,
    },
    words = { enabled = false },
  },
}
