return {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  event = 'VeryLazy',
  opts = {
    lsp = {
      progress = { enabled = false },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
    notify = { enabled = false },
    presets = {
      bottom_search = false,
      command_palette = false,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
    },
    views = {
      mini = {
        position = {
          col = -2,
          row = -2,
        },
        win_options = {
          winblend = 0,
        },
        border = {
          style = 'single',
        },
      },
      hover = {
        border = {
          padding = { 0, 1 },
        },
      },
      cmdline_input = {
        border = {
          style = 'single',
        },
      },
      cmdline_popup = {
        border = {
          style = 'single',
        },
      },
    },
  },
}
