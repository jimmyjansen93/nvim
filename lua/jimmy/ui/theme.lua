return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        highlight_overrides = {
          all = {
            LineNr = { fg = "#8aadf4" },
            CursorLineNr = { fg = "#ed8796" },
          },
        },
        transparent_background = true,
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        dim_inactive = true,
        transparent_background = true,
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = true,
      })
    end,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.nord_disable_background = true
      vim.g.nord_enable_sidebar_background = false
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        dimInactive = true,
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        disable_background = true,
        disable_float_background = true,
      })
    end,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = { transparent = true },
      })
    end,
  },
  {
    "navarasu/onedark.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "dark",
        transparent = true,
      })
    end,
  },
  {
    "lunarvim/darkplus.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("dracula").setup({
        transparent_bg = true,
        italic_comment = false,
      })
    end,
  },
  {
    "sainnhe/edge",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.edge_style = "aura"
      vim.g.edge_better_performance = 1
      vim.g.edge_transparent_background = 1
      vim.g.edge_disable_italic_comment = 1
    end,
  },
  {
    "sainnhe/sonokai",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.sonokai_style = "default"
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_transparent_background = 1
      vim.g.sonokai_disable_italic_comment = 1
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = true,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
          terminal_colors = true,
          dim_inactive = false,
          styles = {
            comments = "NONE",
            keywords = "NONE",
            types = "NONE",
            variables = "NONE",
          },
        },
        groups = {
          all = {
            htmlArg = { fg = "fg" },
            htmlBold = { fg = "fg", fmt = "bold" },
            htmlItalic = { fg = "fg", fmt = "italic" },
          },
        },
      })
    end,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.moonflytransparent = true
      vim.g.moonflyitalics = false
    end,
  },
  {
    "oxfist/night-owl.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("night-owl").setup({
        bold = false,
        italics = false,
        underline = false,
        undercurl = false,
        transparent_background = true,
      })
    end,
  },
  {
    "Yazeed1s/minimal.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "RRethy/nvim-base16",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.base16_transparent_background = 1
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        options = {
          transparency = true,
          terminal_colors = true,
          cursorline = false,
        },
        styles = {
          types = "NONE",
          methods = "NONE",
          numbers = "NONE",
          strings = "NONE",
          comments = "NONE",
          keywords = "NONE",
          constants = "NONE",
          functions = "NONE",
          operators = "NONE",
          variables = "NONE",
          parameters = "NONE",
          conditionals = "NONE",
          virtual_text = "NONE",
        },
      })
    end,
  },
  {
    "ramojus/mellifluous.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("mellifluous").setup({
        transparent_background = {
          enabled = true,
        },
        styles = {
          comments = "NONE",
          conditionals = "NONE",
          folds = "NONE",
          loops = "NONE",
          functions = "NONE",
          keywords = "NONE",
          strings = "NONE",
          variables = "NONE",
          numbers = "NONE",
          booleans = "NONE",
          properties = "NONE",
          types = "NONE",
          operators = "NONE",
        },
        color_set = "mellifluous",
      })
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.zenbones_transparent_background = true
      vim.g.zenbones_italic_comments = false
    end,
  },
  {
    "fenetikm/falcon",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.falcon_background = 0
      vim.g.falcon_inactive = 1
    end,
  },
  {
    dir = vim.fn.stdpath("config") .. "/lua/jimmy/ui",
    name = "theme-switcher",
    lazy = false,
    priority = 1000,
    config = function()
      local themes = {
        { name = "tokyonight", display = "Tokyo Night" },
        { name = "catppuccin-macchiato", display = "Catppuccin Macchiato" },
        { name = "gruvbox", display = "Gruvbox" },
        { name = "nord", display = "Nord" },
        { name = "kanagawa", display = "Kanagawa" },
        { name = "rose-pine", display = "Rose Pine" },
        { name = "oxocarbon", display = "Oxocarbon" },
        { name = "nightfox", display = "Nightfox" },
        { name = "onedark", display = "OneDark" },
        { name = "darkplus", display = "Dark+ (High Contrast)" },
        { name = "dracula", display = "Dracula (Minimal)" },
        { name = "edge", display = "Edge (High Contrast)" },
        { name = "sonokai", display = "Sonokai (Minimal)" },
        { name = "github_dark", display = "GitHub Dark (Minimal)" },
        { name = "github_dark_high_contrast", display = "GitHub Dark High Contrast" },
        { name = "moonfly", display = "Moonfly (High Contrast)" },
        { name = "night-owl", display = "Night Owl (Minimal)" },
        { name = "minimal", display = "Minimal (Ultra Simple)" },
        { name = "base16-default-dark", display = "Base16 Default Dark" },
        { name = "base16-gruvbox-dark-hard", display = "Base16 Gruvbox (High Contrast)" },
        { name = "base16-tomorrow-night", display = "Base16 Tomorrow Night" },
        { name = "onedark_pro", display = "OneDark Pro (Minimal)" },
        { name = "mellifluous", display = "Mellifluous (Ultra Minimal)" },
        { name = "zenbones", display = "Zen Bones (Focus Theme)" },
        { name = "falcon", display = "Falcon (High Contrast)" },
      }

      local function save_theme(theme_name)
        local config_file = vim.fn.stdpath("data") .. "/theme_choice.txt"
        local file = io.open(config_file, "w")
        if file then
          file:write(theme_name)
          file:close()
        end
      end

      local function load_saved_theme()
        local config_file = vim.fn.stdpath("data") .. "/theme_choice.txt"
        local file = io.open(config_file, "r")
        if file then
          local theme = file:read("*all"):gsub("%s+", "")
          file:close()
          return theme ~= "" and theme or nil
        end
        return nil
      end

      local function switch_theme()
        vim.ui.select(themes, {
          prompt = "Select theme:",
          format_item = function(item)
            return item.display
          end,
        }, function(choice)
          if choice then
            pcall(vim.cmd.colorscheme, choice.name)
            save_theme(choice.name)
            vim.notify("Theme changed to " .. choice.display, vim.log.levels.INFO)
          end
        end)
      end

      vim.keymap.set("n", "<leader>nt", switch_theme, { desc = "Switch theme" })

      local saved_theme = load_saved_theme()
      if saved_theme then
        pcall(vim.cmd.colorscheme, saved_theme)
      else
        vim.cmd.colorscheme("tokyonight")
      end
    end,
  },
}
