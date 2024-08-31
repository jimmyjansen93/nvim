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
        -- :h MiniSurround.config
        custom_surroundings = nil,

        -- :h MiniSurround.config
        search_method = 'cover',

        highlight_duration = 500,
        n_lines = 20,
        respect_selection_type = false,
        silent = false,

        mappings = {
          add = 'sa', -- Add surrounding in Normal and Visual modes
          delete = 'sd', -- Delete surrounding
          find = 'sf', -- Find surrounding (to the right)
          find_left = 'sF', -- Find surrounding (to the left)
          highlight = 'sh', -- Highlight surrounding
          replace = 'sr', -- Replace surrounding
          update_n_lines = 'sn', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
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
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',

          -- Move current line in Normal mode
          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },

        -- Options which control moving behavior
        options = {
          -- Automatically reindent selection during linewise vertical move
          reindent_linewise = true,
        },
      }
    end,
  },
}
