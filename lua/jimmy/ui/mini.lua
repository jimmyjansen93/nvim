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

      local signs = { ERROR = "●", WARN = "●", INFO = "●", HINT = "●" }

      require("mini.statusline").setup({
        content = {
          active = function()
            local MiniStatusline = require("mini.statusline")
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 40 })
            local diagnostics = MiniStatusline.section_diagnostics({
              trunc_width = 75,
              signs = signs,
            })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })

            local check_macro_recording = function()
              if vim.fn.reg_recording() ~= "" then
                return " REC @" .. vim.fn.reg_recording()
              else
                return ""
              end
            end
            local macro = check_macro_recording()

            return MiniStatusline.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
              { hl = "MiniStatuslineFilename", strings = { macro } },
              "%<",
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=",
              { hl = "MiniStatuslineDevinfo", strings = { git } },
            })
          end,
          inactive = function()
            local MiniStatusline = require("mini.statusline")
            return MiniStatusline.combine_groups({
              {
                hl = "MiniStatuslineFilename",
                strings = { MiniStatusline.section_filename({ trunc_width = 140 }) },
              },
              "%=",
            })
          end,
        },

        use_icons = true,
        set_vim_settings = false,
      })

      require("mini.move").setup({})
    end,
  },
}
