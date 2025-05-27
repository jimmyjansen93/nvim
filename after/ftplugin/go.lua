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
