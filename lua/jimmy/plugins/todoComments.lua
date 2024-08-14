return {
  {
    'folke/todo-comments.nvim',
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup { signs = true }

      vim.keymap.set('n', '<leader>xt', '<cmd>TodoTrouble<cr>', { noremap = true, silent = true, desc = 'Todo Trouble' })
      vim.keymap.set('n', '<leader>xT', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', { noremap = true, silent = true, desc = 'Todo/Fix/Fixme Trouble' })
      vim.keymap.set('n', '<leader>xs', '<cmd>TodoTelescope<cr>', { noremap = true, silent = true, desc = 'Todo Telescope' })
      vim.keymap.set('n', '<leader>xS', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', { noremap = true, silent = true, desc = 'Todo/Fix/Fixme' })
    end,
  },
}
