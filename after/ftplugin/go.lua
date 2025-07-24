vim.keymap.set('n', '<leader>rr', function()
  vim.cmd 'GoRun'
end, { silent = true, desc = 'Go Run' })

vim.keymap.set('n', '<leader>rt', function()
  vim.cmd 'GoTest'
end, { silent = true, desc = 'Go Test All' })

vim.keymap.set('n', '<leader>rv', function()
  vim.cmd 'GoTest -v'
end, { silent = true, desc = 'Go Test Current File' })

vim.keymap.set('n', '<leader>rf', function()
  vim.cmd 'GoTestFunc'
end, { silent = true, desc = 'Go Test Current Function' })

-- Go-specific settings
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = false  -- Go uses tabs
vim.opt_local.tabstop = 4

-- Additional build keymaps
vim.keymap.set('n', '<leader>cb', '<cmd>!go build<cr>', 
  { buffer = true, desc = 'Build Go project' })

vim.keymap.set('n', '<leader>ci', '<cmd>!go install<cr>', 
  { buffer = true, desc = 'Install Go project' })
