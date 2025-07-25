vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.list = false

vim.cmd("wincmd L")
vim.cmd("vertical resize 90")

vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, desc = "Close help" })
