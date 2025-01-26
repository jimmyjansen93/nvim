-- TODO: can probably inline this in after/
return {
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    enabled = false,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },

    config = function()
      require('go').setup()
    end,
  },
}
