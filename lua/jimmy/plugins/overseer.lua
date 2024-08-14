return {
  {
    'stevearc/overseer.nvim',
    config = function()
      require('overseer').setup {
        templates = { 'user.zigBuild', 'user.zigBuildRun', 'user.zigTest', 'builtin' },
        task_list = { direction = 'bottom', max_height = { 0.3 } },
      }

      vim.keymap.set('n', '<leader>rr', '<CMD>OverseerRun<CR>', { noremap = true, silent = true, desc = 'Overseer Run' })
      vim.keymap.set('n', '<leader>rt', '<CMD>OverseerTest<CR>', { noremap = true, silent = true, desc = 'Overseer Test' })
      vim.keymap.set('n', '<leader>re', '<CMD>OverseerToggle<CR>', { noremap = true, silent = true, desc = 'Overseer Toggle' })
      vim.keymap.set('n', '<leader>rb', '<CMD>OverseerBuild<CR>', { noremap = true, silent = true, desc = 'Overseer Build' })
      vim.keymap.set('n', '<leader>ra', '<CMD>OverseerQuickAction<CR>', { noremap = true, silent = true, desc = 'Overseer Quickaction' })
    end,
  },
}
