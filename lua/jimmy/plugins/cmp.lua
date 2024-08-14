return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'zbirenbaum/copilot-cmp',
        config = function()
          require('copilot_cmp').setup()
        end,
      },
      -- {
      --   'zbirenbaum/copilot.lua',
      --   opts = {
      --     panel = { enabled = false },
      --     suggestion = { enabled = false },
      --   },
      -- },

      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      -- 'hrsh7th/cmp-nvim-lsp-signature-help',
      {
        'David-Kunz/cmp-npm',
        dependencies = { 'nvim-lua/plenary.nvim' },
        ft = 'json',
        config = function()
          require('cmp-npm').setup {}
        end,
      },

      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'

      cmp.setup {
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol',
            maxwidth = function()
              return math.floor(0.4 * vim.o.columns)
            end,
            ellipsis_char = '...',
            symbol_map = { Copilot = '' },
          },
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
          { name = 'npm', keyword_length = 4 },
        },
      }
    end,
  },
}
