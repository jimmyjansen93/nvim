vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2

local webicon = require("nvim-web-devicons")
local sourceIcon = webicon.get_icon("DevIconLua", "lua")
vim.keymap.set("n", "<leader>cr", "<cmd>luafile %<cr>", { buffer = true, desc = "Run current file" })

vim.keymap.set("n", "<leader>cs", "<cmd>source %<cr>", { buffer = true, desc = "Source file" })

require("which-key").add({
  {
    "<leader>z",
    '<CMD>source %<CR><CMD>lua print "Sourced"<CR>',
    desc = "Source lua",
    icon = sourceIcon,
  },
})
