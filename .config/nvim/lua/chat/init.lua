local M = {}

local prompt_height = 4

local chat_state = {
  floats = {},
  messages = {},
}

local function _create_floating_window(config, enter)
  if enter == nil then
    enter = false
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, enter or false, config)

  return { buf = buf, win = win }
end

local function _get_dims()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  return { width = width, height = height, col = col, row = row }
end

local function _create_repsonse_window()
  local dims = _get_dims()

  local settings = {
    relative = 'editor',
    width = dims.width,
    height = dims.height - prompt_height,
    style = 'minimal',
    col = dims.col,
    row = dims.row,
    border = 'single',
    zindex = 1,
  }

  local resp = _create_floating_window(settings)

  local output = { '# Welcome to SuperChat' }
  vim.api.nvim_buf_set_lines(resp.buf, 0, -1, false, output)

  return resp
end

local function _create_prompt_window()
  local dims = _get_dims()

  local settings = {
    relative = 'editor',
    width = dims.width,
    height = prompt_height,
    style = 'minimal',
    col = dims.col,
    row = dims.height + prompt_height,
    border = 'single',
    zindex = 3,
    noautocmd = true,
  }

  return _create_floating_window(settings, true)
end

-- Get contents of prompt buffer
local function _get_prompt_input()
  local prompt_buf = chat_state.floats.prompt.buf

  local total_lines = vim.api.nvim_buf_line_count(prompt_buf)
  local lines = vim.api.nvim_buf_get_lines(prompt_buf, 0, total_lines, false)
  local contents = table.concat(lines, '\n')

  return contents
end

local function _set_response(input)
  local response_buf = chat_state.floats.response.buf

  -- Allow response buffer to be updated
  vim.api.nvim_buf_set_option(response_buf, 'readonly', false)
  vim.api.nvim_buf_set_option(response_buf, 'modifiable', true)

  local response_line_count = vim.api.nvim_buf_line_count(response_buf)

  -- Set new contents of response buffer
  vim.api.nvim_buf_set_lines(response_buf, response_line_count, response_line_count, false, { input })

  -- Reset response buffer options
  vim.api.nvim_buf_set_option(response_buf, 'readonly', true)
  vim.api.nvim_buf_set_option(response_buf, 'modifiable', false)
end

local function _handle_new_prompt()
  local input = _get_prompt_input()

  -- Don't do anything if there was no content for prompt
  if string.len(input) < 1 then
    return
  end

  _set_response(input)

  -- Clear the prompt buffer
  vim.api.nvim_buf_set_lines(chat_state.floats.prompt.buf, 0, -1, false, {})
end

local chat_command = {
  name = 'SimpleChat',
  callback = function()
    chat_state.floats.response = _create_repsonse_window()
    chat_state.floats.prompt = _create_prompt_window()

    vim.keymap.set('n', 'q', function()
      vim.api.nvim_win_close(chat_state.floats.prompt.win, true)
    end)

    vim.keymap.set('n', 'X', function()
      _handle_new_prompt()
    end)

    vim.api.nvim_create_autocmd('BufLeave', {
      buffer = chat_state.floats.prompt.buf,
      callback = function()
        for _, float in pairs(chat_state.floats) do
          pcall(vim.api.nvim_win_close, float.win, true)
        end
      end,
    })
  end,
  opts = {
    desc = 'Start a new chat with your AI companion',
    range = true,
    nargs = '*',
  },
}

M.setup = function()
  vim.api.nvim_create_user_command(chat_command.name, chat_command.callback, chat_command.opts)

  vim.keymap.set('n', '<leader>sc', '<cmd>:SimpleChat<CR>')
end

return M
