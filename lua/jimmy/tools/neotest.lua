return {
  {
    "nvim-neotest/neotest",
    enabled = true,
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
          "<leader>rn",
          function()
            require("neotest").run.run()
          end,
          desc = "Run nearest test",
        },
        {
          "<leader>rf",
          function()
            require("neotest").run.run(vim.fn.expand("%"))
          end,
          desc = "Test current file",
        },
        {
          "<leader>rd",
          function()
            require("neotest").run.run({ vim.fn.getcwd() })
          end,
          desc = "Test directory",
        },
        {
          "<leader>rw",
          function()
            require("neotest").watch.toggle()
          end,
          desc = "Watch tests",
        },
        {
          "<leader>rv",
          function()
            require("neotest").output_panel.toggle()
          end,
          desc = "Toggle test output",
        },
        {
          "<leader>rS",
          function()
            require("neotest").summary.toggle()
          end,
          desc = "Toggle test summary",
        },
      })
    end,
  },
}
