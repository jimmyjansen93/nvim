return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.icons').setup {
        style = 'glyph',
      }
      require('mini.git').setup()
      require('mini.diff').setup()

      require('mini.statusline').setup {
        content = {
          active = function()
            local MiniStatusline = require 'mini.statusline'

            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
            local git = MiniStatusline.section_git { trunc_width = 40 }
            local diff = MiniStatusline.section_diff { trunc_width = 75 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
            local filename = MiniStatusline.section_filename { trunc_width = 12000 }

            return MiniStatusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { diagnostics, lsp } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineDevinfo', strings = { diff } },
              { hl = 'MiniStatuslineDevinfo', strings = { git } },
            }
          end,
          inactive = nil,
        },

        use_icons = true,
        set_vim_settings = true,
      }
    end,
  },
}
