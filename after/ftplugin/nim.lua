vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2

vim.opt_local.makeprg = "nim c -r"

local nimble_files = vim.fs.find("%.nimble", { upward = true, stop = vim.fn.expand("~"), type = "file", limit = 3 })

if #nimble_files > 0 then
  vim.cmd("compiler nimble")
else
  vim.cmd("compiler nim")
end

vim.keymap.set("n", "<leader>cr", "<cmd>!nim c -r %<cr>", { buffer = true, desc = "Run current file" })

vim.keymap.set("n", "<leader>cb", "<cmd>!nimble build<cr>", { buffer = true, desc = "Build project" })

vim.keymap.set("n", "<leader>ct", "<cmd>!nimble test<cr>", { buffer = true, desc = "Run tests" })

vim.keymap.set("n", "<leader>cc", "<cmd>!nim c %<cr>", { buffer = true, desc = "Compile file" })

