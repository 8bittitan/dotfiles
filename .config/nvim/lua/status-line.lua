local M = {}

local function _spacer(n)
  local spaces = string.rep(' ', n)
  return '%#StatusLineTextMain#' .. spaces
end

local function _align()
  return '%='
end

local function _truncate()
  return '%<'
end

local function _filename()
  if vim.fn.mode() == 't' then
    return nil
  end

  local f = vim.fn.expand('%:~:t')

  return f
end

local function lazy_require(require_path)
  return setmetatable({}, {
    __index = function(_, key)
      return require(require_path)[key]
    end,

    __newindex = function(_, key, value)
      require(require_path)[key] = value
    end,
  })
end

local CTRL_S = vim.api.nvim_replace_termcodes('<C-S>', true, true, true)
local CTRL_V = vim.api.nvim_replace_termcodes('<C-V>', true, true, true)

local modes = setmetatable({
  ['n'] = { long = 'NORMAL', short = 'N', hl = '%#StatusLineModeNormal#' },
  ['v'] = { long = 'VISUAL', short = 'V', hl = '%#StatusLineModeVisual#' },
  ['V'] = { long = 'V-LINE', short = 'V-L', hl = '%#StatusLineModeVisual#' },
  [CTRL_V] = { long = 'V-BLOCK', short = 'V-B', hl = '%#StatusLineModeVisual#' },
  ['s'] = { long = 'SELECT', short = 'S', hl = '%#StatusLineModeVisual#' },
  ['S'] = { long = 'S-LINE', short = 'S-L', hl = '%#StatusLineModeVisual#' },
  [CTRL_S] = { long = 'S-BLOCK', short = 'S-B', hl = '%#StatusLineModeVisual#' },
  ['i'] = { long = 'INSERT', short = 'I', hl = '%#StatusLineModeInsert#' },
  ['R'] = { long = 'REPLACE', short = 'R', hl = '%#StatusLineModeReplace#' },
  ['c'] = { long = 'COMMAND', short = 'C', hl = '%#StatusLineModeCommand#' },
  ['r'] = { long = 'PROMPT', short = 'P', hl = '%#StatusLineModeOther#' },
  ['!'] = { long = 'SHELL', short = 'Sh', hl = '%#StatusLineModeOther#' },
  ['t'] = { long = 'TERMINAL', short = 'T', hl = '%#StatusLineModeOther#' },
}, {
  __index = function()
    return { long = 'Unknown', short = 'U', hl = '%#StatusLineModeOther#' }
  end,
})

local function get_mode()
  local mode_info = modes[vim.fn.mode()]
  local mode = mode_info.short
  return mode_info.hl .. mode .. ' ' .. _spacer(1)
end

local function get_path()
  if vim.fn.mode() == 't' then
    return ''
  end

  local path = vim.fn.expand('%:~:.:h')
  local hl = '%#StatusLineTextAccent#'
  local max_width = 30
  if path == '.' or path == '' then
    return ''
  elseif #path > max_width then
    path = '...' .. string.sub(path, -max_width + 2)
  end

  return hl .. path .. '/'
end

local function get_filetype()
  local disabled_modes = {
    't',
    '!',
  }
  if vim.tbl_contains(disabled_modes, vim.fn.mode()) then
    return ''
  end

  local file_name = _filename()

  if file_name == nil then
    return ''
  end

  local hl = '%#StatusLineFileIcon#'
  local file_ext = vim.fn.fnamemodify(file_name, ':e')
  local icon, _ = require('nvim-web-devicons').get_icon(file_name, file_ext, { default = false })

  if icon == '' or icon == nil then
    return ''
  end

  return hl .. icon .. _spacer(1)
end

local function get_filename()
  local filename = _filename()
  local path = vim.fn.expand('%:~:.:h')
  local hl = '%#StatusLineTextMain#'

  if filename == nil then
    return hl .. '[No Name]' .. _spacer(1)
  end

  if path == '.' then
    return hl .. filename .. _spacer(1)
  end

  return hl .. filename .. _spacer(1)
end

local function get_diagnostics()
  local count_error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local count_warning = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local count_info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  local hl_error = '%#DiagnosticError#'
  local hl_warning = '%#DiagnosticWarn#'
  local hl_info = '%#DiagnosticInfo#'

  local error = hl_error .. '' .. _spacer(1) .. hl_error .. count_error .. _spacer(1)
  local warning = hl_warning .. '' .. _spacer(1) .. hl_warning .. count_warning .. _spacer(1)
  local info = hl_info .. '' .. _spacer(1) .. hl_info .. count_info

  return error .. warning .. info .. _spacer(1)
end

local function get_active_lsps()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local hl = '%#StatusLineActiveLsp#'
  local total_clients = #clients

  if total_clients > 0 then
    local i = 0
    local str = hl .. ' '
    for _, client in ipairs(clients) do
      if client.initialized then
        str = str .. client.name

        if i < total_clients - 1 then
          str = str .. '|'
        end
      end

      i = i + 1
    end

    return str .. _spacer(2)
  else
    return ''
  end
end

local function get_branch()
  local branch = vim.b.minigit_summary_string or ''
  local hl_main = '%#StatusLineGitBranch#'
  local hl_accent = '%#StatusLineGitIcon#'

  if branch == '' then
    return ''
  end

  return hl_accent .. ' ' .. hl_main .. branch .. _spacer(2)
end

local function get_recording()
  local hl_main = '%#StatusLineTextMain#'
  local hl_accent = '%#StatusLineTextAccent#'
  local noice = lazy_require('noice')
  local status = noice.api.status.mode.get()

  if status == nil then
    return ''
  end

  return hl_accent .. ' ' .. hl_main .. status .. _spacer(2)
end

M.setup = function()
  vim.opt.laststatus = 3
  vim.opt.showmode = false
end

M.load = function()
  local curr_ft = vim.bo.filetype
  local disabled_filtetypes = {
    'dashboard',
  }

  if vim.tbl_contains(disabled_filtetypes, curr_ft) then
    return nil
  end

  return table.concat({
    get_mode(),
    get_filetype(),
    get_path(),
    get_filename(),
    get_diagnostics(),
    _align(),
    get_recording(),
    get_active_lsps(),
    get_branch(),
    _truncate(),
  })
end

return M
