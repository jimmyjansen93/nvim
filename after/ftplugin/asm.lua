vim.opt_local.shiftwidth = 8
vim.opt_local.softtabstop = 8
vim.opt_local.expandtab = false
vim.opt_local.tabstop = 8

vim.opt_local.makeprg = "nasm"

vim.bo.commentstring = "; %s"

vim.cmd("compiler asm")

vim.keymap.set("n", "<leader>rb", "<cmd>make<cr>", { buffer = true, desc = "Build assembly" })

vim.keymap.set("n", "<leader>rr", function()
  local file = vim.fn.expand("%:r")
  vim.cmd("!./" .. file)
end, { buffer = true, desc = "Run executable" })
