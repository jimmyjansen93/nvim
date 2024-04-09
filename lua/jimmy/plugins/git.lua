return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '▎' },
          change = { text = '▎' },
          delete = { text = '' },
          topdelete = { text = '' },
          changedelete = { text = '▎' },
          untracked = { text = '▎' },
        },
      }

      vim.keymap.set('n', '<leader>gp', '<CMD>lua require("gitsigns").preview_hunk()<CR>', { desc = 'Git preview hunk' })
      vim.keymap.set('n', '<leader>gt', '<CMD>lua require("gitsigns").toggle_current_line_blame()<CR>', { desc = 'Git toggle blame' })
      vim.keymap.set('n', '<leader>gl', '<CMD>lua require("gitsigns").setloclist()<CR>', { desc = 'Git loclist' })
      vim.keymap.set('n', ']c', '<CMD>lua require("gitsigns").next_hunk()<CR>', { desc = 'Git next change' })
      vim.keymap.set('n', '[c', '<CMD>lua require("gitsigns").prev_hunk()<CR>', { desc = 'Git prev change' })
    end,
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local neogit = require 'neogit'
      neogit.setup {
        disable_signs = false,
        graph_style = 'unicode',
        ignored_settings = {
          'NeogitPushPopup--force-with-lease',
          'NeogitCommitPopup--allow-empty',
          'NeogitRevertPopup--no-edit',
        },
      }

      vim.api.nvim_create_autocmd('User', {
        desc = 'Close Neogit after push',
        pattern = 'NeogitPushComplete',
        group = vim.api.nvim_create_augroup('Neogit', { clear = true }),
        callback = require('neogit').close,
      })
      vim.api.nvim_exec_autocmds('User', { group = 'Neogit' })
    end,
    keys = {
      { '<leader>gg', '<CMD>Neogit<CR>', desc = 'Open git window' },
    },
  },

  {
    'IsWladi/Gittory',
    opts = {
      atStartUp = true,
      notifySettings = {
        enabled = false,
      },
    },
  },
}
