return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
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
          },
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
          -- autocomplete = false,
        },

        mapping = cmp.mapping.preset.insert {
          ['<C-x>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
        },
      }
    end,
  },
}
