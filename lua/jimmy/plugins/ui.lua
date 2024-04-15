return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        sections = {
          lualine_x = {},
          lualine_y = { { 'buffers' } },
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = {},
          lualine_y = { { 'buffers' } },
          lualine_z = {},
        },
      }
    end,
  },
}
