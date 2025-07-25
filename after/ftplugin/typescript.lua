vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2

vim.keymap.set("n", "<leader>cr", "<cmd>!npx tsx %<cr>", { buffer = true, desc = "Run current file" })

vim.keymap.set("n", "<leader>cb", "<cmd>!npm run build<cr>", { buffer = true, desc = "Build project" })

vim.keymap.set("n", "<leader>ct", "<cmd>!npm test<cr>", { buffer = true, desc = "Run tests" })

vim.keymap.set("n", "<leader>ci", "<cmd>!npm install<cr>", { buffer = true, desc = "Install deps" })

vim.keymap.set("n", "<leader>cs", "<cmd>!npm start<cr>", { buffer = true, desc = "Start server" })

vim.keymap.set("n", "<leader>cc", "<cmd>!npx tsc --noEmit<cr>", { buffer = true, desc = "Type check" })
