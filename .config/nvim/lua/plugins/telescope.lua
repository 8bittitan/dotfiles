return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ['<c-e>'] = actions.to_fuzzy_refine,
            ['<c-h>'] = 'which_key',
            ['<esc>'] = actions.close,
          },
        },
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
          bottom_pane = {
            height = 25,
            preview_cutoff = 120,
            prompt_position = 'top',
          },
          center = {
            height = 0.4,
            preview_cutoff = 40,
            prompt_position = 'top',
            width = 0.5,
          },
          cursor = {
            height = 0.9,
            preview_cutoff = 40,
            width = 0.8,
          },
          horizontal = {
            height = 0.9,
            preview_cutoff = 0,
            prompt_position = 'bottom',
            width = 0.9,
          },
          vertical = {
            height = 0.9,
            preview_cutoff = 0,
            prompt_position = 'bottom',
            width = 0.9,
          },
        },
        file_ignore_patterns = {
          '**node_modules/',
          '**deps/',
          '**dist/',
          '**__snapshots__/',
          '**.git/',
          '**.next/',
          '**.yarn/',
          '**build/terraform/\\.terraform/',
          '**plugin/packer_compiled.lua',
          '**yarn.lock',
          '**yarn-error.log',
          '**install_module.log',
          'vendor',
          'sorbet',
          '_client_admin_old',
          '.bundle',
          '**.terraform/',
          '**.turbo',
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
  end,
}
