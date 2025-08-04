if vim.fn.executable("nimble") == 0 then
  return
end

vim.opt_local.makeprg = "nimble build"
vim.opt.errorformat = "%f(%l, %c) %t: %m"
