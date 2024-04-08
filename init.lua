vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.termguicolors = true

vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'
vim.opt.relativenumber = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 250

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.o.scrolloff = 999

vim.cmd 'filetype plugin indent on'
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.opt.hlsearch = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous Diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next Diagnostic message' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<S-l>', '<CMD>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-h>', '<CMD>bprev<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<S-q>', '<CMD>bd<cr>', { desc = 'Kill buffer' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
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

--vim.api.nvim_create_autocmd('QuitPre', {
--  pattern = '*.lua',
--  group = vim.api.nvim_create_augroup('jj-autocommit-nvim', { clear = true }),
--  command = [[execute ':silent ! if git rev-parse --git-dir > /dev/null 2>&1 ; then git add . ; git commit -m "Auto-commit: saved %"; git push; fi > /dev/null 2>&1']],
--})

vim.api.nvim_create_autocmd('QuitPre', {
  pattern = 'tmux.conf',
  group = vim.api.nvim_create_augroup('jj-autocommit-tmux', { clear = true }),
  command = [[execute ':silent ! if git rev-parse --git-dir > /dev/null 2>&1 ; then git add . ; git commit -m "Auto-commit: saved %"; git push; fi > /dev/null 2>&1']],
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter', 'ModeChanged' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup('jj-numbertoggle', {}),
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= 'i' then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup('jj-numbertoggle', {}),
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      vim.cmd 'redraw'
    end
  end,
})

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
    config = function()
      require('which-key').setup()

      require('which-key').register {
        ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = 'Run', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
        ['<leader>q'] = { name = 'General', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = 'Trouble', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = 'File', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
        ['<leader>b'] = { name = 'Debug', _ = 'which_key_ignore' },
      }
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        highlight_overrides = {
          all = {
            LineNr = { fg = '#8aadf4' },
            CursorLineNr = { fg = '#ed8796' },
          },
        },
      }
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },

  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- TODO: replace this statusline with a better one
      local statusline = require 'mini.statusline'
      statusline.setup()

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we disable the section for
      -- cursor information because line numbers are already enabled
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return ''
      end

      -- TODO: Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  { import = 'jimmy.plugins' },
}, { checker = { notify = false }, change_detection = {
  notify = false,
} })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
