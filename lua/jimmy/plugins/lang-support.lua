return {
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    lazy = false,
    opts = {},
  },
  { "gpanders/editorconfig.nvim" },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "b0o/schemastore.nvim", lazy = true },
}
