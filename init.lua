vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.termguicolors = true

vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.writebackup = false

vim.opt.cmdheight = 1

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

vim.opt.foldmethod = 'indent'
vim.opt.foldlevelstart = 99

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.o.scrolloff = 20

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

vim.keymap.set({ 'n', 'x' }, 'j', function()
  return vim.v.count > 0 and 'j' or 'gj'
end, { noremap = true, expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', function()
  return vim.v.count > 0 and 'k' or 'gk'
end, { noremap = true, expr = true })

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

--  pattern = '*.lua',
--  group = vim.api.nvim_create_augroup('jj-autocommit-nvim', { clear = true }),
--  command = [[execute ':silent ! if git rev-parse --git-dir > /dev/null 2>&1 ; then git add . ; git commit -m "Auto-commit: saved %"; git push; fi > /dev/null 2>&1']],
--})

vim.api.nvim_create_autocmd('QuitPre', {
  pattern = 'tmux.conf',
  group = vim.api.nvim_create_augroup('jj-autocommit-tmux', { clear = true }),
  command = [[execute ':silent ! if git rev-parse --git-dir > /dev/null 2>&1 ; then git add . ; git commit -m "Auto-commit: saved %"; git push; fi > /dev/null 2>&1']],
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
  desc = 'Set relative number in normal mode',
  pattern = '*',
  group = vim.api.nvim_create_augroup('jj-numbertoggle-enable', { clear = true }),
  command = [[set relativenumber | set number]],
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  desc = 'Set absolute number in insert mode',
  pattern = '*',
  group = vim.api.nvim_create_augroup('jj-numbertoggle-disable', { clear = true }),
  command = [[set norelativenumber | set number]],
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Disable diagnostic in node_modules',
  pattern = '*/node_modules/*',
  command = 'lua vim.diagnostic.disable(0)',
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
        ['<leader>d'] = { name = 'Debug', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = 'Run', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = 'Trouble', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = 'File', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
        ['<leader>gc'] = { name = 'Conflicts', _ = 'which_key_ignore' },
      }
    end,
  },

  { 'numToStr/Comment.nvim', lazy = false, opts = {} },
  { 'gpanders/editorconfig.nvim' },
  { 'ThePrimeagen/vim-be-good' },
  { 'stevearc/dressing.nvim', event = 'VeryLazy' },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
  { 'vhyrro/luarocks.nvim', priority = 1000, config = true },
  { 'b0o/schemastore.nvim', lazy = true },
  { 'dmmulroy/tsc.nvim', dependencies = { 'rcarriga/nvim-notify' }, opts = {} },
  { 'dmmulroy/ts-error-translator.nvim' },
  { 'nvim-focus/focus.nvim', version = false },

  { import = 'jimmy.plugins' },
}, { checker = { notify = false }, change_detection = {
  notify = false,
} })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
