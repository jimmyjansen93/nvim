return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('noice').setup {
        lsp = {
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = false,
          },
        },
        routes = {
          {
            filter = {
              event = 'msg_show',
              kind = '',
              find = 'written',
            },
            opts = { skip = true },
          },
        },
        presets = {
          bottom_search = true,
          long_message_to_split = true,
          inc_rename = true,
          lsp_doc_border = false,
        },
        views = {
          cmdline_popup = {
            position = {
              row = 28,
              col = 20,
            },
            size = {
              width = 60,
              height = 'auto',
            },
          },
          popupmenu = {
            position = {
              row = 30,
              col = 19,
            },
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = 'rounded',
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
            },
          },
        },
      }
    end,
  },

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

  {
    'anuvyklack/fold-preview.nvim',
    dependencies = { 'anuvyklack/keymap-amend.nvim' },
    event = 'BufEnter',
    config = function()
      local fp = require 'fold-preview'
      local map = require('fold-preview').mapping
      local keymap = vim.keymap
      keymap.amend = require 'keymap-amend'

      fp.setup {
        default_keybindings = false,
      }

      keymap.amend('n', 'L', function(original)
        if not fp.toggle_preview() then
          original()
        end
      end)
      keymap.amend('n', 'l', map.close_preview_open_fold)
      keymap.amend('n', 'zo', map.close_preview)
      keymap.amend('n', 'zO', map.close_preview)
      keymap.amend('n', 'zc', map.close_preview_without_defer)
      keymap.amend('n', 'zR', map.close_preview)
      keymap.amend('n', 'zM', map.close_preview_without_defer)
    end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

      require('neo-tree').setup {
        close_if_last_window = true,
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = true,
        default_component_configs = {
          git_status = {
            symbols = {
              added = '󱤧',
              modified = '',
              deleted = '',
              renamed = '󰁕',
              untracked = '',
              ignored = '',
              unstaged = '',
              staged = '󰘾',
              conflict = '',
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>ft', '<CMD>Neotree toggle<CR>', { desc = 'Neotree toggle' })
      vim.keymap.set('n', '<leader>ff', '<CMD>Neotree position=current<CR>', { desc = 'Neotree fullscreen' })
    end,
  },
}
