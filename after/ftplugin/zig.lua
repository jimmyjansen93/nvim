vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.tabstop = 8

vim.cmd("compiler zig")

require("which-key").add({
  {
    "<leader>cc",
    "<CMD>copen<CR>",
    desc = "Open quickfix",
  },
  {
    "<leader>cn",
    "<CMD>cnext<CR>",
    desc = "Next quickfix",
  },
  {
    "<leader>cp",
    "<CMD>cprevious<CR>",
    desc = "Prev quickfix",
  },
  {
    "<leader>cl",
    "<CMD>clist<CR>",
    desc = "List quickfix",
  },
  {
    "<leader>r",
    group = "Run",
  },
  {
    "<leader>rb",
    "<CMD>ZigBuild<CR>",
    desc = "Build project",
  },
  {
    "<leader>rr",
    "<CMD>ZigRun<CR>",
    desc = "Run project",
  },
  {
    "<leader>rt",
    "<CMD>ZigTest<CR>",
    desc = "Test project",
  },
  {
    "<leader>rT",
    "<CMD>ZigTestFuzz<CR>",
    desc = "Fuzz Test project",
  },
  {
    "<leader>rf",
    "<CMD>ZigRunFile<CR>",
    desc = "Run current file",
  },
  {
    "<leader>rF",
    "<CMD>ZigTestFile<CR>",
    desc = "Test current file",
  },
  {
    "<leader>re",
    "<CMD>ZigBuildExe<CR>",
    desc = "Build current file as exe",
  },
})
