return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local overseer = require 'overseer'
      require('lualine').setup {
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            {
              'overseer',
              colored = true,
              symbols = {
                [overseer.STATUS.FAILURE] = '󰅚 ',
                [overseer.STATUS.CANCELED] = ' ',
                [overseer.STATUS.SUCCESS] = '󰄴 ',
                [overseer.STATUS.RUNNING] = '󰑮 ',
              },
            },
          },

          lualine_c = {
            'filename',
          },
          lualine_x = {},
          lualine_y = { { 'buffers' } },
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        disabled_filetypes = {},
        ignore_focus = { 'overseer', 'NeogitStatus' },
      }
    end,
  },
}
