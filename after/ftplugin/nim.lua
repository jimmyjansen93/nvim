local set = vim.opt_local
set.shiftwidth = 2

local nimble_files = vim.fs.find('%.nimble', { upward = true, stop = vim.fn.expand '~', type = 'file', limit = 3 })

if #nimble_files > 0 then
  vim.cmd 'compiler nimble'
else
  vim.cmd 'compiler nim'
end

require('which-key').add {
  {
    '<leader>r',
    group = 'Run',
  },
  {
    '<leader>rb',
    '<CMD>!nimble build<CR>',
    desc = 'Build project',
  },
  {
    '<leader>rr',
    '<CMD>!nimble run<CR>',
    desc = 'Run project',
  },
}
