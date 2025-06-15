return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    's1n7ax/nvim-window-picker',
  },
  config = function()
    require('neo-tree').setup({
      sources = {
        'filesystem',
        'buffers',
        'git_status',
      },
      add_blank_line_at_top = false,
      auto_clean_after_session_restore = false,
      git_status_async = true,
      git_status_async_options = {
        batch_size = 1000,
        batch_delay = 10,
        max_lines = 10000,
      },
      default_source = 'filesystem',
      enable_diagnostics = true,
      enable_git_status = true,
      enable_modifier_markers = true,
      enable_refresh_on_write = true,
      use_popups_for_input = true,
      close_if_last_window = true,
      source_selector = {
        winbar = false,
        statusline = false,
        show_scrolled_off_parent_node = false,
        content_layout = 'start',
        tabs_layout = 'equal',
        truncation_character = '…',
        tabs_min_width = nil,
        tabs_max_width = nil,
        padding = 0,
      },
      window = {
        position = 'right',
        width = 40,
        height = 15,
        auto_expand_width = false,
        popup = {
          size = {
            height = '80%',
            width = '50%',
          },
          position = '50%',
        },
        same_level = false,
        insert_as = 'child',
        mapping_options = {
          noremap = true,
          nowait = true,
        },
      },
      event_handlers = {
        {
          event = 'neo_tree_buffer_enter',
          handler = function()
            vim.cmd([[setlocal relativenumber]])
          end,
        },
        {
          event = 'file_opened',
          handler = function()
            require('neo-tree.command').execute({ action = 'close' })
          end,
        },
      },
      filesystem = {
        async_directory_scan = 'auto',
        scan_mode = 'shallow',
        bind_to_cwd = true,
        cwd_target = {
          sidebar = 'tab',
          current = 'window',
        },
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          force_visible_in_empty_folder = false,
          show_hidden_count = true,
          hide_hidden = false,
          hide_by_name = {
            '.DS_Store',
            'thumbs.db',
          },
        },
        find_by_full_path_words = false,
        group_empty_dirs = false,
        search_limit = 50,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        hijack_netrw_behavior = 'open_default',
        use_libuv_file_watcher = false,
      },
      buffers = {
        bind_to_cwd = true,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        group_empty_dirs = true,
      },
    })
  end,
}
