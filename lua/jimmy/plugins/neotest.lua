return {
  {
    "nvim-neotest/neotest",
    enabled = false,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "fredrikaverpil/neotest-golang",
        version = "*",
        dependencies = {
          { "andythigpen/nvim-coverage", opts = { auto_reload = true } },
        },
      },
      "marilari88/neotest-vitest",
      "arthur944/neotest-bun",
      "lawrence-laz/neotest-zig",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest")({
            filter_dir = function(name, _, _)
              return name ~= "node_modules"
            end,
          }),
          require("neotest-bun")({}),
          require("neotest-zig")({
            dap = {
              adapter = "lldb",
            },
          }),
          require("neotest-golang")({
            runner = "go",
            go_test_args = {
              "-v",
              "-race",
              "-count=1",
              "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
            },
          }),
        },
      })

      require("which-key").add({
        {
          "<leader>rF",
          function()
            require("neotest").run.run(vim.fn.expand("%"))
          end,
          desc = "Test current file",
        },
        {
          "<leader>rt",
          function()
            require("neotest").run.run(vim.fn.getcwd())
          end,
          desc = "Test Project",
        },
        {
          "<leader>rT",
          function()
            require("neotest").run.run({ vim.fn.getcwd(), extra_args = { "--fuzz" } })
          end,
          desc = "Test Project fuzzy",
        },
      })
    end,
  },
}
