-- C-specific settings
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2

-- Enable format on save with clang-format if available
if vim.fn.executable('clang-format') == 1 then
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

-- C-specific keymaps
vim.keymap.set('n', '<leader>cr', '<cmd>!gcc -o %< % && ./%<<cr>', 
  { buffer = true, desc = 'Compile and run C file' })

vim.keymap.set('n', '<leader>cc', '<cmd>!gcc -Wall -Wextra -g -o %< %<cr>', 
  { buffer = true, desc = 'Compile C file with debug info' })

-- Include guard snippet for header files
if vim.fn.expand('%:e') == 'h' then
  vim.keymap.set('n', '<leader>cg', function()
    local guard = string.upper(vim.fn.expand('%:t:r')) .. '_H'
    local lines = {
      '#ifndef ' .. guard,
      '#define ' .. guard,
      '',
      '',
      '',
      '#endif /* ' .. guard .. ' */'
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
    vim.api.nvim_win_set_cursor(0, {4, 0})
  end, { buffer = true, desc = 'Insert include guard' })
end