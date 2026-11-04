-- return {
--   {
--     'nvim-treesitter/nvim-treesitter',
--     branch = 'main',
--     lazy = false,
--     build = ':TSUpdate',
--     dependencies = {
--       'JoosepAlviste/nvim-ts-context-commentstring',
--     },
--     config = function()
--       require('ts_context_commentstring').setup({})
--
--       require('nvim-treesitter.install').prefer_git = true
--
--       require('nvim-treesitter').setup({
--         ignore_install = {},
--         ensure_installed = require('utils').parsers,
--         auto_install = true,
--         sync_install = true,
--         highlight = { enable = true, additional_vim_regex_highlighting = { 'ruby' } },
--         indent = { enable = true, disable = { 'ruby' } },
--         endwise = { enable = true },
--         autopairs = { enable = true },
--       })
--     end,
--   },
-- }

return {
  'romus204/tree-sitter-manager.nvim',
  dependencies = {}, -- tree-sitter CLI must be installed system-wide
  config = function()
    require('tree-sitter-manager').setup({
      parser_dir = vim.fn.stdpath('data') .. '/site/parser',
      query_dir = vim.fn.stdpath('data') .. '/site/queries',
    })

    vim.api.nvim_create_user_command('TSUpgrade', function()
      local state = require('tree-sitter-manager.config')
      local util = require('tree-sitter-manager.util')
      local installer = require('tree-sitter-manager.installer')
      local langs = vim.tbl_filter(function(lang)
        return util.is_installed(lang)
      end, state.languages)
      for _, lang in ipairs(langs) do
        installer.remove(lang)
      end
      local remaining = #langs
      for _, lang in ipairs(langs) do
        installer.install(lang, function()
          remaining = remaining - 1
        end)
      end
      if #langs > 0 then
        vim.wait(900000, function()
          return remaining <= 0
        end, 200)
      end
    end, { nargs = 0, desc = 'Update all installed treesitter parsers' })
  end,
}
