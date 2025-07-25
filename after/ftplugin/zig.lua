vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4

vim.opt_local.makeprg = "zig build"
vim.opt_local.errorformat = "%f:%l:%c: error: %m,%f:%l:%c: note: %m"

vim.cmd("compiler zig")

require("which-key").add({
  {
    "<leader>cr",
    "<cmd>!zig run %<cr>",
    desc = "Run current file",
  },
  {
    "<leader>ct",
    "<cmd>!zig test %<cr>",
    desc = "Run tests",
  },
  {
    "<leader>cc",
    "<cmd>!zig build-exe %<cr>",
    desc = "Compile file",
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
