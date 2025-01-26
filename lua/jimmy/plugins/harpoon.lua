return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    enabled = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<C-a>', function()
        harpoon:list():add()
      end, { desc = 'Harpoon Add List' })

      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon Toggle menu' })

      vim.keymap.set('n', '<C-j>', function()
        harpoon:list():next()
      end, { desc = 'Harpoon Next' })

      vim.keymap.set('n', '<C-k>', function()
        harpoon:list():prev()
      end, { desc = 'Harpoon Next' })
    end,
  },
}
