-- Hack solution for transparent background`
return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup {
      background_colour = '#000000',
    }
  end,
  lazy = false,
}