-- TODO: can probably remove this in favor of just using telescope
return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

      require('neo-tree').setup {
        close_if_last_window = true,
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = true,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        default_component_configs = {
          git_status = {
            symbols = {
              added = '󱤧',
              modified = '',
              deleted = '',
              renamed = '󰁕',
              untracked = '',
              ignored = '',
              unstaged = '',
              staged = '󰘾',
              conflict = '',
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>ft', '<CMD>Neotree toggle<CR>', { desc = 'Neotree toggle' })
      vim.keymap.set('n', '<leader>ff', '<CMD>Neotree position=current<CR>', { desc = 'Neotree fullscreen' })
    end,
  },
}
