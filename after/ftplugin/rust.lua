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
