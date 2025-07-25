vim.cmd([[
  if exists("current_compiler")
    finish
  endif
  let current_compiler = "javascript"
]])

vim.opt_local.makeprg = "node %"

vim.opt_local.errorformat = table.concat({
  "%f:%l:%c %m",
  "%f:%l: %m",
  "%C%*\\s%m",
  "%-G%.%#",
}, ",")
