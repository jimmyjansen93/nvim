return {
  {
    'saghen/blink.cmp',
    enabled = true,
    lazy = false,
    version = '1.*',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'echasnovski/mini.nvim',
    },
    build = 'cargo build --release',
    opts = {
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      keymap = { preset = 'default' },
      fuzzy = { sorts = { 'exact', 'score', 'sort_text' }, implementation = 'prefer_rust_with_warning' },
      signature = { enabled = true, window = { show_documentation = false } },
      cmdline = {
        keymap = { preset = 'inherit' },
        completion = { menu = { auto_show = false }, ghost_text = { enabled = false } },
      },
      completion = {
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 5000,
        },
        ghost_text = { enabled = false, show_with_menu = false },
        menu = {
          auto_show = false,
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
              kind = {
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
