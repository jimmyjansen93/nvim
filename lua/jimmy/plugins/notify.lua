-- Hack solution for transparent background`
return {
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        background_colour = '#000000',
      }
    end,
    lazy = false,
  },
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
          {
            filter = { event = 'msg_show', kind = 'search_count' },
            opts = { skip = true },
          },
        },
        notify = { enabled = false },
        messages = { enabled = false },
        presets = {
          bottom_search = true,
          long_message_to_split = true,
          inc_rename = true,
          lsp_doc_border = false,
        },
        views = {
          cmdline_popup = {
            position = {
              row = 18,
            },
            size = {
              width = 60,
              height = 'auto',
            },
          },
          popupmenu = {
            position = {
              row = 20,
              col = 70,
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
}
