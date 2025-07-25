return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
          injected_languages = false,
          highlight = { "Function", "Label" },
          priority = 500,
        },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "trouble",
            "lazy",
            "notify",
            "toggleterm",
            "lazyterm",
          },
          buftypes = {
            "terminal",
            "nofile",
            "quickfix",
            "prompt",
          },
        },
      })
    end,
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
}
