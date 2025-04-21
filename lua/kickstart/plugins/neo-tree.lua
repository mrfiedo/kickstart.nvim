-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require 'neo-tree'
      end
    end -- do nothing
  end,
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  event = 'VimEnter',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['v'] = 'open_vsplit',
          ['s'] = 'open_split',
        },
      },
      hijack_netrw = true,
    },
  },
  config = function()
    require('neo-tree').setup {
      filesystem = {
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
      window = {
        position = 'left',
        width = 50,
        mappings = {
          ['<CR>'] = 'open',
          ['<BS>'] = 'navigate_up',
          ['<C-s>'] = 'split_with_window_picker',
        },
      },
      default_component_configs = {
        indent = {
          padding = 1,
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '',
        },
        name = {
          highlight_opened_files = true,
        },
      },
    }
  end,
}
