return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true,
    disable_filetype = { 'TelescopePrompt' },
    ts_config = {
      lua = { 'string', 'source' },
      javascript = { 'string', 'template_string' },
    },
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
      offset = 0,
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      highlight = 'PmenuSel',
      highlight_grey = 'LineNr',
    },
  },
  config = function()
    require('nvim-autopairs').setup()
    local npairs = require('nvim-autopairs')
    _G.MUtils = {}
    vim.g.completion_confirm_key = ''
    MUtils.completion_confirm = function()
      if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info()['selected'] ~= -1 then
          vim.fn['compe#confirm']()
          return npairs.esc('<c-y>')
        else
          vim.defer_fn(function()
            vim.fn['compe#confirm']('<cr>')
          end, 20)
          return npairs.esc('<c-n>')
        end
      else
        return npairs.check_break_line_char()
      end
    end
  end,
}
