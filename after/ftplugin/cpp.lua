vim.cmd("comp! harv")

vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2

vim.opt_local.errorformat = "%f:%l:%c: %t%*[^:]: %m,%f:%l: %t%*[^:]: %m,%f:(%l\\,%c): %t%*[^:]: %m"

local timer = vim.uv.new_timer()
if timer == nil then
  return
end

timer:start(
  60000,
  60000,
  vim.schedule_wrap(function()
    vim.loop.spawn(
      "ctags",
      ---@diagnostic disable-next-line: missing-fields
      {
        args = { "-R", "." },
        cwd = vim.fn.getcwd(),
        detached = true,
      },
      function() end
    )
  end)
)

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
    "<leader>cr",
    "<cmd>!g++ -o %< % && ./%<<cr>",
    desc = "Run current file",
  },
  {
    "<leader>cc",
    "<cmd>!g++ -Wall -Wextra -std=c++17 % -o %:r<cr>",
    desc = "Compile file",
  },
  {
    "<leader>ch",
    "<CMD>compiler harv<CR>",
    desc = "Compiler! harv",
  },
  {
    "<leader>r",
    group = "Run",
  },
  {
    "<leader>rb",
    "<CMD>!./build build<CR>",
    desc = "Build project",
  },
  {
    "<leader>rr",
    "<CMD>!./build run<CR>",
    desc = "Run project",
  },
  {
    "<leader>rt",
    "<CMD>!./build test<CR>",
    desc = "Test project",
  },
})
