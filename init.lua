require 'options'
require 'keymaps'
require 'autocmds'
require 'neovide'
require 'lsp'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    dependencies = {
      'echasnovski/mini.nvim',
    },
    config = function()
      require('which-key').setup {
        sort = { 'local', 'case', 'group' },
      }

      -- :NvimWebDeviconsHiTest
      local webicon = require 'nvim-web-devicons'
      local runIcon = webicon.get_icon('test.jsx', 'jsx')
      local troubleIcon = webicon.get_icon('log', 'log')
      local neovimIcon = webicon.get_icon('DevIconVim', 'vim')

      require('which-key').add {
        {
          '<leader>b',
          group = 'Buffers',
          expand = function()
            return require('which-key.extras').expand.buf()
          end,
        },
        { '<leader>c', group = 'Code' },
        { '<leader>d', group = 'Debug' },
        { '<leader>f', group = 'File' },
        { '<leader>g', group = 'Git' },
        { '<leader>gc', group = 'Conflicts' },
        { '<leader>n', group = 'Neovim', icon = neovimIcon },
        { '<leader>p', group = 'Project' },
        { '<leader>r', group = 'Run', icon = runIcon },
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Terminal' },
        {
          '<leader>w',
          function()
            require('which-key').show {
              keys = '<c-w>',
              loop = true,
            }
          end,
          group = 'Windows',
        },
        { '<leader>x', group = 'Trouble', icon = troubleIcon },
      }
    end,
  },

  { import = 'jimmy.plugins' },
}, { checker = { notify = false }, change_detection = { notify = false } })

-- vim: ts=2 sts=2 sw=2 et
