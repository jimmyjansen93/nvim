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
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    enabled = false,
    opts = {},
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
  { 'dmmulroy/tsc.nvim', dependencies = { 'rcarriga/nvim-notify' }, opts = {} },
  { 'dmmulroy/ts-error-translator.nvim' },
}
