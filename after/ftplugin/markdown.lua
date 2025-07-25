vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2

vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 80
vim.opt_local.conceallevel = 2
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldlevel = 1

vim.keymap.set("n", "<leader>cp", "<cmd>!pandoc % -o %:r.pdf<cr>", { buffer = true, desc = "Convert to PDF" })

vim.keymap.set("n", "<leader>ch", "<cmd>!pandoc % -o %:r.html<cr>", { buffer = true, desc = "Convert to HTML" })

vim.keymap.set("n", "<leader>cv", "<cmd>!grip % --browser<cr>", { buffer = true, desc = "Preview with Grip" })

vim.keymap.set("n", "<leader>cl", "<cmd>!markdownlint %<cr>", { buffer = true, desc = "Lint markdown" })
