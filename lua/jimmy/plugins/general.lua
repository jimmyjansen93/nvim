return {
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup { '*' }
    end,
  },

  { 'anuvyklack/help-vsplit.nvim', opts = {
    always = true,
    side = 'right',
  } },

  {
    'aserowy/tmux.nvim',
    opts = {
      copy_sync = {
        redirect_to_clipboard = true,
      },
      navigation = {
        enable_default_keybindings = true,
      },
    },
  },

  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
  },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
}
