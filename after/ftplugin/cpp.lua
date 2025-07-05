vim.cmd 'comp! harv'

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.tabstop = 4

local timer = vim.uv.new_timer()
if timer == nil then
  return
end

timer:start(
  60000,
  60000,
  vim.schedule_wrap(function()
    vim.loop.spawn(
      'ctags',
      ---@diagnostic disable-next-line: missing-fields
      {
        args = { '-R', '.' },
        cwd = vim.fn.getcwd(),
        detached = true,
      },
      vim.schedule_wrap(function()
        vim.notify('Ctags update complete.', vim.log.levels.INFO, { title = 'Ctags' })
      end)
    )
  end)
)

require('which-key').add {
  {
    '<leader>cc',
    '<CMD>copen<CR>',
    desc = 'Open quickfix',
  },
  {
    '<leader>cn',
    '<CMD>cnext<CR>',
    desc = 'Next quickfix',
  },
  {
    '<leader>cp',
    '<CMD>cprevious<CR>',
    desc = 'Prev quickfix',
  },
  {
    '<leader>cl',
    '<CMD>clist<CR>',
    desc = 'List quickfix',
  },
  {
    '<leader>ch',
    '<CMD>compiler harv<CR>',
    desc = 'Compiler! harv',
  },
  -- {
  --   '<leader>cb',
  --   '<CMD>compiler harv-build<CR>',
  --   desc = 'Compiler! harv-build',
  -- },
  {
    '<leader>r',
    group = 'Run',
  },
  {
    '<leader>rb',
    '<CMD>!./build build<CR>',
    desc = 'Build project',
  },
  {
    '<leader>rr',
    '<CMD>!./build run<CR>',
    desc = 'Run project',
  },
  {
    '<leader>rt',
    '<CMD>!./build test<CR>',
    desc = 'Test project',
  },
}
