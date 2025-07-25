vim.keymap.set("n", "<leader>rr", function()
  vim.cmd("GoRun")
end, { silent = true, desc = "Go Run" })

vim.keymap.set("n", "<leader>rt", function()
  vim.cmd("GoTest")
end, { silent = true, desc = "Go Test All" })

vim.keymap.set("n", "<leader>rv", function()
  vim.cmd("GoTest -v")
end, { silent = true, desc = "Go Test Current File" })

vim.keymap.set("n", "<leader>rf", function()
  vim.cmd("GoTestFunc")
end, { silent = true, desc = "Go Test Current Function" })

vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4

vim.opt_local.makeprg = "go build"
vim.opt_local.errorformat = "%f:%l:%c: %m,%f:%l: %m"

vim.keymap.set("n", "<leader>cr", "<cmd>!go run %<cr>", { buffer = true, desc = "Run current file" })

vim.keymap.set("n", "<leader>ct", "<cmd>!go test<cr>", { buffer = true, desc = "Run tests" })

vim.keymap.set("n", "<leader>ci", "<cmd>!go mod tidy<cr>", { buffer = true, desc = "Tidy modules" })

vim.keymap.set("n", "<leader>cg", "<cmd>!go generate<cr>", { buffer = true, desc = "Generate code" })

vim.keymap.set("n", "<leader>cv", "<cmd>!go vet<cr>", { buffer = true, desc = "Vet code" })
