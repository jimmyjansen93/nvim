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
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,

      format_after_save = {
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        javascript = { "eslint", "prettier" },
        typescript = { "eslint", "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        rust = { "rustfmt" },
        zig = { "zig fmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        odin = { "odin fmt" },
        ocaml = { "ocamlformat" },
      },

      formatters = {
        ["zig fmt"] = {
          command = "zig",
          args = { "fmt", "--stdin" },
          stdin = true,
        },
        clang_format = {
          prepend_args = { "--style=file", "--fallback-style=Google" },
        },
        ["odin fmt"] = {
          command = "odin",
          args = { "fmt", "-file", "$FILENAME" },
          stdin = false,
        },
        ocamlformat = {
          command = "ocamlformat",
          args = { "--name", "$FILENAME", "-" },
          stdin = true,
        },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)

      local function format_buffer()
        require("conform").format({ async = true, lsp_fallback = true })
      end

      local function toggle_format_on_save()
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          vim.notify("Format on save: ENABLED", vim.log.levels.INFO)
        else
          vim.g.disable_autoformat = true
          vim.notify("Format on save: DISABLED", vim.log.levels.INFO)
        end
      end

      local function toggle_format_on_save_buffer()
        local bufnr = vim.api.nvim_get_current_buf()
        if vim.b[bufnr].disable_autoformat then
          vim.b[bufnr].disable_autoformat = false
          vim.notify("Format on save (buffer): ENABLED", vim.log.levels.INFO)
        else
          vim.b[bufnr].disable_autoformat = true
          vim.notify("Format on save (buffer): DISABLED", vim.log.levels.INFO)
        end
      end

      vim.keymap.set("n", "<leader>cf", format_buffer, { desc = "Format buffer" })
      vim.keymap.set("n", "<leader>cF", toggle_format_on_save, { desc = "Toggle format on save" })
      vim.keymap.set("n", "<leader>cB", toggle_format_on_save_buffer, { desc = "Toggle format on save (buffer)" })
    end,
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
