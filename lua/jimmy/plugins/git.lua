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
    branch = 'nightly',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neogit').setup {
        disable_signs = false,
        use_per_project_settings = true,
        remember_settings = true,
        graph_style = 'unicode',
        ignored_settings = {
          'NeogitPushPopup--force',
          'NeogitPullPopup--rebase',
          'NeogitCommitPopup--allow-empty',
          'NeogitRevertPopup--no-edit',
        },
      }

      vim.keymap.set('n', '<leader>gg', '<CMD>Neogit<CR>', { desc = 'Open git window' })
    end,
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

  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = function()
      require('git-conflict').setup {}

      vim.keymap.set('n', '<leader>gcb', '<CMD>GitConflictChooseBoth<CR>', { desc = 'Choose both' })
      vim.keymap.set('n', '<leader>gcn', '<CMD>GitConflictNextConflict<CR>', { desc = 'Move to next conflict' })
      vim.keymap.set('n', '<leader>gcc', '<CMD>GitConflictChooseOurs<CR>', { desc = 'Choose current' })
      vim.keymap.set('n', '<leader>gcp', '<CMD>GitConflictPrevConflict<CR>', { desc = 'Move to prev conflict' })
      vim.keymap.set('n', '<leader>gci', '<CMD>GitConflictChooseTheirs<CR>', { desc = 'Choose incoming' })
    end,
  },
}
