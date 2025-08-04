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
  {
    "mfussenegger/nvim-lint",
    ft = { "odin" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = vim.tbl_extend("force", lint.linters_by_ft or {}, {
        odin = { "odin_check" },
      })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = { "*.odin" },
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
        vim.list_extend(opts.ensure_installed, { "odin" })
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        odin = { "odin fmt" },
      })

      opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
        ["odin fmt"] = {
          command = "odin",
          args = { "fmt", "-file", "$FILENAME" },
          stdin = false,
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    ft = { "ocaml" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = vim.tbl_extend("force", lint.linters_by_ft or {}, {
        ocaml = { "dune_check" },
      })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = { "*.ml", "*.mli" },
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
        vim.list_extend(opts.ensure_installed, { "ocaml" })
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        ocaml = { "ocamlformat" },
      })

      opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
        ocamlformat = {
          command = "ocamlformat",
          args = { "--name", "$FILENAME", "-" },
          stdin = true,
        },
      })
    end,
  },
}
