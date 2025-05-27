vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('jj-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Quit help with q',
  pattern = 'help,qf,netrw',
  group = vim.api.nvim_create_augroup('jj-help-utils', { clear = true }),
  callback = function()
    vim.keymap.set('n', 'q', '<C-w>c', { buffer = true, desc = 'quit' })
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Stop commenting next line',
  group = vim.api.nvim_create_augroup('jj-comments', { clear = true }),
  command = [[set formatoptions -=cro]],
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Disable diagnostic in node_modules',
  pattern = '*/node_modules/*',
  command = 'lua vim.diagnostic.disable(0)',
})

local format_sync_grp = vim.api.nvim_create_augroup('goimports', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})
