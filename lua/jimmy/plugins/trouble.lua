return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      use_diagnostic_signs = true,
      focus = true,
      warn_no_results = false,
      open_no_results = false,
      modes = {
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
        -- lsp_references = {
        --   params = {
        --     include_declaration = true,
        --   },
        -- },
        -- lsp_base = {
        --   params = {
        --     include_current = false,
        --   },
        -- },
        symbols = {
          desc = "Document Symbols",
          win = { position = "bottom" },
          focus = true,
        },
      },
    },
    keys = {
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Workspace Diagnostics",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Document Diagnostics",
      },
      {
        "<leader>xs",
        "<cmd>Trouble lsp_document_symbols toggle<cr>",
        desc = "Symbols Trouble",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Workspace Diagnostics",
      },
      {
        "<leader>xl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List",
      },
      {
        "<leader>xq",
        "<cmd>Trouble quickfix toggle<cr>",
        desc = "Quickfix List",
      },
      {
        "[q",
        '<cmd>lua require("trouble").previous { skip_groups = true, jump = true }<cr>',
        desc = "Previous quickfix item",
      },
      {
        "]q",
        '<cmd>lua require("trouble").next { skip_groups = true, jump = true }<cr>',
        desc = "Next trouble/quickfix item",
      },
      -- {
      --   'gR',
      --   '<cmd>lua require("trouble").toggle()<cr>',
      --   desc = 'lsp references',
      -- },
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
