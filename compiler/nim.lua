if vim.fn.executable("nim") == 0 then
  return
end

vim.opt_local.makeprg = "nim compile --verbosity:0 --hints:off %"
vim.opt.errorformat = "%f(%l, %c) %t: %m"
