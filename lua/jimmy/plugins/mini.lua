return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.icons').setup {
        style = 'glyph',
      }
    end,
  },
}
