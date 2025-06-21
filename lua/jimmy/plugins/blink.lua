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
      fuzzy = { sorts = { 'exact', 'score', 'sort_text' } },
      completion = {
        implementation = 'prefer_rust_with_warning',
        documentation = {
          auto_show = false,
          auto_show_delay = 5000,
        },
        cmdline = {
          keymap = { preset = 'inherit' },
        },
        ghost_text = { enabled = false, show_with_menu = false },
        signature = { enabled = true, window = { show_documentation = false } },
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
