if vim.fn.executable("nimble") == 0 then
  return
end

vim.opt.makeprg = "nimble build"
vim.opt.errorformat = "%f(%l, %c) %t: %m"
