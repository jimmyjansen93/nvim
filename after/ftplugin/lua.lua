local set = vim.opt_local
set.shiftwidth = 2

vim.keymap.set('n', '<leader>X', '<cmd>source %<CR>')
vim.keymap.set('n', '<leader>x', ':.load<CR>')
vim.keymap.set('v', '<leader>x', ':lua<CR>')
