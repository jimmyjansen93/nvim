return {
  { 'stevearc/dressing.nvim', event = 'VeryLazy' },

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

  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = { options = vim.opt.sessionoptions:get() },
    keys = {
      {
        '<leader>qs',
        function()
          require('persistence').load()
        end,
        desc = 'Restore Session',
      },
      {
        '<leader>ql',
        function()
          require('persistence').load { last = true }
        end,
        desc = 'Restore Last Session',
      },
      {
        '<leader>qd',
        function()
          require('persistence').stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
}
