return {
  {
    'saghen/blink.cmp',
    enabled = false,
    lazy = false,
    dependencies = {
      'rafamadriz/friendly-snippets',
      {
        'saghen/blink.compat',
        optional = true,
        opts = {},
        version = '*',
      },
    },
    build = 'cargo build --release',
    version = 'v0.*',
    event = 'InsertEnter',
    opts = {
      completion = {
        accept = {
          auto_brackets = {
            enabled = false,
          },
        },
        menu = {
          draw = {
            treesitter = { 'lsp' },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        cmdline = {},
      },
      keymap = {
        ['K'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<Esc><Esc>'] = { 'hide' },
        ['<C-y>'] = { 'select_and_accept' },

        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },

      highlight = {
        use_nvim_cmp_as_default = true,
      },
      nerd_font_variant = 'normal',
      trigger = { signature_help = { enabled = true } },
    },
    -- config = function(_, opts)
    --   local enabled = opts.sources.default
    --   for _, source in ipairs(opts.sources.compat or {}) do
    --     opts.sources.providers[source] = vim.tbl_deep_extend('force', { name = source, module = 'blink.compat.source' }, opts.sources.providers[source] or {})
    --     if type(enabled) == 'table' and not vim.tbl_contains(enabled, source) then
    --       table.insert(enabled, source)
    --     end
    --   end
    --
    --   opts.sources.compat = nil
    --
    --   for _, provider in pairs(opts.sources.providers or {}) do
    --     if provider.kind then
    --       local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
    --       local kind_idx = #CompletionItemKind + 1
    --
    --       CompletionItemKind[kind_idx] = provider.kind
    --       CompletionItemKind[provider.kind] = kind_idx
    --
    --       local transform_items = provider.transform_items
    --       provider.transform_items = function(ctx, items)
    --         items = transform_items and transform_items(ctx, items) or items
    --         for _, item in ipairs(items) do
    --           item.kind = kind_idx or item.kind
    --         end
    --         return items
    --       end
    --
    --       provider.kind = nil
    --     end
    --   end
    --
    --   require('blink.cmp').setup(opts)
    -- end,
  },
}
