return {
  {
    "mfussenegger/nvim-lint",
    ft = { "asm", "nasm" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = vim.tbl_extend("force", lint.linters_by_ft or {}, {
        asm = { "nasm" },
      })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = { "*.asm", "*.s", "*.S" },
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "asm" })
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        asm = { "asmfmt" },
      })

      opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
        asmfmt = {
          command = "asmfmt",
          args = { "-w", "$FILENAME" },
          stdin = false,
        },
      })
    end,
  },
}
