return {
  'christoomey/vim-tmux-navigator',
  enabled = vim.env.TMUX ~= nil and vim.env.TMUX ~= '',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
    'TmuxNavigatorProcessList',
  },
  keys = {
    { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>', { 'n', 't' } },
    { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>', { 'n', 't' } },
    { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>', { 'n', 't' } },
    { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>', { 'n', 't' } },
    { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>', { 'n', 't' } },
  },
}
