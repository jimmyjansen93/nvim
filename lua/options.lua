vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.termguicolors = true

vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.writebackup = true

vim.opt.cmdheight = 1

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'
vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 250

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
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

-- Disable virtual text by default
vim.diagnostic.config { virtual_text = true }

vim.opt.hlsearch = true
