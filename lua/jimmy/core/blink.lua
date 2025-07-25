return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "echasnovski/mini.nvim",
      "L3MON4D3/LuaSnip",
    },
    build = "cargo build --release",
    opts = {
      keymap = {
        ["<Tab>"] = {
          function(cmp)
            if require("luasnip").expand_or_jumpable() then
              return require("luasnip").expand_or_jump()
            else
              return cmp.select_next()
            end
          end,
          "snippet_forward",
          "select_next",
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if require("luasnip").jumpable(-1) then
              return require("luasnip").jump(-1)
            else
              return cmp.select_prev()
            end
          end,
          "snippet_backward",
          "select_prev",
          "fallback",
        },
      },
      signature = { window = { show_documentation = false } },
      cmdline = {
        completion = { menu = { auto_show = false }, ghost_text = { enabled = false } },
      },
      completion = {
        documentation = { auto_show = false },
        ghost_text = { enabled = false },
        menu = {
          auto_show = false,
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  return require("mini.icons").get("lsp", ctx.kind)
                end,
                highlight = function(ctx)
                  local _, hl = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
              kind = {
                highlight = function(ctx)
                  local _, hl = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
        list = { selection = { preselect = false } },
      },
    },
  },
}
