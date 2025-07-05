local set = vim.opt_local
set.shiftwidth = 2

local webicon = require 'nvim-web-devicons'
local sourceIcon = webicon.get_icon('DevIconLua', 'lua')
require('which-key').add {
  {
    '<leader>z',
    '<CMD>source %<CR><CMD>lua print "Sourced"<CR>',
    desc = 'Source lua',
    icon = sourceIcon,
  },
}
