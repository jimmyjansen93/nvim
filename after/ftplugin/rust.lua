vim.keymap.set("n", "<leader>ca", function()
  vim.cmd.RustLsp("codeAction")
end, { silent = true, desc = "Rust Code Action" })

vim.keymap.set("n", "K", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, { silent = true, desc = "Rust Hover documentation" })

vim.keymap.set("n", "<leader>rr", function()
  vim.cmd.RustLsp("run")
end, { desc = "Cargo Run" })

vim.keymap.set("n", "<leader>re", function()
  vim.cmd.RustLsp({ "run", bang = true })
end, { desc = "Cargo Run Previous" })

vim.keymap.set("n", "<leader>ce", function()
  vim.cmd.RustLsp("explainError")
end, { desc = "Rust Explain error" })

vim.keymap.set("n", "<leader>co", function()
  vim.cmd.RustLsp("openCargo")
end, { desc = "Open cargo.toml" })

vim.keymap.set("n", "<leader>cD", function()
  vim.cmd.RustLsp("openDocs")
end, { desc = "Open Docs" })

vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4

vim.opt_local.makeprg = "cargo build"
vim.opt_local.errorformat = "%E%f:%l:%c: %*\\d:%*\\d error: %m,%W%f:%l:%c: %*\\d:%*\\d warning: %m,%C%*\\s--> %f:%l:%c"

vim.keymap.set("n", "<leader>cr", "<cmd>!cargo run<cr>", { buffer = true, desc = "Run current file" })

vim.keymap.set("n", "<leader>ct", "<cmd>!cargo test<cr>", { buffer = true, desc = "Run tests" })

vim.keymap.set("n", "<leader>cc", "<cmd>!cargo check<cr>", { buffer = true, desc = "Check code" })

vim.keymap.set("n", "<leader>cd", "<cmd>!cargo doc --open<cr>", { buffer = true, desc = "Open docs" })

vim.keymap.set("n", "<leader>cl", "<cmd>!cargo clippy<cr>", { buffer = true, desc = "Lint with clippy" })
