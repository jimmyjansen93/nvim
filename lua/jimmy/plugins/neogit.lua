return {
  {
    'NeogitOrg/neogit',
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
}
