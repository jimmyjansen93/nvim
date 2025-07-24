vim.keymap.set('n', '<leader>ca', function()
  vim.cmd.RustLsp 'codeAction'
end, { silent = true, desc = 'Rust Code Action' })

vim.keymap.set('n', 'K', function()
  vim.cmd.RustLsp { 'hover', 'actions' }
end, { silent = true, desc = 'Rust Hover documentation' })

vim.keymap.set('n', '<leader>rr', function()
  vim.cmd.RustLsp 'run'
end, { desc = 'Cargo Run' })

vim.keymap.set('n', '<leader>re', function()
  vim.cmd.RustLsp { 'run', bang = true }
end, { desc = 'Cargo Run Previous' })

vim.keymap.set('n', '<leader>ce', function()
  vim.cmd.RustLsp 'explainError'
end, { desc = 'Rust Explain error' })

vim.keymap.set('n', '<leader>co', function()
  vim.cmd.RustLsp 'openCargo'
end, { desc = 'Open cargo.toml' })

vim.keymap.set('n', '<leader>cD', function()
  vim.cmd.RustLsp 'openDocs'
end, { desc = 'Open Docs' })

-- Rust-specific settings
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 4

-- Additional cargo commands
vim.keymap.set('n', '<leader>cb', '<cmd>!cargo build<cr>', 
  { buffer = true, desc = 'Cargo build' })

vim.keymap.set('n', '<leader>ct', '<cmd>!cargo test<cr>', 
  { buffer = true, desc = 'Cargo test' })

vim.keymap.set('n', '<leader>cc', '<cmd>!cargo check<cr>', 
  { buffer = true, desc = 'Cargo check' })

vim.keymap.set('n', '<leader>cC', '<cmd>!cargo clippy<cr>', 
  { buffer = true, desc = 'Cargo clippy' })
