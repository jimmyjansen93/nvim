return {
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup { use_default_keymaps = false, notify = false }

      vim.keymap.set('n', '<leader>cj', require('treesj').toggle, { desc = 'Toogle join' })
    end,
  },
}
