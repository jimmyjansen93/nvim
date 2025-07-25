return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      use_diagnostic_signs = true,
      focus = true,
      warn_no_results = false,
      open_no_results = false,
      auto_close = false,
      auto_open = false,
      auto_preview = true,
      auto_refresh = true,
      modes = {
        problems = {
          desc = "All Problems (LSP + Build + Lint)",
          mode = "diagnostics",
          win = {
            size = { height = 20 },
            position = "bottom",
          },
          filter = {
            any = {
              buf = 0,
              {
                source = function(item)
                  return item.source
                    and (
                      item.source:find("LSP")
                      or item.source:find("Build")
                      or item.source:find("Test")
                      or item.source:find("Lint")
                    )
                end,
              },
            },
          },
          sort = { "filename", "lnum", "col" },
          groups = {
            { "filename", format = "{file_icon} {filename} {count}" },
          },
        },
        qflist = {
          win = {
            size = { height = 20 },
          },
          filter = function(items)
            return vim.tbl_filter(function(item)
              local filename = item.filename or ""
              local text = item.text or ""
              if text:match("panic") or text:match("crash") then
                return true
              end
              return not filename:match("^/opt/homebrew/")
                and not filename:match("^/usr/")
                and not filename:match("%.zig%-cache/")
            end, items)
          end,
        },
        symbols = {
          desc = "Document Symbols",
          win = { position = "bottom" },
          focus = true,
        },
      },
    },
    keys = {
      {
        "<leader>xp",
        "<cmd>Trouble problems toggle<cr>",
        desc = "Toggle problems panel",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Workspace Diagnostics",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Document Diagnostics",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle<cr>",
        desc = "Symbols Trouble",
      },
      {
        "<leader>xl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List",
      },
      {
        "]d",
        function()
          require("trouble").next({ skip_groups = true, jump = true })
        end,
        desc = "Next problem",
      },
      {
        "[d",
        function()
          require("trouble").prev({ skip_groups = true, jump = true })
        end,
        desc = "Previous problem",
      },
      {
        "[q",
        function()
          require("trouble").prev({ skip_groups = true, jump = true })
        end,
        desc = "Previous quickfix item",
      },
      {
        "]q",
        function()
          require("trouble").next({ skip_groups = true, jump = true })
        end,
        desc = "Next trouble/quickfix item",
      },
      {
        "<leader>xf",
        function()
          require("telescope.builtin").diagnostics({
            bufnr = 0,
            winblend = 10,
            layout_config = {
              width = 0.9,
              height = 0.7,
              prompt_position = "top",
            },
          })
        end,
        desc = "Show Floating Diagnostics",
      },
      {
        "<leader>xr",
        function()
          require("trouble").refresh()
          vim.notify("Refreshed problems", vim.log.levels.INFO)
        end,
        desc = "Refresh problems",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      search = { pattern = "(KEYWORDS)(((.+?)))??(:)" },
      highlight = { pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]] },
    },
    keys = {
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme Trouble" },
    },
  },
}
