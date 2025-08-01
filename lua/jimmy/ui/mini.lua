return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.icons").setup({
        style = "glyph",
      })
      require("mini.diff").setup({})

      require("mini.ai").setup({
        n_lines = 500,
        custom_textobjects = {
          o = require("mini.ai").gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = require("mini.ai").gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
          }),
          c = require("mini.ai").gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
          }),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          d = { "%f[%d]%d+" },
          e = {
            {
              "%u[%l%d]+%f[^%l%d]",
              "%f[%S][%l%d]+%f[^%l%d]",
              "%f[%P][%l%d]+%f[^%l%d]",
              "^[%l%d]+%f[^%l%d]",
            },
            "^().*()$",
          },
          u = require("mini.ai").gen_spec.function_call(),
          U = require("mini.ai").gen_spec.function_call({ name_pattern = "[%w_]" }),
        },
      })

      require("mini.surround").setup({ enable = false })

      vim.api.nvim_create_autocmd("RecordingEnter", {
        pattern = "*",
        callback = function()
          vim.cmd("redrawstatus")
        end,
      })

      vim.api.nvim_create_autocmd("RecordingLeave", {
        pattern = "*",
        callback = function()
          vim.cmd("redrawstatus")
        end,
      })


      require("mini.move").setup({})
    end,
  },
}
