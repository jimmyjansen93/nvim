return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  { 'dmmulroy/tsc.nvim', dependencies = { 'rcarriga/nvim-notify' }, opts = {} },

  { 'dmmulroy/ts-error-translator.nvim' },

  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    ft = { 'rust' },
  },

  {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },

  {
    'andrewferrier/debugprint.nvim',
    version = '*',
    opts = {
      print_tag = 'DEBUG',
    },
  },
}
