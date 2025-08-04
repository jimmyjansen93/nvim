vim.cmd("comp! harv")

vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2

vim.opt_local.errorformat = "%f:%l:%c: %t%*[^:]: %m,%f:%l: %t%*[^:]: %m,%f:(%l\\,%c): %t%*[^:]: %m"


vim.keymap.set("n", "<leader>cc", "<CMD>copen<CR>", { buffer = true, desc = "Open quickfix" })
vim.keymap.set("n", "<leader>cn", "<CMD>cnext<CR>", { buffer = true, desc = "Next quickfix" })
vim.keymap.set("n", "<leader>cp", "<CMD>cprevious<CR>", { buffer = true, desc = "Prev quickfix" })
vim.keymap.set("n", "<leader>cl", "<CMD>clist<CR>", { buffer = true, desc = "List quickfix" })
vim.keymap.set("n", "<leader>cr", "<cmd>!g++ -o %< % && ./%<<cr>", { buffer = true, desc = "Run current file" })
vim.keymap.set("n", "<leader>ch", "<CMD>compiler harv<CR>", { buffer = true, desc = "Compiler! harv" })
vim.keymap.set("n", "<leader>rb", "<CMD>!./build build<CR>", { buffer = true, desc = "Build project" })
vim.keymap.set("n", "<leader>rr", "<CMD>!./build run<CR>", { buffer = true, desc = "Run project" })
vim.keymap.set("n", "<leader>rt", "<CMD>!./build test<CR>", { buffer = true, desc = "Test project" })
