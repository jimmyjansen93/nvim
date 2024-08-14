return {
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
