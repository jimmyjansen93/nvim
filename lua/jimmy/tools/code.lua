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
        window = {
          winblend = 10,
        },
      })

      require("which-key").add({
        {
          "<leader>cu",
          '<CMD>lua require("undotree").toggle()<cr>',
          desc = "Undotree",
          icon = require("nvim-web-devicons").get_icon("DevIconxmonad", "xmonad"),
        },
      })
    end,
  },
}
