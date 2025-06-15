return {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('nightfox').setup({
      groups = {
        all = {
          StatusLineTextMain = { fg = 'palette.magenta', bg = 'palette.bg1' },
          StatusLineTextAccent = { fg = 'palette.fg2', bg = 'palette.bg1' },
          StatusLineActiveLsp = { fg = 'palette.magenta.bright', bg = 'palette.bg1' },
          StatusLineModeNormal = { fg = 'palette.green.bright', bg = 'palette.bg1', style = 'bold' },
          StatusLineModeInsert = { fg = 'palette.pink.bright', bg = 'palette.bg1', style = 'bold' },
          StatusLineModeCommand = { fg = 'palette.cyan', bg = 'palette.bg1', style = 'bold' },
          StatusLineModeOther = { fg = 'palette.pink', bg = 'palette.bg1', style = 'bold' },
          StatusLineModeReplace = { fg = 'palette.pink.dim', bg = 'palette.bg1', style = 'bold' },
          StatusLineModeVisual = { fg = 'palette.magenta.bright', bg = 'palette.bg1', style = 'bold' },
          StatusLineGitBranch = { fg = 'palette.cyan.dim', bg = 'palette.bg1' },
          StatusLineGitIcon = { fg = 'palette.fg1', bg = 'palette.bg1' },
          StatusLineFileIcon = { fg = 'palette.orange.bright', bg = 'palette.bg1' },
          DiagnosticError = { bg = 'palette.bg1' },
          DiagnosticWarn = { bg = 'palette.bg1' },
          DiagnosticInfo = { bg = 'palette.bg1' },
        },
      },
    })

    vim.cmd([[colorscheme duskfox]])
  end,
}
