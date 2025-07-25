return {
  {
    "catgoose/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" })
    end,
  },
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofumpt", "golines", "staticcheck" },
        javascript = { "eslint", "prettier" },
        typescript = { "eslint", "prettier" },
        cpp = { "clang-tidy", "clang-format" },
      },
    },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("undotree").setup({
        float_diff = true,
        layout = "left_bottom",
        position = "left",
        ignore_filetype = { "undotree", "undotreeDiff", "qf", "TelescopePrompt", "spectre_panel", "tsplayground" },
        window = {
          winblend = 10,
        },
        keymaps = {
          ["j"] = "move_next",
          ["k"] = "move_prev",
          ["gj"] = "move2parent",
          ["J"] = "move_change_next",
          ["K"] = "move_change_prev",
          ["<cr>"] = "action_enter",
          ["p"] = "enter_diffbuf",
          ["q"] = "quit",
        },
      })

      local webicon = require("nvim-web-devicons")
      local undoIcon = webicon.get_icon("DevIconxmonad", "xmonad")
      require("which-key").add({
        {
          "<leader>u",
          '<CMD>lua require("undotree").toggle()<cr>',
          desc = "Undotree",
          icon = undoIcon,
        },
      })
    end,
  },
}
