return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
  { 'dmmulroy/tsc.nvim', dependencies = { 'rcarriga/nvim-notify' }, opts = {} },
  { 'dmmulroy/ts-error-translator.nvim' },
}
