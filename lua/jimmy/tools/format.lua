return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          go = { "goimports", "gofmt" },
          rust = { "rustfmt" },
          zig = { "zig fmt" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
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
        },

        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,

        format_after_save = {
          lsp_fallback = true,
        },
      })

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

      vim.api.nvim_create_user_command("FormatInfo", function()
        require("conform").formatters_by_ft()
      end, { desc = "Show formatter info" })
    end,
  },
}
