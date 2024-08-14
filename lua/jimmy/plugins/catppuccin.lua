return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        highlight_overrides = {
          all = {
            LineNr = { fg = '#8aadf4' },
            CursorLineNr = { fg = '#ed8796' },
          },
        },
      }
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
}
