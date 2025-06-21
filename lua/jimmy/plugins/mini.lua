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

      require('mini.surround').setup {
        enable = false,
        custom_surroundings = nil,
        search_method = 'cover',
        highlight_duration = 500,
        n_lines = 20,
        respect_selection_type = false,
        silent = false,

        mappings = {
          add = 'sa',
          delete = 'sd',
          find = 'sf',
          find_left = 'sF',
          highlight = 'sh',
          replace = 'sr',
          update_n_lines = 'sn',

          suffix_last = 'l',
          suffix_next = 'n',
        },
      }

      vim.api.nvim_create_autocmd('RecordingEnter', {
        pattern = '*',
        callback = function()
          vim.cmd 'redrawstatus'
        end,
      })

      vim.api.nvim_create_autocmd('RecordingLeave', {
        pattern = '*',
        callback = function()
          vim.cmd 'redrawstatus'
        end,
      })

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

            local check_macro_recording = function()
              if vim.fn.reg_recording() ~= '' then
                return 'Recording @' .. vim.fn.reg_recording()
              else
                return ''
              end
            end
            local macro = check_macro_recording()

            return MiniStatusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { diagnostics, lsp } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFilename', strings = { macro } },
              { hl = 'MiniStatuslineDevinfo', strings = { diff } },
              { hl = 'MiniStatuslineDevinfo', strings = { git } },
            }
          end,
          inactive = nil,
        },

        use_icons = true,
        set_vim_settings = true,
      }

      require('mini.move').setup {
        mappings = {
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',

          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },

        options = {
          reindent_linewise = true,
        },
      }
    end,
  },
}
