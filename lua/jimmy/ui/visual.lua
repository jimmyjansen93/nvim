return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
        highlight = { "IblScope" },
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        highlight = { "IblScope" },
      },
      exclude = {
        filetypes = {
          "Trouble",
          "trouble",
          "lazy",
          "notify",
          "toggleterm",
        },
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#ff007c", fg = "#c9c7cd", bold = true })
      vim.api.nvim_set_hl(0, "FlashMatch", { bg = "#3d59a1", fg = "#c9c7cd" })
      vim.api.nvim_set_hl(0, "FlashCurrent", { bg = "#ff9e3b", fg = "#1d2021", bold = true })
      vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#545c7e" })

      require("flash").setup({
        labels = "asdfghjklqwertyuiopzxcvbnm",
        search = {
          multi_window = true,
          forward = true,
          wrap = true,
          mode = "exact",
          incremental = false,
          exclude = {
            "notify",
            "cmp_menu",
            "noice",
            "flash_prompt",
          },
        },
        jump = {
          jumplist = true,
          pos = "start",
          history = false,
          register = false,
          nohlsearch = false,
          autojump = false,
        },
        label = {
          uppercase = true,
          exclude = "",
          current = true,
          after = true,
          before = false,
          style = "overlay",
          reuse = "lowercase",
          distance = true,
          min_pattern_length = 0,
          rainbow = {
            enabled = false,
            shade = 5,
          },
          format = function(opts)
            return { { opts.match.label, opts.hl_group } }
          end,
        },
        highlight = {
          backdrop = true,
          matches = true,
          priority = 5000,
          groups = {
            match = "FlashMatch",
            current = "FlashCurrent",
            backdrop = "FlashBackdrop",
            label = "FlashLabel",
          },
        },
        action = nil,
        pattern = "",
        continue = false,
        config = nil,
        prompt = {
          enabled = true,
          prefix = { { "⚡", "FlashPromptIcon" } },
          win_config = {
            relative = "editor",
            width = 1,
            height = 1,
            row = -1,
            col = 0,
            zindex = 1000,
          },
        },
        remote_op = {
          restore = false,
          motion = false,
        },
      })

      vim.keymap.set({ "n", "x", "o" }, "s", function()
        require("flash").jump()
      end, { desc = "Flash" })

      vim.keymap.set({ "n", "x", "o" }, "S", function()
        require("flash").treesitter()
      end, { desc = "Flash treesitter" })

      vim.keymap.set("o", "r", function()
        require("flash").remote()
      end, { desc = "Remote flash" })

      vim.keymap.set({ "o", "x" }, "R", function()
        require("flash").treesitter_search()
      end, { desc = "Treesitter search" })

      vim.keymap.set("c", "<c-s>", function()
        require("flash").toggle()
      end, { desc = "Toggle flash search" })
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    enabled = false,
    lazy = false,
    priority = 200,
    config = function()
      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })

      local rainbow_delimiters = require("rainbow-delimiters")

      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },
}
