vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to previous Diagnostic message" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to next Diagnostic message" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>tt", function()
  vim.cmd.tabnew()
  vim.cmd.terminal()
  vim.cmd.startinsert()
end, { desc = "Open terminal" })

vim.keymap.set("n", "<leader>nc", function()
  local config_path = vim.fn.stdpath("config")
  vim.cmd("cd " .. config_path)
  vim.cmd("e init.lua")
end, { desc = "Open configuration" })

vim.keymap.set("n", "<leader>nl", function()
  vim.cmd("Lazy")
end, { desc = "Open Lazy" })

vim.keymap.set({ "n", "x" }, "j", function()
  return vim.v.count > 0 and "j" or "gj"
end, { noremap = true, expr = true })

vim.keymap.set({ "n", "x" }, "k", function()
  return vim.v.count > 0 and "k" or "gk"
end, { noremap = true, expr = true })

vim.keymap.set("n", "<A-j>", ":m+1<CR>", { silent = true })
vim.keymap.set("n", "<A-k>", ":m-2<CR>", { silent = true })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })
