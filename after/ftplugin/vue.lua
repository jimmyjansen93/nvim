vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true

vim.keymap.set("n", "<leader>rf", "<cmd>VueFormat<cr>", { buffer = true, desc = "Format Vue file" })