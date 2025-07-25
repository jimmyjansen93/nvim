return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    config = function()
      require("go").setup({})
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
  },
  {
    "ziglang/zig.vim",
    ft = { "zig" },
    config = function()
      vim.g.zig_fmt_autosave = 0
    end,
  },
}
