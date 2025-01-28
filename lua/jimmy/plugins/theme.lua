-- TODO: probably should adjust this when I adjust tmux config
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    enabled = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        highlight_overrides = {
          all = {
            LineNr = { fg = '#8aadf4' },
            CursorLineNr = { fg = '#ed8796' },
          },
        },
        transparent_background = true,
      }
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'night',
        dim_inactive = true,
        transparent_background = true,
      }
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
}
