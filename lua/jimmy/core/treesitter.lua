return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.install").prefer_git = true

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "scss",
          "diff",
          "git_rebase",
          "git_config",
          "gitignore",
          "gomod",
          "regex",
          "http",
          "llvm",
          "make",
          "sql",
          "ssh_config",
          "tmux",
          "xml",
          "yaml",
          "json",
          "zig",
          "html",
          "lua",
          "markdown",
          "vimdoc",
          "rust",
          "javascript",
          "typescript",
          "tsx",
          "go",
          "vue",
          "svelte",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gni",
            node_incremental = "gnn",
            scope_incremental = "gns",
            node_decremental = "gnd",
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            include_surrounding_whitespace = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Select around function" },
              ["if"] = { query = "@function.inner", desc = "Select inside function" },
              ["ac"] = { query = "@class.outer", desc = "Select around class" },
              ["ic"] = { query = "@class.inner", desc = "Select inside class" },
              ["aa"] = { query = "@parameter.outer", desc = "Select around argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inside argument" },
              ["ab"] = { query = "@block.outer", desc = "Select around block" },
              ["ib"] = { query = "@block.inner", desc = "Select inside block" },
              ["ai"] = { query = "@conditional.outer", desc = "Select around conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inside conditional" },
            },
          },

          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]]"] = { query = "@function.outer", desc = "Next function start" },
              ["]p"] = { query = "@parameter.inner", desc = "Next argument" },
              ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
              ["]/"] = { query = "@comment.outer", desc = "Next Comment start" },
            },
            goto_previous_start = {
              ["[["] = { query = "@function.outer", desc = "Prev function start" },
              ["[p"] = { query = "@parameter.inner", desc = "Prev argument" },
              ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
              ["[/"] = { query = "@comment.outer", desc = "Prev comment start" },
            },
          },

          swap = {
            enable = true,
            swap_next = { ["grb"] = { query = "@parameter.inner", desc = "Swap with next argument" } },
            swap_previous = { ["grB"] = { query = "@parameter.inner", desc = "Swap with previous argument" } },
          },
        },
      })
    end,
  },
  {
    "andymass/vim-matchup",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      surround = { enabled = 1 },
      treesitter = {
        enabled = 1,
        stopline = 500,
      },
    },
  },
}
